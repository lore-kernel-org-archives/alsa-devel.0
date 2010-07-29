From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [RFC 0/4] ASoC: OMAP3: Extended threshold mode
Date: Thu, 29 Jul 2010 12:03:51 +0300
Message-ID: <20100729120351.9b05e482.jhnikula@gmail.com>
References: <1280386288-22019-1-git-send-email-peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 73EA1103967
	for <alsa-devel@alsa-project.org>;
	Thu, 29 Jul 2010 11:03:55 +0200 (CEST)
Received: by ewy21 with SMTP id 21so33559ewy.38
	for <alsa-devel@alsa-project.org>; Thu, 29 Jul 2010 02:03:55 -0700 (PDT)
In-Reply-To: <1280386288-22019-1-git-send-email-peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Thu, 29 Jul 2010 09:51:24 +0300
Peter Ujfalusi <peter.ujfalusi@nokia.com> wrote:

> Hello,
> 
> The following series extends the current threshold implementation for OMAP3
> class of devices.
> 
> The original threshold implementation has limitation on the size of the period,
> which can not be bigger than the McBSP port's FIFO size.
> This limitation makes it hard to use any power saving on McBSP ports other than
> McBSP2 (McBSP2 has 1280 word buffer, other ports have only 128 word long
> buffer), since the maximum period size limit is really small.
> 
...
> What do you think?
> 
Well, cleanups are always good as well as making the code more uniform,
and if the same set also improves power savings, what else I can do :-)

Acked-by: Jarkko Nikula <jhnikula@gmail.com>

(this DMA packet transfer is used also with McPDM on OMAP4, trial
showed that it can work with McBSP on OMAP3 and as we can see, Peter
now implemented it)
