From: Arve Knudsen <aknuds-1@broadpark.no>
Subject: Re: Which API to use for simple clients?
Date: Mon, 05 Jan 2004 13:13:58 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <opr1axlkxxq1sf88@mail.broadpark.no>
References: <20040102181512.9272.3@llama.ing-simmons.net>   <opr07br2w0q1sf88@mail.broadpark.no>   <20040104120057.9272.13@llama.ing-simmons.net>   <opr09c5cvcq1sf88@mail.broadpark.no> <20040105092621.2782.3@llama.elixent.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040105092621.2782.3@llama.elixent.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Nick Ing-Simmons <nick.ing-simmons@elixent.com>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>, Nick Ing-Simmons <nick@ing-simmons.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 05 Jan 2004 09:26:21 +0000, Nick Ing-Simmons=20
<nick.ing-simmons@elixent.com> wrote:

> Arve Knudsen <aknuds-1@broadpark.no> writes:
>>>
>>> patest_write_sine produces a noise but it isn't a sine wave (by ear
>>> there are some "sharp edges" in the waveform).
>
> That is the potential killer ... remember one advantage of portaudio
> was the option to use a write() interface...
>
The blocking interface is fully implemented with the ALSA implementation,=
=20
and I use it daily. It would seem there are problems with the OSS one, bu=
t=20
its development branch after all :)

>>>
>>> patest_sine_formats hangs apparently forever.
>> Sounds weird. Works perfectly with my setup. Can you tell me which one=
=20
>> of
>> the underlying host APIs (JACK/OSS/ALSA) is being used?
>
> Can you tell me how to tell?
>
You can use something like this to print the API name:
printf("Host API: %s\n", Pa_GetHostApiInfo(Pa_GetDefaultHostApi())->name)=
;
Unless I explicitly disable it, OSS shows up as default.

>> I just tested the
>> OSS implementation for the first time, and it behaves as you describe.=
 I
>> cannot help you with OSS or JACK I'm afraid, as I concentrate on the=20
>> ALSA
>> bit. I don't know what the current state of OSS and JACK support is,=20
>> but I
>> don't think they've been as regularly updated as the ALSA one. My
>> recommendation, for now, would be to configure PortAudio to compile wi=
th
>> only ALSA support. Then the ALSA host API should be used by default, a=
nd
>> things should work better I think.
>
> Worse:
>
>  1019  make clean
>  1020  make distclean
>  1021  rm config.cache
>  1022  rm config.status
>  1023  ./configure --without-jack --without-oss
>  1024  make
>  1025  bin/patest_sine_formats
>
> nick@llama:~/portaudio> !1025
> bin/patest_sine_formats
> PortAudio Test: output Signed 16 Bit
> An error occured while using the portaudio stream
> Error number: -9997
> Error message: Invalid sample rate
>
> My ALSA card is quite capable of doing 44100
>
Can you verify that the ALSA API is in use, after configuring out OSS and=
=20
JACK? I cannot see why this test should fail, granted your card supports=20
the given samplerate. If you could be bothered, perhaps you could add som=
e=20
debug output to function SetApproximateSampleRate at=20
pa_linux_alsa/pa_linux_alsa.c: 1575? Ie. you could verify that the correc=
t=20
samplerate is indeed passed to ALSA-lib, and that ALSA-lib rejects it.

> This is using a v19 snapshot:
> -rw-rw-r--    1 nick     users      486933 2004-01-04 11:25=20
> /home/nick/tgzs/pa_snapshot_v19.tar.gz
>
> Time/date are GMT.
>
> Adding jack back in makes no difference.
> Adding oss back in gives same fail.
>
> So it seems that it is using oss and it is broken,
> can't say I am surprised - if you recall the original message
> was prompted as I was moving to native ALSA 'cos OSS emulation
> was flakey.
>
I think v19 PortAudio OSS still needs some work, I'm experiencing similar=
=20
problems.

Regards

Arve Knudsen


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
