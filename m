From: ext-jukka.hynninen@vaisala.com
Subject: Re: ASoC: Merging at91 and avr32 dirs - test report
Date: Tue, 14 Oct 2008 17:00:40 +0300
Message-ID: <B9D3C48C98930741A166756A50C44A610F17B565@helx1.corp.vaisala.com>
References: <B9D3C48C98930741A166756A50C44A610F17B561@helx1.corp.vaisala.com>
	<20081010185312.GA10766@sirena.org.uk>
	<B9D3C48C98930741A166756A50C44A610F17B562@helx1.corp.vaisala.com>
	<B9D3C48C98930741A166756A50C44A610F17B564@helx1.corp.vaisala.com>
	<20081014125835.GF14538@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw.vaisala.com (mailgw.vaisala.com [192.81.123.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 842E52448E
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Oct 2008 16:01:02 +0200 (CEST)
Received: from helsrv02.vaisala.com (helsrv02.vaisala.com [192.81.123.16])
	by mailgw.vaisala.com (8.13.6/8.13.6) with SMTP id m9EE0ibW004312
	for <alsa-devel@alsa-project.org>; Tue, 14 Oct 2008 17:00:44 +0300
Content-class: urn:content-classes:message
In-Reply-To: <20081014125835.GF14538@sirena.org.uk>
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

>> This is propably a false alarm, exactly the same happens with
at91-ssc.c
> OK, so you're happy that the new and old AT91 drivers perform
> equivalently?

Life's full of small joys

> present in current ASoC.  The patch below is *entirely* untested but
may
> help.  It needs more thought and (obviously) testing to make sure it's
> safe before it can be merged.

Thanks, works like a charm. I'll put the patch on a test.


-Jukka
