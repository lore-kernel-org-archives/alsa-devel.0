From: Felix Homann <linuxaudio@showlabor.de>
Subject: Re: Small Regression in midi for M-Audio Fast Track
 Ultra.
Date: Wed, 20 Apr 2011 22:25:44 +0200
Message-ID: <4DAF4148.5050600@showlabor.de>
References: <BANLkTim0nHo5h8FBebrt_e77igtj4tGOgQ@mail.gmail.com>	<4DAC0158.6090400@ladisch.de>
	<4DAC0468.4000705@showlabor.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030104030005060909090806"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from vwp5738.webpack.hosteurope.de (vwp5738.webpack.hosteurope.de
	[83.169.30.203])
	by alsa0.perex.cz (Postfix) with ESMTP id 3C9F9103826
	for <alsa-devel@alsa-project.org>;
	Wed, 20 Apr 2011 22:25:47 +0200 (CEST)
In-Reply-To: <4DAC0468.4000705@showlabor.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: tiwai@suse.de, Grant Diffey <gdiffey@gmail.com>, alsa-devel@alsa-project.org, Daniel Mack <daniel@caiaq.de>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------030104030005060909090806
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Sorry, Clemens,

I must have messed around with too many Alsa versions on my machine, again.
Your suggested fix _does_ fix the issue!

Would you mind adding this to the git tree? Or shall I prepare a patch?

Am 18.04.2011 11:16, schrieb Clemens Ladisch:
>> Try replacing the comment with:
>> 			{
>> 				.iface = 3,
>> 				.type = QUIRK_MIDI_STANDARD_INTERFACE
>> 			},
>>

In the meantime I started a bisect session on the mainline kernel. The 
cause of this issue lies in the refactoring done last year. I couldn't 
identify the exact patch introducing the regression, though, since 
starting at step 10 the kernels would not boot. See the corresponding 
git bisect log (the last revision is the first one that would not boot).

Regards,

Felix

--------------030104030005060909090806
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

--------------030104030005060909090806
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------030104030005060909090806--
