From: Keith Chew <keith.chew@gmail.com>
Subject: 5.1 surround on 3 jacks (retasking)
Date: Thu, 26 Aug 2010 07:45:45 +1200
Message-ID: <AANLkTin3DKSRuUZwARAadMTVPTrj17eHK8557bCsb3YM@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id B56D224699
	for <alsa-devel@alsa-project.org>;
	Wed, 25 Aug 2010 21:45:46 +0200 (CEST)
Received: by iwn4 with SMTP id 4so825985iwn.38
	for <alsa-devel@alsa-project.org>; Wed, 25 Aug 2010 12:45:45 -0700 (PDT)
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

Hi

I have a small-form factor PC (KingYoung brand, model S645), which has
3 jacks connected to a Realtek ALC888 chipset. I have confirmed with
the manufacturers the pin outs:
1) The front panel left side phone jack : Codec Line2-L & Line2-R (pin
14 & pin 15)
2) The front panel right side phone jack : Codec Mic2-L & Mic2-R (pin
16 & pin 17)
3) The back panel phone jack : Codec Front-L & Front-R (pin 35 & pin 36)

I would like to update patch_realtek.c in alsa-drivers, to output 5.1
surround using these 3 jacks.

Can someone give me some guidance on how I can do this? I have looked
and studied patch_realtek as much as I can, I just need some help in
getting started.

Regards
Keith
