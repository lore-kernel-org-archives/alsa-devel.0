From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Aureal issues on resume
Date: Sat, 17 Sep 2011 10:16:19 +0800
Message-ID: <CAN8cciYO_tiu2wQ-Ya6BzUWFuU1rR6N5gR+Vs_SNZ-mfQni4BQ@mail.gmail.com>
References: <4E60F0C1.5020008@ladisch.de>
	<CAN8cciaL8O_wyESQSeYOr=bvmg=0vjBj0Cw0y09q2eQygs9ODQ@mail.gmail.com>
	<4E63E06C.9050109@ladisch.de> <s5hk49e8adj.wl%tiwai@suse.de>
	<s5hk49e6ko4.wl%tiwai@suse.de>
	<CAN8ccibAsP2rPymiGR41O8W2FyT-6sBvRLh28rsBjjCFpH7qXw@mail.gmail.com>
	<s5hk499t3fq.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 36A4F103842
	for <alsa-devel@alsa-project.org>;
	Sat, 17 Sep 2011 04:16:20 +0200 (CEST)
Received: by fxe22 with SMTP id 22so2298237fxe.38
	for <alsa-devel@alsa-project.org>; Fri, 16 Sep 2011 19:16:20 -0700 (PDT)
In-Reply-To: <s5hk499t3fq.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/9/16 Takashi Iwai <tiwai@suse.de>:
> At Fri, 16 Sep 2011 10:16:11 +0800,
> Raymond Yau wrote:
>>
>> 2011/9/12 Takashi Iwai <tiwai@suse.de>:
>> > At Mon, 12 Sep 2011 09:53:28 +0200,
>> > Takashi Iwai wrote:
>> >>
>> >> At Sun, 04 Sep 2011 22:32:44 +0200,
>> >> Clemens Ladisch wrote:
>> >> >
>> >> > Raymond Yau wrote:
>> >> > > The possible way is to save the contents of 128K memory mapped I/O
>> >> > > ports before suspend to non-volatile memory and restore them after
>> >> > > resume
>> >> > >
>> >> > > Is there any way for alsa driver to allocate non-volatile memory ?
>> >> >
>> >> > 'Normal' memory is saved over suspend. =A0Just use {k|v}malloc.
>> >>
>> >> If it's a 128kB bulk memory, vmalloc() is a more sensible choice.
>> >
>> > BTW, in many cases, you don't have to save/restore the whole mmio
>> > region. =A0Instead, stop the stream, save / restore some important
>> > registers and do the similar procedure for the normal prepare callback
>> > in the resume, and restart the stream again.
>> >
>> >
>> > Takashi
>> >
>>
>> The current au8830 alsa driver seem use less than 192Kbytes out of
>> 256Kbytes mmio
>>
>> http://thread.gmane.org/gmane.linux.kernel/564963/focus=3D47907
>>
>> your patch seem initialse the request queue in figure 16 of pat 6167465
>>
>> and the driver need to restore mixer and equalizer mmio for au8830 in fi=
gure 13
>
> Yeah, that's what I mentioned in the thread.
>
> Basically you'll need to restore the values assigned in hw_params()
> for PCM.
>

The error messages are due to snd_vortex_suspend() call snd_vortex_adb_init=
()

There are static routes for the codec, mixin, mixout and equalizer and
dynamic routes of playback/capture streams

Those VORTEX_ADB_RTBASE and VORTEX_ADB_CHNBASE mmio ports are two
linked list, those vortex_route_* function are adding the routes to
the tail of those linked lists

so the only is to restore the routes since the driver does not keep
track of the order of routes of the playback stream  or capture stream
to the linked list

> The mixer is ac97, so it's restored by ac97_codec.c. =A0The rest are the
> equalizer and a3d values to be restored separately.

I mean the hardware mixer (mixin and mixout) inside au88x0 chip.

May be need to initialise mpu401_uart or joystick


Is there any way to force the system to suspend, it seem that gnome
power management in Fedora 10 does not provide any way to suspend
while playing an audio ? ( screen saver set to 1 minutes, put the
computer into sleep when inactive for 2 minutes )

Ubuntu 10.04 Live CD , you can force the system to suspend
