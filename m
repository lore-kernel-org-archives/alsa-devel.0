From: Arve Knudsen <aknuds-1@broadpark.no>
Subject: Re: Which API to use for simple clients?
Date: Mon, 05 Jan 2004 15:29:15 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <opr1a3u1eoq1sf88@mail.broadpark.no>
References: <20040102181512.9272.3@llama.ing-simmons.net>   <opr07br2w0q1sf88@mail.broadpark.no>   <20040104120057.9272.13@llama.ing-simmons.net>   <opr09c5cvcq1sf88@mail.broadpark.no>   <20040105092621.2782.3@llama.elixent.com>   <opr1axlkxxq1sf88@mail.broadpark.no> <20040105133633.17708.4@llama.elixent.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040105133633.17708.4@llama.elixent.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: nick@img-simmons.net
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 05 Jan 2004 13:36:33 +0000, <nick@img-simmons.net> wrote:

>>>>> patest_sine_formats hangs apparently forever.
>>>> Sounds weird. Works perfectly with my setup. Can you tell me which o=
ne
>>>> of
>>>> the underlying host APIs (JACK/OSS/ALSA) is being used?
>>>
>>> Can you tell me how to tell?
>>>
>> You can use something like this to print the API name:
>> printf("Host API: %s\n",=20
>> Pa_GetHostApiInfo(Pa_GetDefaultHostApi())->name);
>> Unless I explicitly disable it, OSS shows up as default.
>
> That segfaulted 1st place I put it. Putting it after the open
> works

Oh yeah, sorry, I forgot to mention it has to come after the Pa_Initializ=
e=20
call. My bad :|

>>> nick@llama:~/portaudio> !1025
>>> bin/patest_sine_formats
>>> PortAudio Test: output Signed 16 Bit
>>> An error occured while using the portaudio stream
>>> Error number: -9997
>>> Error message: Invalid sample rate
>>>
>>> My ALSA card is quite capable of doing 44100
>>>
>> Can you verify that the ALSA API is in use, after configuring out OSS=20
>> and
>> JACK? I cannot see why this test should fail, granted your card suppor=
ts
>> the given samplerate. If you could be bothered, perhaps you could add=20
>> some
>> debug output to function SetApproximateSampleRate at
>> pa_linux_alsa/pa_linux_alsa.c: 1575? Ie. you could verify that the=20
>> correct
>> samplerate is indeed passed to ALSA-lib, and that ALSA-lib rejects it.
>
> SetApproximateSampleRate is @ line 1583 in my copy:
> Making that :
>
>     err =3D snd_pcm_hw_params_set_rate( pcm, hwParams, approx, dir );
>     printf("%s approx=3D%lu rate=3D%d dir=3D%d\n",
>            __FUNCTION__,approx, err, dir);
>
>     return err;
>
> Yields:
>
> nick@llama:~/portaudio> bin/patest_sine_formats
> PortAudio Test: output Signed 16 Bit
> SetApproximateSampleRate approx=3D44100 rate=3D-22 dir=3D0
> Host API: ALSA
> An error occured while using the portaudio stream
> Error number: -9997
> Error message: Invalid sample rate
> nick@llama:~/portaudio>
>
> Which seems sane. Changing it to:
>
>     err =3D snd_pcm_hw_params_set_rate_near( pcm, hwParams, &approx, &d=
ir=20
> );
>     printf("%s approx=3D%lu rate=3D%d dir=3D%d\n",
>            __FUNCTION__,approx, err, dir);
>
>     return err;
>
> Yields:
>
> nick@llama:~/portaudio> bin/patest_sine_formats
> PortAudio Test: output Signed 16 Bit
> SetApproximateSampleRate approx=3D48000 rate=3D0 dir=3D0
> Host API: ALSA
> Waiting 10 seconds for sound to finish.
> PortAudio Test Finished: Signed 16 Bit
>
> So perhaps my card does _NOT_ support 44100Hz after all.
> This is the card as autodetected/configured by SuSE9.0's YaST.
> Seems there are options to play with including the clock rate
> but I don't know what I am doing ...
>
It looks like you got PortAudio working at least :) You can also look up=20
the PaDeviceInfo struct for any device, to check out the default sample=20
rate. I think the ALSA plughw device will convert the samplerate to a=20
hardware supported one for you, so that might be your best bet? I have=20
never used the PCM plugin myself, but its possible to specify a custom=20
device string with pa_linux_alsa. If you look in the pa_linux_alsa.h file=
,=20
you'll see a custom stream structure, PaAlsaStreamInfo, which basically=20
can be used like this:
PaAlsaStreamInfo alsaStreamInfo;
PaStreamParameters outputParameters;

PaAlsa_InitializeStreamInfo(&alsaStreamInfo);
alsaStreamInfo.deviceString =3D "plughw:0,0";

outputParameters.device =3D paUseHostApiSpecificDeviceSpecification;
outputParameters.hostApiSpecificStreamInfo =3D &alsaStreamInfo;

It's device string will then be used when opening the output device.

Hope this helps

Arve Knudsen


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
