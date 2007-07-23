From: Timur Tabi <timur@freescale.com>
Subject: How do I tell ALSA that my driver supports every
 possible sample rate?
Date: Mon, 23 Jul 2007 10:54:32 -0500
Message-ID: <46A4CF38.3050107@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 59CFA10380E
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Jul 2007 17:54:36 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA devel <alsa-devel@alsa-project.org>, Liam Girdwood <lg@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

I'm building an ASOC driver, and I want to tell ALSA that my PCM and my I2S drivers 
support every possible sample rate, because it's the codec that determines the real 
limitations.  What SNDRV_PCM_RATE_xxx bit-pattern do I specify that will always match?

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
