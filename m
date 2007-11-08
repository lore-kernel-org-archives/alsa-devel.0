From: Timur Tabi <timur@freescale.com>
Subject: Re: underruns and strange code in pcm_rate.c (and
	patch)
Date: Thu, 08 Nov 2007 14:06:15 -0600
Message-ID: <47336C37.7070801@freescale.com>
References: <472E5A64.6010705@aknet.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	by alsa0.perex.cz (Postfix) with ESMTP id 3E30924960
	for <alsa-devel@alsa-project.org>; Thu,  8 Nov 2007 21:07:34 +0100 (CET)
In-Reply-To: <472E5A64.6010705@aknet.ru>
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

Stas Sergeev wrote:
> Hi.
> 
> I spent 4 week-ends debugging the
> constant underruns and lock-ups with
> the libao-based programs.

I think I'm seeing the same problem.  When I play certain video files with 
mplayer and "-ao oss", the video plays much faster than normal, the audio cuts 
out, and my audio driver gets called the STOP command at the end of a period.

See my thread, "Any OSS changes from kernel 2.6.21 to 2.6.23? Something broke.", 
although I no longer believe that this is a problem only with newer kernels.

-- 
Timur Tabi
Linux kernel developer at Freescale
