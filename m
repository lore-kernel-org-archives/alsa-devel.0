From: Geoffrey Wossum <gwossum@pager.net>
Subject: i.MX31L + AC97
Date: Wed, 9 Sep 2009 11:10:49 -0500
Message-ID: <200909091110.49628.gwossum@pager.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from barracuda.pager.net (mail.pager.net [209.253.16.30])
	by alsa0.perex.cz (Postfix) with ESMTP id 43E6C244AF
	for <Alsa-devel@alsa-project.org>;
	Wed,  9 Sep 2009 18:10:53 +0200 (CEST)
Received: from LRS-EX2K8.LongRangeSystems.local (localhost [127.0.0.1])
	by barracuda.pager.net (Spam & Virus Firewall) with ESMTP id
	80C6015D9C6
	for <Alsa-devel@alsa-project.org>; Wed,  9 Sep 2009 11:10:46 -0500 (CDT)
Received: from LRS-EX2K8.LongRangeSystems.local
	(lrs-ex2k8.longrangesystems.local [192.168.7.254]) by
	barracuda.pager.net with ESMTP id 4qFZBhlDa7irvqLl for
	<Alsa-devel@alsa-project.org>; Wed, 09 Sep 2009 11:10:46 -0500 (CDT)
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
To: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi all,

I'm currently looking at a board which uses a Freescale i.MX31L connected to a 
Wolfson WM9715L over the AC97 bus.  The WM9715L will be used for both sound 
and a touchscreen.

It doesn't look like there are any AC97 SoC drivers for the i.MX31.  Is this 
correct?  If so, should I try to get the board changed to use a codec on the 
I2S bus (the board is being layed out right now), or would creating the AC97 
driver simple enough that we should continue on with this hardware and write 
the driver when needed?

TIA,
---
Geoffrey
