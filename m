From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [PATCH] ASoC: omap-mcbsp: Add support for Left
	Justified format
Date: Fri, 19 Mar 2010 12:13:08 +0200
Message-ID: <20100319121308.a43db48d.jhnikula@gmail.com>
References: <1268989879-18303-1-git-send-email-peter.ujfalusi@nokia.com>
	<20100319112854.99c1f692.jhnikula@gmail.com>
	<201003191200.03750.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.150])
	by alsa0.perex.cz (Postfix) with ESMTP id 4AF1F24382
	for <alsa-devel@alsa-project.org>; Fri, 19 Mar 2010 11:11:20 +0100 (CET)
Received: by ey-out-1920.google.com with SMTP id 4so341201eyg.16
	for <alsa-devel@alsa-project.org>; Fri, 19 Mar 2010 03:11:18 -0700 (PDT)
In-Reply-To: <201003191200.03750.peter.ujfalusi@nokia.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, 19 Mar 2010 12:00:03 +0200
Peter Ujfalusi <peter.ujfalusi@nokia.com> wrote:

> Now with:
> /* Left justified */
> fmt =	SND_SOC_DAIFMT_LEFT_J |
> 		SND_SOC_DAIFMT_NB_IF |
>  		SND_SOC_DAIFMT_CBM_CFM;
> 
> The data line has data when the FS is high (when FS is low, that data line has 
> 0). So this is correct Left Justified.
> 
> At least it seams that McBSP is actually shifting out the data at the correct 
> place, when it is slave..
> 
> Oh, and I can not explain why this is working, but I do trust on my scope, and 
> it shows me that it is correct :o
> 
For me it looks it's working because of NB_IF so try again with
NB_NF :-)


-- 
Jarkko
