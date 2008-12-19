From: Troy Kisky <troy.kisky@boundarydevices.com>
Subject: Re: [PATCH 0/8]ALSA: ASoc: DaVinci: cleanup
Date: Fri, 19 Dec 2008 11:21:27 -0700
Message-ID: <494BE627.6060304@boundarydevices.com>
References: <1229629006-4261-1-git-send-email-troy.kisky@boundarydevices.com>
	<20081219101321.GA24129@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpauth01.csee.onr.siteprotect.com
	(smtpauth01.csee.onr.siteprotect.com [64.26.60.145])
	by alsa0.perex.cz (Postfix) with ESMTP id 9935024495
	for <alsa-devel@alsa-project.org>; Fri, 19 Dec 2008 19:21:35 +0100 (CET)
In-Reply-To: <20081219101321.GA24129@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com, "Medisetty, Naresh" <naresh@ti.com>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote:
> On Thu, Dec 18, 2008 at 12:36:38PM -0700, Troy Kisky wrote:
> 
>> Sorry, for the long series to do something so simple, but there were
>> unresolved objections when I first posted this to the davinci list.
> 
> What were the issues people had?
> 
>> Hopefully, having this split into tiny pieces will make resolving
>> those differences easier.
> 
> It certainly makes review easier.
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 

The meaning change of SND_SOC_DAIFMT_NB_NF was not liked.
And my comment that I2S mode is not supported on davinci
was not liked. I'll let Naresh explain.
