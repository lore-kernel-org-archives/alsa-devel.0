From: Arve Knudsen <aknuds-1@broadpark.no>
Subject: Re: [Alsa-devel][OT] Which API to use for simple clients?
Date: Mon, 05 Jan 2004 18:13:23 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <opr1bbgln0q1sf88@mail.broadpark.no>
References: <20040102181512.9272.3@llama.ing-simmons.net>   <opr07br2w0q1sf88@mail.broadpark.no>   <20040104120057.9272.13@llama.ing-simmons.net>   <opr09c5cvcq1sf88@mail.broadpark.no>   <20040105092621.2782.3@llama.elixent.com>   <opr1axlkxxq1sf88@mail.broadpark.no>   <20040105133633.17708.4@llama.elixent.com>   <opr1a3u1eoq1sf88@mail.broadpark.no> <20040105155546.17708.6@llama.elixent.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040105155546.17708.6@llama.elixent.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 05 Jan 2004 15:55:46 +0000, <nick@ing-simmons.net> wrote:

> Arve Knudsen <aknuds-1@broadpark.no> writes:
>>>>>
>>>>> My ALSA card is quite capable of doing 44100
>>>>>
>>>> Can you verify that the ALSA API is in use, after configuring out OS=
S
>>>> and
>>>> JACK? I cannot see why this test should fail, granted your card=20
>>>> supports
>>>> the given samplerate. If you could be bothered, perhaps you could ad=
d
>>>> some
>>>> debug output to function SetApproximateSampleRate at
>>>> pa_linux_alsa/pa_linux_alsa.c: 1575? Ie. you could verify that the
>>>> correct
>>>> samplerate is indeed passed to ALSA-lib, and that ALSA-lib rejects i=
t.
>>>
>>> SetApproximateSampleRate is @ line 1583 in my copy:
>>> Making that :
>>>
>>>     err =3D snd_pcm_hw_params_set_rate( pcm, hwParams, approx, dir );
>>>     printf("%s approx=3D%lu rate=3D%d dir=3D%d\n",
>>>            __FUNCTION__,approx, err, dir);
>>>
>>>     return err;
>>>
>>> Yields:
>>>
>>> nick@llama:~/portaudio> bin/patest_sine_formats
>>> PortAudio Test: output Signed 16 Bit
>>> SetApproximateSampleRate approx=3D44100 rate=3D-22 dir=3D0
>>> Host API: ALSA
>>> An error occured while using the portaudio stream
>>> Error number: -9997
>>> Error message: Invalid sample rate
>>> nick@llama:~/portaudio>
>>>
>>> Which seems sane. Changing it to:
>>>
>>>     err =3D snd_pcm_hw_params_set_rate_near( pcm, hwParams, &approx, =
&dir
>>> );
>>>     printf("%s approx=3D%lu rate=3D%d dir=3D%d\n",
>>>            __FUNCTION__,approx, err, dir);
>>>
>>>     return err;
>>>
>>> Yields:
>>>
>>> nick@llama:~/portaudio> bin/patest_sine_formats
>>> PortAudio Test: output Signed 16 Bit
>>> SetApproximateSampleRate approx=3D48000 rate=3D0 dir=3D0
>>> Host API: ALSA
>>> Waiting 10 seconds for sound to finish.
>>> PortAudio Test Finished: Signed 16 Bit
>>>
>>> So perhaps my card does _NOT_ support 44100Hz after all.
>>> This is the card as autodetected/configured by SuSE9.0's YaST.
>>> Seems there are options to play with including the clock rate
>>> but I don't know what I am doing ...
>>>
>> It looks like you got PortAudio working at least :)
>
> Well if you consider 48000 "near" 44100 ...
>
This doesn't have to do with PortAudio, frankly. PortAudio does not=20
convert samplerates, it will be constrained by the host device.

>> You can also look up
>> the PaDeviceInfo struct for any device, to check out the default sampl=
e
>> rate. I think the ALSA plughw device will convert the samplerate to a
>> hardware supported one for you, so that might be your best bet?
>
> I think so - googling for 8235 and 44100 shows I am not the 1st to
> have this kind of problem...
>
>> I have
>> never used the PCM plugin myself, but its possible to specify a custom
>> device string with pa_linux_alsa. If you look in the pa_linux_alsa.h=20
>> file,
>> you'll see a custom stream structure, PaAlsaStreamInfo, which basicall=
y
>> can be used like this:
>> PaAlsaStreamInfo alsaStreamInfo;
>> PaStreamParameters outputParameters;
>>
>> PaAlsa_InitializeStreamInfo(&alsaStreamInfo);
>> alsaStreamInfo.deviceString =3D "plughw:0,0";
>>
>> outputParameters.device =3D paUseHostApiSpecificDeviceSpecification;
>> outputParameters.hostApiSpecificStreamInfo =3D &alsaStreamInfo;
>>
>> It's device string will then be used when opening the output device.
>
> But having a custom string then means I need to know that
>   A. PortAudio is using ALSA
>   B. This user's ALSA hw device cannot do my rate
PortAudio allows you to test a given configuration, which is not=20
particular to ALSA.

>   C. Which magic custom string to use.
Some devices (software) are not enumerated by ALSA, so there is no way fo=
r=20
PortAudio to know.

> If I need to know that much I might as well use native ALSA code...
The only reason I mentioned plughw is you might want to convert from 4410=
0=20
to 48000, since your hardware device doesn't support 44k. This is=20
particular to ALSA. Regular hardware devices will be available through=20
PortAudio, requiring no specialized knowledge.

> Surely the whole point of PortAudio is that app says
> "open sound card for 44100Hz, 16-bit, 2 channels"
> and the PortAudio layer figures out how to do that?
>
Like I pointed out earlier, PortAudio performs no samplerate conversion=20
(nor will it provide more or less channels than the device supports). The=
=20
point, as I see it, is cross platform abstraction (with benefits such as=20
buffer adaption and bitdepth conversion). Wether a card supports a=20
specific configuration can be tested, or you can go with the defaults.=20
However, certain API's have their own ways of doing things. ALSA offers=20
software devices, such as plughw, which are not currently enumerated alon=
g=20
with the other devices. So in order to use plughw, you will have to pass =
a=20
custom device string. This requires specialized knowledge in the client=20
app of course, but its the best solution I've come up with. This is=20
getting entirely offtopic though, maybe we best discuss this on the=20
PortAudio list? If you're still interested in the API that is.

Regards

Arve Knudsen


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
