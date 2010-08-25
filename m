From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: 5.1 surround on 3 jacks (retasking)
Date: Thu, 26 Aug 2010 01:31:37 +0200
Message-ID: <4C75A7D9.1030604@canonical.com>
References: <AANLkTin3DKSRuUZwARAadMTVPTrj17eHK8557bCsb3YM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 622ED24796
	for <alsa-devel@alsa-project.org>;
	Thu, 26 Aug 2010 01:31:40 +0200 (CEST)
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
To: Keith Chew <keith.chew@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2010-08-25 21:45, Keith Chew skrev:
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

My first approach to that problem would be to try to tweak
user_pin_configs, assuming that the generic parser (model=auto) is used.
See sections 4.3 and 4.4 on this document for how to do that:

http://mirror.leaseweb.com/kernel/people/tiwai/docs/HD-Audio.html

That way you won't have to update the kernel code at all.

To figure out the values of user_pin_configs, you'll need to know the
pin widget NIDs (see your /proc/asound/card*/codec* file for that) and
pin values (see official Intel HDA documentation, or read hda_proc.c).

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
