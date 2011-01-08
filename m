From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [bisected] snd_hda_intel, 2.6.37: automuting on
 headphone connect broken; headphone connecter no longer shown in userspace
Date: Sat, 8 Jan 2011 16:23:31 +0800
Message-ID: <AANLkTimewrF3hHvtNTiqxQ6ru8KG1koSQiYcAOoj1sX2@mail.gmail.com>
References: <AANLkTi=Fza-mJyAKtsryAUMMgPoXur4oQ6F2keBmxF6B@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 42FAE10382C
	for <alsa-devel@alsa-project.org>; Sat,  8 Jan 2011 09:23:34 +0100 (CET)
Received: by eyg24 with SMTP id 24so7536256eyg.38
	for <alsa-devel@alsa-project.org>; Sat, 08 Jan 2011 00:23:33 -0800 (PST)
In-Reply-To: <AANLkTi=Fza-mJyAKtsryAUMMgPoXur4oQ6F2keBmxF6B@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/1/5 Nirbheek Chauhan <nirbheek.chauhan@gmail.com>

> Hello,
>
> Upon upgrading to 2.6.37,
> auto-muting-laptop-speakers-on-headphone-connect stopped working, and
> the headphone connector completely disappeared from alsamixer as well
> as the pulseaudio volume control panel. The headphone jack was still
> transmitting sound, though.
>
> I bisected the problem, with 'good' being v2.6.36, and found the
> commit below as the first bad commit. Reverting it on v2.6.37 fixes
> the problem. I also tried the latest alsa-kernel master git tree,
> which had the same problem.
>
> alsa-info when 'good':
>
> http://www.alsa-project.org/db/?f=a0b5c95f764a0b01746be46f989685996e1f9210
>
> alsa-info when 'bad':
>
> http://www.alsa-project.org/db/?f=30f30ca5461f03b98ab6c7c611cf24ea4526f537
>
>
if your Dell Studio 1458 have dual HP Out at Ext Right - node  0x19 and 0x1b
, the latest driver seem put them into line_out  instead of hp_outs

hda_codec: ALC665: BIOS auto-probing.
autoconfig: line_outs=2 (0x19/0x1b/0x0/0x0/0x0)
   speaker_outs=1 (0x15/0x0/0x0/0x0/0x0)
   hp_outs=0 (0x0/0x0/0x0/0x0/0x0)
   mono: mono_out=0x0
   inputs: Internal Mic=0x12 Mic=0x1a
