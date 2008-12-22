From: "Medisetty, Naresh" <naresh@ti.com>
Subject: Re: [PATCH 0/8]ALSA: ASoc: DaVinci: cleanup
Date: Mon, 22 Dec 2008 12:06:05 +0530
Message-ID: <FF55437E1F14DA4BAEB721A458B670170622FF42E1@dbde02.ent.ti.com>
References: <1229629006-4261-1-git-send-email-troy.kisky@boundarydevices.com>
	<20081219101321.GA24129@sirena.org.uk>,
	<494BE627.6060304@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
	by alsa0.perex.cz (Postfix) with ESMTP id AC78A1037EC
	for <alsa-devel@alsa-project.org>; Mon, 22 Dec 2008 07:36:19 +0100 (CET)
In-Reply-To: <494BE627.6060304@boundarydevices.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Troy Kisky <troy.kisky@boundarydevices.com>, Mark Brown <broonie@sirena.org.uk>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>
List-Id: alsa-devel@alsa-project.org



________________________________________
From: Troy Kisky [troy.kisky@boundarydevices.com]
Sent: Friday, December 19, 2008 11:51 PM
To: Mark Brown
Cc: alsa-devel@alsa-project.org; davinci-linux-open-source@linux.davincidsp.com; Medisetty, Naresh
Subject: Re: [alsa-devel] [PATCH 0/8]ALSA: ASoc: DaVinci: cleanup

>
> Mark Brown wrote:
> > On Thu, Dec 18, 2008 at 12:36:38PM -0700, Troy Kisky wrote:
> >
> >> Sorry, for the long series to do something so simple, but there
> >> were unresolved objections when I first posted this to the davinci list.
> >
> > What were the issues people had?
> >
> >> Hopefully, having this split into tiny pieces will make resolving
> >> those differences easier.
> >
> > It certainly makes review easier.
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org<mailto:Alsa-devel@alsa-project.org>
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> >
>
> The meaning change of SND_SOC_DAIFMT_NB_NF was not liked.
> And my comment that I2S mode is not supported on davinci was not
> liked. I'll let Naresh explain.
>



The comment regarding I2S mode is absolutely correct, since the davinci cannot support I2S where the codecs (like TLV320AIC23) has fixed bit clock frequency. Documenting this limitation is a very good idea.

Still I find difficulty to agree with Troy regarding the meaning change of SND_SOC_DAIFMT_NB_NF, since the existing meaning is correct w.r.t davinci McBSP.



> _______________________________________________
> Davinci-linux-open-source mailing list
> Davinci-linux-open-source@linux.davincidsp.com<mailto:Davinci-linux-open-source@linux.davincidsp.com>
> http://linux.davincidsp.com/mailman/listinfo/davinci-linux-open-source
