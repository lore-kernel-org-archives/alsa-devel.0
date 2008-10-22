From: "naveen krishna ch" <naveenkrishna.ch@gmail.com>
Subject: Audio on omap3+twl4030 codec
Date: Wed, 22 Oct 2008 18:17:39 +0530
Message-ID: <ef0d8a250810220547u1b795313y47f964144591e97d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from qb-out-1314.google.com (qb-out-1314.google.com [72.14.204.175])
	by alsa0.perex.cz (Postfix) with ESMTP id 218C21037F7
	for <alsa-devel@alsa-project.org>;
	Wed, 22 Oct 2008 14:47:58 +0200 (CEST)
Received: by qb-out-1314.google.com with SMTP id q15so3167391qbq.44
	for <alsa-devel@alsa-project.org>; Wed, 22 Oct 2008 05:47:39 -0700 (PDT)
Content-Disposition: inline
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

Hi all,

I am working on omap3430 and twl4030 combination for audio.

I am wokring on 2.6.26 whre the support was not there for omap3 mcbsp.
so i ported some stuff from the 2.6.27 latest git tree and now audio is
working on omap3 evm.
with the very same kernel when i try with my custom board. I am unable to
hear audoi.

I get audio when i boot out of MMC (x-load and u-boot in mmc and fiel system
is nfs).
But, when i usse nand(x-load and u-boot in nand and file system is on nfs) i
dont get audio  out
meams aplay and arecord seems working but i dont hear any audio.

I probe and checked the Bit clock and Word clock of the I2S which seems are
comming when
 i try a aplay and arecord..

I am sure that hardware has no problem.
Can any one tell me what might be the issue and where i have to start
debugging the issue.

If this is not the right palce to put my question can any one tell me the
correct mailing list.



-- 
Thanks,
NeyO
