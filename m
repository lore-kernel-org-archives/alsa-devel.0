From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: (no subject)
Date: Fri, 27 Mar 2009 15:32:00 +0200
Message-ID: <1238160721-27180-1-git-send-email-jarkko.nikula@nokia.com>
References: <20090327085613.dc719780.jarkko.nikula@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx09.nokia.com (smtp.nokia.com [192.100.105.134])
	by alsa0.perex.cz (Postfix) with ESMTP id 7EA7824356
	for <alsa-devel@alsa-project.org>; Fri, 27 Mar 2009 14:31:44 +0100 (CET)
In-Reply-To: <20090327085613.dc719780.jarkko.nikula@nokia.com>
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
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, x0052729@ti.com
List-Id: alsa-devel@alsa-project.org

Hi

I think we should use something like this in case of McBSP2 in OMAP3. McBSP2
has 4 kB internal audio buffer and it's causing underruns in playback
startup if ALSA buffer is smaller than that because DMA is looping around the
buffer while filling up the HW FIFO.


-- 
Jarkko
