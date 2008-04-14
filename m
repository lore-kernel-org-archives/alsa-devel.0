From: =?ISO-8859-2?Q?N=E9meth_M=E1rton?= <nm127@freemail.hu>
Subject: via82xx: how to get microphone working?
Date: Mon, 14 Apr 2008 08:55:12 +0200
Message-ID: <4802FFD0.1000302@freemail.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail00d.mail.t-online.hu (mail00d.mail.t-online.hu [84.2.42.5])
	by alsa0.perex.cz (Postfix) with ESMTP id 7754424470
	for <alsa-devel@alsa-project.org>;
	Mon, 14 Apr 2008 08:55:17 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

I have a Clevo D410J laptop with the following integrated sound card:

00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235/8=
237 AC97 Audio Controller (rev 50)
        Subsystem: CLEVO/KAPOK Computer Unknown device 4702
        Flags: medium devsel, IRQ 20
        I/O ports at 1400 [size=3D256]
        Capabilities: [c0] Power Management version 2
        Kernel driver in use: VIA 82xx Audio
        Kernel modules: snd-via82xx

There is also an integrated modem which also appears in kmix/alsamixer:

00:11.6 Communication controller: VIA Technologies, Inc. AC'97 Modem Contro=
ller (rev 80)
        Subsystem: CLEVO/KAPOK Computer Unknown device 4702
        Flags: medium devsel, IRQ 20
        I/O ports at 1800 [size=3D256]
        Capabilities: [d0] Power Management version 2
        Kernel driver in use: VIA 82xx Modem
        Kernel modules: snd-via82xx-modem

I am using Linux 2.6.23. I enabled the microphone input, increased the micr=
ophone
record level to maximum, and enabled "Mic Boost". I can hear my voice throu=
gh the
speakers, but I cannot record sound (for example Skype cannot record my sou=
nd). The
playback is working fine without any problem.

Is there any setting I miss?


$ lsmod |grep snd
snd_via82xx            22572  1
snd_mpu401_uart         7064  1 snd_via82xx
snd_seq_oss            29328  0
snd_seq_midi            6432  0
snd_seq_midi_event      6536  2 snd_seq_oss,snd_seq_midi
snd_via82xx_modem      11408  1
snd_ac97_codec         95676  2 snd_via82xx,snd_via82xx_modem
ac97_bus                2432  1 snd_ac97_codec
snd_pcm_oss            38208  0
snd_mixer_oss          14216  1 snd_pcm_oss
snd_seq                45752  5 snd_seq_oss,snd_seq_midi,snd_seq_midi_event
snd_pcm                69420  4 snd_via82xx,snd_via82xx_modem,snd_ac97_code=
c,snd_pcm_oss
snd_timer              19356  2 snd_seq,snd_pcm
snd_rawmidi            19136  2 snd_mpu401_uart,snd_seq_midi
snd_seq_device          6932  4 snd_seq_oss,snd_seq_midi,snd_seq,snd_rawmidi
snd                    45476  16
snd_via82xx,snd_mpu401_uart,snd_seq_oss,snd_via82xx_modem,snd_ac97_codec,sn=
d_pcm_oss,snd_mixer_oss,snd_seq,snd_pcm,snd_timer,snd_rawmidi,snd_seq_device
snd_page_alloc          8072  3 snd_via82xx,snd_via82xx_modem,snd_pcm
soundcore               6496  1 snd


Regards,

	M=E1rton N=E9meth
