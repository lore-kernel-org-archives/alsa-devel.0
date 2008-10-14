From: ext-jukka.hynninen@vaisala.com
Subject: Re: ASoC: Merging at91 and avr32 dirs - test report
Date: Tue, 14 Oct 2008 10:28:54 +0300
Message-ID: <B9D3C48C98930741A166756A50C44A610F17B562@helx1.corp.vaisala.com>
References: <B9D3C48C98930741A166756A50C44A610F17B561@helx1.corp.vaisala.com>
	<20081010185312.GA10766@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw.vaisala.com (mailgw.vaisala.com [192.81.123.24])
	by alsa0.perex.cz (Postfix) with ESMTP id DE55F24401
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Oct 2008 09:29:13 +0200 (CEST)
Received: from helsrv02.vaisala.com (helsrv02.vaisala.com [192.81.123.16])
	by mailgw.vaisala.com (8.13.6/8.13.6) with SMTP id m9E7Stgj023042
	for <alsa-devel@alsa-project.org>; Tue, 14 Oct 2008 10:28:55 +0300
Content-class: urn:content-classes:message
In-Reply-To: <20081010185312.GA10766@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@sirena.org.uk
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Quoting Mark Brown:

>> However, there seems to be some problem with PM, occasionally ASoC is
>> stuck with Standby mode (looking at dapm_widgets) when I start the
>> playback. Restarting the player brings the sound back. I'll carry out
>> some further investigation and get back to this.
> How does this compare with the behaviour of the original at32 machine
> support - did that have similar issues?

Actually I was previously using at91 support. Nevertheless, didn't
notice such problems. 

I'll gather more info and try to figure out what's going wrong.


-Jukka
