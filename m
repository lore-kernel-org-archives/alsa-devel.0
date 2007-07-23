From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: SNDRV_PCM_FMTBIT_S24_LE vs.
	SNDRV_PCM_FMTBIT_S24_3LE
Date: Mon, 23 Jul 2007 20:17:39 +0100
Message-ID: <46A4FED3.2010903@superbug.co.uk>
References: <46A4F700.5030603@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from anchor-post-30.mail.demon.net (anchor-post-30.mail.demon.net
	[194.217.242.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 968D0103898
	for <alsa-devel@alsa-project.org>;
	Mon, 23 Jul 2007 21:17:40 +0200 (CEST)
In-Reply-To: <46A4F700.5030603@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Timur Tabi wrote:
> What is the difference between SNDRV_PCM_FMTBIT_S24_LE and SNDRV_PCM_FMTBIT_S24_3LE?
> 

SNDRV_PCM_FMTBIT_S24_LE is 24bit audio padded to fill 4 bytes.
SNDRV_PCM_FMTBIT_S24_3LE is 24bit audio with no padding, thus taking 
only 3 types.
