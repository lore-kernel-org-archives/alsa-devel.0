From: Jarkko Nikula <jarkko.nikula@nokia.com>
Subject: Re: [PATCH 2/3] ASoC: omap-mcbsp: change the DSP_B
 mode to DSP_A mode
Date: Thu, 9 Apr 2009 13:00:14 +0300
Message-ID: <20090409130014.52b9319d.jarkko.nikula@nokia.com>
References: <1239269682-21309-1-git-send-email-peter.ujfalusi@nokia.com>
	<1239269682-21309-2-git-send-email-peter.ujfalusi@nokia.com>
	<1239269682-21309-3-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx06.nokia.com (smtp.nokia.com [192.100.122.233])
	by alsa0.perex.cz (Postfix) with ESMTP id 04C14243B5
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Apr 2009 11:59:38 +0200 (CEST)
In-Reply-To: <1239269682-21309-3-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "arunks@mistralsolutions.com" <arunks@mistralsolutions.com>
List-Id: alsa-devel@alsa-project.org

On Thu, 9 Apr 2009 11:34:41 +0200
"Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com> wrote:

> -	case SND_SOC_DAIFMT_DSP_B:
> +	case SND_SOC_DAIFMT_DSP_A:
>  		/* 0-bit data delay */
>  		regs->rcr2      |= RDATDLY(0);
>  		regs->xcr2      |= XDATDLY(0);
> -- 
Are you absolutely sure on this? According to WM9713, it's the DSP_A
where MSB is valid after 1 bit clock period of the FS.


-- 
Jarkko
