From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: 5.1 surround on 3 jacks (retasking)
Date: Thu, 26 Aug 2010 15:03:50 +0800
Message-ID: <AANLkTinDrAurZxUzSBo2pqrTKo13d+msLFvjva-+=5ET@mail.gmail.com>
References: <AANLkTin3DKSRuUZwARAadMTVPTrj17eHK8557bCsb3YM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 232E41037FB
	for <alsa-devel@alsa-project.org>;
	Thu, 26 Aug 2010 09:03:51 +0200 (CEST)
Received: by bwz4 with SMTP id 4so980313bwz.38
	for <alsa-devel@alsa-project.org>; Thu, 26 Aug 2010 00:03:50 -0700 (PDT)
In-Reply-To: <AANLkTin3DKSRuUZwARAadMTVPTrj17eHK8557bCsb3YM@mail.gmail.com>
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

2010/8/26 Keith Chew <keith.chew@gmail.com>

> Hi
>
> I have a small-form factor PC (KingYoung brand, model S645), which has
> 3 jacks connected to a Realtek ALC888 chipset. I have confirmed with
> the manufacturers the pin outs:
> 1) The front panel left side phone jack : Codec Line2-L & Line2-R (pin
> 14 & pin 15)
> 2) The front panel right side phone jack : Codec Mic2-L & Mic2-R (pin
> 16 & pin 17)
> 3) The back panel phone jack : Codec Front-L & Front-R (pin 35 & pin 36)
>
> I would like to update patch_realtek.c in alsa-drivers, to output 5.1
> surround using these 3 jacks.
>
> Can someone give me some guidance on how I can do this? I have looked
> and studied patch_realtek as much as I can, I just need some help in
> getting started.
>
> Regards
> Keith
>

The easy way is try those [ALC888_xxx] models with alc88x_3st_6ch_mixer
