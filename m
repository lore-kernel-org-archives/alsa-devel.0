From: John Stile <john@stilen.com>
Subject: snd-hda-intel support for SPDIF-in wiht vt1708 card?
Date: Mon, 17 Dec 2007 10:27:27 -0800
Message-ID: <1197916048.14752.132.camel@genx.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mother.stilen.com (dsl027-182-089.sfo1.dsl.speakeasy.net
	[216.27.182.89])
	by alsa0.perex.cz (Postfix) with ESMTP id 90AF610382D
	for <alsa-devel@alsa-project.org>; Mon, 17 Dec 2007 19:27:55 +0100 (CET)
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

I am trying to use a Via VT1708 audio card ( uses the snd-hda-intel.ko
driver) to record from SPDIF-in.

An off-list reply to my posting to alsa-users list suggested that
snd-hda-intel.ko might not support SPDIF-in with the VT1708 card, which
brought me here.

Can someone who works on the Intel HDA driver tell me if it supports
SPDIF-in on the VT1708 audio card?

Should 'arecord -L' show "Digital Audio Input"?

Environment:
 Audio Card:   VT1708
 ALSA version: 1.0.15 (as gentoo packages)
 Driver:       snd-hda-intel.ko (In-kernel)
 Kernel:       2.6.23-gentoo-r3
 Distribution: Gentoo
 Systemboard:  PX10000G (VIA pico-itx)
 Case:         Serener GS-L08 case
