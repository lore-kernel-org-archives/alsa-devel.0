From: "Srinivas.Kandagatla" <srinivas.kandagatla@azingo.com>
Subject: How are events of headphone plug/unplug handled in
	ASOC.
Date: Thu, 08 May 2008 15:57:04 +0530
Message-ID: <1210242424.6288.13.camel@kandagatla-laptop>
References: <200804231654.44526.jbe@pengutronix.de>
	<200805051256.38153.jbe@pengutronix.de>
	<20080505124233.GE3426@sirena.org.uk>
	<200805080954.28299.jbe@pengutronix.de>
	<20080508093339.GA17836@rakim.wolfsonmicro.main>
Reply-To: srinivas.kandagatla@azingo.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iceblock02.celunite.com (iceblock02.azingo.com [12.53.234.6])
	by alsa0.perex.cz (Postfix) with SMTP id 1B8A91037ED
	for <alsa-devel@alsa-project.org>;
	Thu,  8 May 2008 12:27:12 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by iceblock02.celunite.com (Postfix) with ESMTP id 936F756C003
	for <alsa-devel@alsa-project.org>; Thu,  8 May 2008 03:34:05 -0700 (PDT)
Received: from iceblock02.celunite.com ([127.0.0.1])
	by localhost (Iceblock02.celunite.com [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id BDvpCDwvNs0c for <alsa-devel@alsa-project.org>;
	Thu,  8 May 2008 03:34:03 -0700 (PDT)
Received: from webmailindia.celunite.com (unknown [196.12.63.195])
	by iceblock02.celunite.com (Postfix) with SMTP id 8A59E56C002
	for <alsa-devel@alsa-project.org>; Thu,  8 May 2008 03:34:02 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by webmailindia.celunite.com (Postfix) with ESMTP id 569EF490F8
	for <alsa-devel@alsa-project.org>; Thu,  8 May 2008 15:50:39 +0530 (IST)
Received: from webmailindia.celunite.com ([127.0.0.1])
	by localhost (webmailindia.celunite.com [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id aMlnoKq5JKwl for <alsa-devel@alsa-project.org>;
	Thu,  8 May 2008 15:50:39 +0530 (IST)
Received: from [172.17.5.179] (unknown [172.17.5.179])
	by webmailindia.celunite.com (Postfix) with ESMTP
	for <alsa-devel@alsa-project.org>; Thu,  8 May 2008 15:50:38 +0530 (IST)
In-Reply-To: <20080508093339.GA17836@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi all, 
I see the background of ASOC states that it supports some mechanism for
events from plugging/unplugging headphone.
But I don't see this support in any of the drivers/alsa-lib or is this
feature is yet to come in ASOC core.


Rgrds
srinivas.kandagatla
