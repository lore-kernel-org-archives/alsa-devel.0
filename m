From: Paulo Cavalcanti <promac@gmail.com>
Subject: Kernel panic with alsa-driver 1.0.21 and RHEL 5
Date: Sat, 5 Sep 2009 19:47:49 -0300
Message-ID: <68720af30909051547ye9ebfe0n7f10e54dcfce5270@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f207.google.com (mail-fx0-f207.google.com
	[209.85.220.207])
	by alsa0.perex.cz (Postfix) with ESMTP id 1D0CA1037F3
	for <alsa-devel@alsa-project.org>;
	Sun,  6 Sep 2009 00:47:50 +0200 (CEST)
Received: by fxm3 with SMTP id 3so1375531fxm.32
	for <alsa-devel@alsa-project.org>; Sat, 05 Sep 2009 15:47:49 -0700 (PDT)
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

I upgraded to alsa 1.0.21 on Fedora 10/11 with no problem at all.

However, I always get a kernel panic when I install alsa-driver 1.0.21
on RHEL 5 (either i386 or x86_63) and reboot:

I have no idea on how to debug this situation. The memory dump
references:

snd_hda_codec ....
snd_hda_intel ...

RHEL 5 runs just fine with alsa-driver 1.0.20, thought.

Thanks.

-- 
Paulo Roma Cavalcanti
LCG - UFRJ
