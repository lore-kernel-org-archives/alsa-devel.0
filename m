From: Timur Tabi <timur@freescale.com>
Subject: Re: underruns and strange code in pcm_rate.c
	(and	patch)
Date: Thu, 08 Nov 2007 16:01:46 -0600
Message-ID: <4733874A.6080405@freescale.com>
References: <472E5A64.6010705@aknet.ru> <47336C37.7070801@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	by alsa0.perex.cz (Postfix) with ESMTP id E77FD243E3
	for <alsa-devel@alsa-project.org>; Thu,  8 Nov 2007 23:02:13 +0100 (CET)
In-Reply-To: <47336C37.7070801@freescale.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stas Sergeev <stsp@aknet.ru>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Timur Tabi wrote:

> I think I'm seeing the same problem.  When I play certain video files with 
> mplayer and "-ao oss", the video plays much faster than normal, the audio cuts 
> out, and my audio driver gets called the STOP command at the end of a period.

Update: when I tell mplayer to set the sample rate to 48000, the problem appears 
to go away completely.  So it looks like sample rate conversion and OSS don't 
work well together.

-- 
Timur Tabi
Linux kernel developer at Freescale
