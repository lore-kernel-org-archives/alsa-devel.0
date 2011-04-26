From: Felix Homann <linuxaudio@showlabor.de>
Subject: Re: USB MIDI Regression? - - Was: Small Regression in
 midi for M-Audio Fast Track Ultra.
Date: Tue, 26 Apr 2011 09:49:17 +0200
Message-ID: <4DB678FD.1030400@showlabor.de>
References: <BANLkTim0nHo5h8FBebrt_e77igtj4tGOgQ@mail.gmail.com>	<4DABF85F.1040408@showlabor.de>
	<BANLkTimsW7Qj_RFMEOjQp7t1gpvz_8_=Rg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060501050604050704020406"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vwp5738.webpack.hosteurope.de (vwp5738.webpack.hosteurope.de
	[83.169.30.203])
	by alsa0.perex.cz (Postfix) with ESMTP id D71B41037E3
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Apr 2011 09:49:34 +0200 (CEST)
In-Reply-To: <BANLkTimsW7Qj_RFMEOjQp7t1gpvz_8_=Rg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------060501050604050704020406
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi Daniel,

nice to "see" you again :-)


Am 23.04.2011 11:09, schrieb Daniel Mack:
>
> Hmm, between these version, there was my huge refactoring of the
> usb-audio code, so this could indeed be related. However, most of my
> patches were for the audio part, and not for MIDI.

It happened on the transition from 2.6.34 to 2.6.35, i.e. exactly 
whithin the refactoring phase. I've sent a bisect log to the list some 
posts before. I've attached it to this mail again, in case you didn't 
see it. The last iteration would not result in a bootable kernel, so 
I've stopped there. (Actually I didn't stop there, but even guessing 
good/bad would not yield a bootable kernel in the next step).

Kind regards,

Felix

--------------060501050604050704020406
Content-Type: text/x-log;
 name="bisect-log-step10.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="bisect-log-step10.log"

git bisect start
# bad: [9fe6206f400646a2322096b56c59891d530e8d51] Linux 2.6.35
git bisect bad 9fe6206f400646a2322096b56c59891d530e8d51
# good: [e40152ee1e1c7a63f4777791863215e3faa37a86] Linus 2.6.34
git bisect good e40152ee1e1c7a63f4777791863215e3faa37a86
# bad: [e0bc5d4a54938eedcde14005210e6c08aa9727e4] Merge branch 'i2c-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/jdelvare/staging
git bisect bad e0bc5d4a54938eedcde14005210e6c08aa9727e4
# bad: [04afb40593f9a3007e5ea817d009529ef10fb685] Merge branch 'acpica' of git://git.kernel.org/pub/scm/linux/kernel/git/lenb/linux-acpi-2.6
git bisect bad 04afb40593f9a3007e5ea817d009529ef10fb685
# good: [e4e47eb15b7884963efe7f98231009c5770a2c3d] Merge branch 'msm-core' of git://codeaurora.org/quic/kernel/dwalker/linux-msm
git bisect good e4e47eb15b7884963efe7f98231009c5770a2c3d
# good: [e8d0416796d43a950ec7b65629e53419b2e22453] V4L/DVB (13554a): v4l: Use the video_drvdata function in drivers
git bisect good e8d0416796d43a950ec7b65629e53419b2e22453
# good: [f39d01be4c59a61a08d0cb53f615e7016b85d339] Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/jikos/trivial
git bisect good f39d01be4c59a61a08d0cb53f615e7016b85d339
# good: [ad8332c1302bcb4f80d593fd3eb477be9d7f5604] ASoC: tpa6130a2: Remove CPVSS and HPVdd supplies
git bisect good ad8332c1302bcb4f80d593fd3eb477be9d7f5604
# bad: [19008bdacb9f7841166ebafe0aef361ee582ffbf] Merge branch 'topic/hda' into for-linus
git bisect bad 19008bdacb9f7841166ebafe0aef361ee582ffbf
# bad: [550a8b691ca67761bbf382d98fbd81d215f1d7f0] ALSA: sound/pci/asihpi: Use kzalloc
git bisect bad 550a8b691ca67761bbf382d98fbd81d215f1d7f0
# bad: [ca4c2adaf2d7efcc43e16c8010cf4c30def75058] ALSA: usb/mixer - use get_iface_desc() rather than direct structure
git bisect bad ca4c2adaf2d7efcc43e16c8010cf4c30def75058

--------------060501050604050704020406
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------060501050604050704020406--
