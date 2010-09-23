From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 0/3] alsa-lib: UCM - Use Case Manager
Date: Thu, 23 Sep 2010 11:06:00 +0100
Message-ID: <20100923100600.GB25663@rakim.wolfsonmicro.main>
References: <alpine.LNX.2.00.1009071618230.10278@eeebox2.perex-int.cz>
	<i781vn$nhb$1@dough.gmane.org>
	<AANLkTin8fTA0CoUiPzASG4kepbSyWiDf7xrX-iJB8EQA@mail.gmail.com>
	<alpine.LNX.2.00.1009211938110.6226@eeebox2.perex-int.cz>
	<20100922132052.GC32476@sirena.org.uk>
	<alpine.LNX.2.00.1009221544480.6226@eeebox2.perex-int.cz>
	<20100922151419.GF26395@rakim.wolfsonmicro.main>
	<alpine.LNX.2.00.1009221950540.6226@eeebox2.perex-int.cz>
	<20100922184817.GT26395@rakim.wolfsonmicro.main>
	<AANLkTimJQeLohP-3q=Qe1VrEe9DUuC+DZUJoyXDxKBSk@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 102C0103803
	for <alsa-devel@alsa-project.org>;
	Thu, 23 Sep 2010 12:06:03 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTimJQeLohP-3q=Qe1VrEe9DUuC+DZUJoyXDxKBSk@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Niels Mayer <nielsmayer@gmail.com>
Cc: Chris Winter <elwintro@gmail.com>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 23, 2010 at 12:18:33AM -0700, Niels Mayer wrote:
> On Wed, Sep 22, 2010 at 11:48 AM, Mark Brown

> > If we make everything procedural now it will become much harder to back
> > out of it later, and I would hope that one of the things that use case
> > management can do is ensure that users only need to specify their goal
> > states and don't need to deal with the mechanics of how to achieve them
> > except in exceptional circumstances.

> I completely agree. This problem seems best solved by "logic
> programming" and ontologies describing both hardware capabilities,
> constraints, as well as the applications needs and requirements. Such

A strong note of caution here: this is a very difficult task which
nobody is currently attempting to do except for very constrained sets of
systems such as standard PC hardware.  Nothing anyone is discussing here
involves the automatic generation of settings, it's all about how we
manage sets of explicitly defined settings.
