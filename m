From: Mark Lokowich <lokowich@acdstar.com>
Subject: Re: DaVinci ASoC DMA stalls
Date: Fri, 19 Sep 2008 17:06:16 -0500
Message-ID: <48D42258.3060306@acdstar.com>
References: <48BFE50E.3000802@acdstar.com>
	<48C015B2.2070401@gmail.com>	<48C05FFD.4030009@acdstar.com>
	<F8C55F6A02E92D48BDDFC6048552C6F1142BB196@dlee03.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from g2host.com (mailfront1.g2host.com [208.42.176.212])
	by alsa0.perex.cz (Postfix) with ESMTP id 16ED124729
	for <alsa-devel@alsa-project.org>;
	Sat, 20 Sep 2008 00:06:20 +0200 (CEST)
In-Reply-To: <F8C55F6A02E92D48BDDFC6048552C6F1142BB196@dlee03.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Griffis, Brad" <bgriffis@ti.com>
Cc: ALSA-devel <alsa-devel@alsa-project.org>, davinci-linux-open-source <davinci-linux-open-source@linux.davincidsp.com>
List-Id: alsa-devel@alsa-project.org



Griffis, Brad wrote:
>> My test is simply to run aplay or speaker-test,
>> then quit and run it again.  The first run is audible, the second and
>> subsequent runs are not audible until I provide a manual DMA event trigger.
>>     
>
> When the ASP transmitter is taken out of reset it sends XEVT to the EDMA where it is "captured" in event register (ER).  If that event gets cleared out before turning on the EDMA you'll end up with a scenario like you described, i.e. once you kick off a transfer manually it will then run.  I haven't looked at the code you're using, but it sounds to me like the (re-)initialization sequence isn't correct.
>
> The best way for the code to work would be for the EDMA to be configured BEFORE the McBSP.  That way, even if the EDMA initialization procedure clears the ER bits it won't matter because when the McBSP is subsequently released from reset it will send a new XEVT to the EDMA.
>
> Brad
>
>   

    Excellent tip, but the ASoC software is doing just what you
    suggested, starting the DMA prior to starting the ASP.  I also found
    that the latest DMA software also causes buffer underruns when
    playing Ogg Vorbis files, while the 2.6.25 version doesn't have
    these issues.  I'll keep looking.

    Thanks,
    Mark

> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
>
>   
