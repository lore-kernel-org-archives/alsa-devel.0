From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: SNDRV_PCM_FMTBIT_S24_LE vs.
	SNDRV_PCM_FMTBIT_S24_3LE
Date: Tue, 24 Jul 2007 09:03:05 +0200
Message-ID: <1185260585.4926.1201714631@webmail.messagingengine.com>
References: <11505.27621-24387-105789712-1185218525@seznam.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 33E0A103852
	for <alsa-devel@alsa-project.org>;
	Tue, 24 Jul 2007 09:03:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <11505.27621-24387-105789712-1185218525@seznam.cz>
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

dustin@seznam.cz wrote:
> >  What is the difference between SNDRV_PCM_FMTBIT_S24_LE and
> >  SNDRV_PCM_FMTBIT_S24_3LE?
> 
> The asound.h says S24_LE is stored in lower three bytes of four, whereas
> S24_3LE is stored in three bytes total.

To use a sample format with 24 bits stored in the upper three bytes of
four, use S32_LE.  In that case, you have to call
"snd_pcm_hw_constraint_msbits(runtime, 0, 32, 24)" in the PCM open
callback to tell ALSA that some of the lower bits aren't used.


HTH
Clemens
