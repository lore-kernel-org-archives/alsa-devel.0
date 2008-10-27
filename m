From: ext-jukka.hynninen@vaisala.com
Subject: Re: ASoC: Merging at91 and avr32 dirs - test report
Date: Mon, 27 Oct 2008 13:13:06 +0200
Message-ID: <B9D3C48C98930741A166756A50C44A610F17B571@helx1.corp.vaisala.com>
References: <B9D3C48C98930741A166756A50C44A610F17B561@helx1.corp.vaisala.com>
	<20081010185312.GA10766@sirena.org.uk>
	<B9D3C48C98930741A166756A50C44A610F17B562@helx1.corp.vaisala.com>
	<B9D3C48C98930741A166756A50C44A610F17B564@helx1.corp.vaisala.com>
	<20081014125835.GF14538@sirena.org.uk>
	<B9D3C48C98930741A166756A50C44A610F17B565@helx1.corp.vaisala.com>
	<49059097.5020309@atmel.com> <20081027104225.GA5896@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw.vaisala.com (mailgw.vaisala.com [192.81.123.24])
	by alsa0.perex.cz (Postfix) with ESMTP id AEDC7246FE
	for <alsa-devel@alsa-project.org>; Mon, 27 Oct 2008 12:13:08 +0100 (CET)
Received: from helsrv02.vaisala.com (helsrv02.vaisala.com [192.81.123.16])
	by mailgw.vaisala.com (8.13.6/8.13.6) with SMTP id m9RBD7Xs024669
	for <alsa-devel@alsa-project.org>; Mon, 27 Oct 2008 13:13:07 +0200
Content-class: urn:content-classes:message
In-Reply-To: <20081027104225.GA5896@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: sedji.gaouaou@atmel.com
Cc: alsa-devel@alsa-project.org, broonie@sirena.org.uk
List-Id: alsa-devel@alsa-project.org

Quoting Mark Brown:

>> Is there any progress concerning the testing?
>> What is required for the patch to be accepted?
> Jukka seemed happy but we've had no testing at all on AVR32 so far 
> as far as I can see - Geoffrey had been going to test it but his 

Affirmative, no promlems whatsoever encountered during several days
stress testing. At91 & WM8510 runs smoothly.

Just wanted to remind on the change that was needed to avoid the SSC
peripheral clock problem. I hope this will also be included.


-Jukka
