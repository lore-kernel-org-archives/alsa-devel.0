From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Drivers from tiwai/sound.git - module snd_seq_midi
 not compiled?
Date: Tue, 6 Mar 2012 10:07:49 +0800
Message-ID: <CAN8cciZbVjNOP6f9zVBntt2jZTwMq1BRSMUn-411aoOsWgPqLg@mail.gmail.com>
References: <4F53DC2B.3040400@ivitera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id CE020243BA
	for <alsa-devel@alsa-project.org>; Tue,  6 Mar 2012 03:07:49 +0100 (CET)
Received: by wgbed3 with SMTP id ed3so2951600wgb.20
	for <alsa-devel@alsa-project.org>; Mon, 05 Mar 2012 18:07:49 -0800 (PST)
In-Reply-To: <4F53DC2B.3040400@ivitera.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA development <alsa-devel@alsa-project.org>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

2012/3/5, Pavel Hofman <pavel.hofman@ivitera.com>:
> Hi,
>
> My midi keyboard is not listed in aconnect -i -l upon installing drivers
> from Takashi's git using gitcompile/make install. However, when I
> reinstall the whole kernel package 3.1.5 (from some ubuntu ppa), the
> midi works ok again.
>
> I compared loaded modules and found out for my hand-compiled drivers
> from git the module snd_seq_midi is missing. I re-run the compilation.
> Here is what I get at the beginning:
>
> utils/mod-deps --basedir
> /home/pavel/projects/alsa-tiwai/alsa-driver-build/alsa-kernel
> --hiddendir /home/pavel/projects/alsa-tiwai/alsa-driver-build
> --versiondep
> /home/pavel/projects/alsa-tiwai/alsa-driver-build/kconfig-vers
> --makeconf > toplevel.config.in
> can't handle 'default SND_SEQUENCER && SND_RAWMIDI', translating as
> depends on
> can't handle 'default SND_SEQUENCER && SND_OPL3_LIB', translating as
> depends on
> can't handle 'default SND_SEQUENCER && SND_OPL4_LIB', translating as
> depends on
> can't handle 'default SND_SEQUENCER && SND_SBAWE', translating as depends on
> can't handle 'default SND_SEQUENCER && SND_EMU10K1', translating as
> depends on
> can't handle 'default SND_FM801 || SND_ES1968 || RADIO_SF16FMR2',
> translating as depends on
> can't handle word INPUT=y properly, supposing it's OK
> can't handle word INPUT=SND_ES1968 properly, supposing it's OK
> can't handle word VIDEO_V4L2=y properly, supposing it's OK
> can't handle word VIDEO_V4L2=SND_ES1968 properly, supposing it's OK
> can't handle word VIDEO_V4L2=y properly, supposing it's OK
> can't handle word VIDEO_V4L2=SND_FM801 properly, supposing it's OK
> can't handle word INPUT=y properly, supposing it's OK
> can't handle word INPUT=SND_HDA_INTEL properly, supposing it's OK
> can't handle word SND_HDA_INPUT_BEEP=y properly, supposing it's OK
> can't handle word INPUT=y properly, supposing it's OK
> can't handle word INPUT=SND properly, supposing it's OK
> can't handle word INPUT=y properly, supposing it's OK
> can't handle word INPUT=SND_MAESTRO3 properly, supposing it's OK
> can't handle word INPUT=y properly, supposing it's OK
> can't handle word INPUT=SND_USB_CAIAQ properly, supposing it's OK
> can't handle word I2C=y properly, supposing it's OK
> can't handle word I2C=y properly, supposing it's OK
> can't handle word I2C=y properly, supposing it's OK
> utils/mod-deps --basedir
> /home/pavel/projects/alsa-tiwai/alsa-driver-build/alsa-kernel
> --hiddendir /home/pavel/projects/alsa-tiwai/alsa-driver-build
> --versiondep
> /home/pavel/projects/alsa-tiwai/alsa-driver-build/kconfig-vers
> --acinclude > acinclude.m4
> can't handle 'default SND_SEQUENCER && SND_RAWMIDI', translating as
> depends on
> can't handle 'default SND_SEQUENCER && SND_OPL3_LIB', translating as
> depends on
> can't handle 'default SND_SEQUENCER && SND_OPL4_LIB', translating as
> depends on
> can't handle 'default SND_SEQUENCER && SND_SBAWE', translating as depends on
> can't handle 'default SND_SEQUENCER && SND_EMU10K1', translating as
> depends on
> can't handle 'default SND_FM801 || SND_ES1968 || RADIO_SF16FMR2',
> translating as depends on
> can't handle word INPUT=y properly, supposing it's OK
> can't handle word INPUT=SND_ES1968 properly, supposing it's OK
> can't handle word VIDEO_V4L2=y properly, supposing it's OK
> can't handle word VIDEO_V4L2=SND_ES1968 properly, supposing it's OK
> can't handle word VIDEO_V4L2=y properly, supposing it's OK
> can't handle word VIDEO_V4L2=SND_FM801 properly, supposing it's OK
> can't handle word INPUT=y properly, supposing it's OK
> can't handle word INPUT=SND_HDA_INTEL properly, supposing it's OK
> can't handle word SND_HDA_INPUT_BEEP=y properly, supposing it's OK
> can't handle word INPUT=y properly, supposing it's OK
> can't handle word INPUT=SND properly, supposing it's OK
> can't handle word INPUT=y properly, supposing it's OK
> can't handle word INPUT=SND_MAESTRO3 properly, supposing it's OK
> can't handle word INPUT=y properly, supposing it's OK
> can't handle word INPUT=SND_USB_CAIAQ properly, supposing it's OK
> can't handle word I2C=y properly, supposing it's OK
> can't handle word I2C=y properly, supposing it's OK
> can't handle word I2C=y properly, supposing it's OK
> utils/mod-deps --basedir
> /home/pavel/projects/alsa-tiwai/alsa-driver-build/alsa-kernel
> --hiddendir /home/pavel/projects/alsa-tiwai/alsa-driver-build
> --versiondep
> /home/pavel/projects/alsa-tiwai/alsa-driver-build/kconfig-vers --include
>> include/config1.h.in
> can't handle 'default SND_SEQUENCER && SND_RAWMIDI', translating as
> depends on
> can't handle 'default SND_SEQUENCER && SND_OPL3_LIB', translating as
> depends on
> can't handle 'default SND_SEQUENCER && SND_OPL4_LIB', translating as
> depends on
> can't handle 'default SND_SEQUENCER && SND_SBAWE', translating as depends on
> can't handle 'default SND_SEQUENCER && SND_EMU10K1', translating as
> depends on
> can't handle 'default SND_FM801 || SND_ES1968 || RADIO_SF16FMR2',
> translating as depends on
> can't handle word INPUT=y properly, supposing it's OK
> can't handle word INPUT=SND_ES1968 properly, supposing it's OK
>
>
> In config.status there is
>
> S["CONFIG_SND_RAWMIDI_SEQ"]=""
>
> I assume there should be "m" instead.
>
> And there is no D["CONFIG_SND_RAWMIDI_SEQ_MODULE"]=" 1" in
> config.status, only:
>
> D["CONFIG_SND_RAWMIDI_MODULE"]=" 1"
> D["CONFIG_SND_SEQUENCER_MODULE"]=" 1"
> ...
>
> As a result, the source acore/seq/seq_midi.c does not get compiled at all.
>
> pavel@nahore:~/projects/alsa-tiwai/alsa-driver-build$ ls -l acore/seq/
> ....
> -rw-r--r-- 1 pavel pavel   13124 2012-03-04 21:53 seq_memory.c
> -rw-r--r-- 1 pavel pavel   12745 2012-03-04 21:53 seq_memory.c.orig
> -rw-r--r-- 1 pavel pavel  126440 2012-03-04 21:54 seq_memory.o
> -rw-r--r-- 1 pavel pavel    1112 2012-03-04 21:41 seq_memory.patch
> -rw-r--r-- 1 pavel pavel      89 2012-03-04 21:41 seq_midi.c       <===
> -rw-r--r-- 1 pavel pavel      75 2012-03-04 21:41 seq_midi_emul.c
> -rw-r--r-- 1 pavel pavel   93676 2012-03-04 21:54 seq_midi_emul.o
> -rw-r--r-- 1 pavel pavel      76 2012-03-04 21:41 seq_midi_event.c
> -rw-r--r-- 1 pavel pavel   95992 2012-03-04 21:54 seq_midi_event.o
> -rw-r--r-- 1 pavel pavel  101100 2012-03-04 21:54 seq.o
> -rw-r--r-- 1 pavel pavel     762 2012-03-04 21:41 seq.patch
> -rw-r--r-- 1 pavel pavel      94 2012-03-04 21:41 seq_ports.c
> -rw-r--r-- 1 pavel pavel  125464 2012-03-04 21:54 seq_ports.o
> ....
>
> Thanks a lot for any suggestion or help.
>

I have to manually change "toplevel.config" so that snd-seq-midi.ko
and snd-opl3-synth.ko can be compiled

Does ymfpci require oss for OPL3 FM Synth ?
