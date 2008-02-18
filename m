From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: Cirrus Logic CS42L52 Low power codec
Date: Mon, 18 Feb 2008 08:45:49 -0600
Message-ID: <1203345949.4063.8.camel@localhost.localdomain>
References: <1203344273.4063.6.camel@localhost.localdomain>
	<20080218143655.GE21314@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from outbound2-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	by alsa0.perex.cz (Postfix) with ESMTP id 893CF103858
	for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2008 15:49:30 +0100 (CET)
Received: from outbound2-dub.bigfish.com (localhost.localdomain [127.0.0.1])
	by outbound2-dub-R.bigfish.com (Postfix) with ESMTP id 0DB4A4CA8B1
	for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2008 14:47:24 +0000 (UTC)
Received: from mail145-dub-R.bigfish.com (unknown [10.5.252.3])
	by outbound2-dub.bigfish.com (Postfix) with ESMTP id D609317D0051
	for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2008 14:47:23 +0000 (UTC)
Received: from mail145-dub (localhost.localdomain [127.0.0.1])
	by mail145-dub-R.bigfish.com (Postfix) with ESMTP id 865EAF183AD
	for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2008 14:47:23 +0000 (UTC)
Received: from mail1.cirrus.com (mail1.cirrus.com [141.131.3.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail145-dub.bigfish.com (Postfix) with ESMTP id 39AA517C0072
	for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2008 14:47:20 +0000 (UTC)
Received: from CLMSG-01.ad.cirrus.com ([198.61.95.37])
	by mail1.cirrus.com (8.12.11.20060308/8.12.11) with ESMTP id
	m1IEdrGk028319
	for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2008 08:39:53 -0600
In-Reply-To: <20080218143655.GE21314@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I was under the impression that the ASoc v1 ties the codec to a specific
machine, and that v2 eliminates that need.  Is that a correct
assumption?


-----Original Message-----
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Brian Austin <brian.austin@cirrus.com>
Cc: alsa-devel@alsa-project.org <alsa-devel@alsa-project.org>
Subject: Re: [alsa-devel] Cirrus Logic CS42L52 Low power codec
Date: Mon, 18 Feb 2008 14:36:55 +0000

On Mon, Feb 18, 2008 at 08:17:53AM -0600, Brian Austin wrote:

> I have a codec I would like to submit.  The Cirrus Logic CS42L52 Low
> Power codec.  I have the codec code as well as the machine code for the
> Cirrus Logic EP9407A, but cannot submit that yet.  Is it OK to just
> submit the codec code for now?  This does not use the new API, so a hint
> as to which tree to make the diff from would help.

Assuming that this is an ASoC codec driver please go ahead and submit
the codec by itself - there's no requirement for an in-tree machine
driver.  For ASoC v1 a patch against any of current alsa-driver hg,
Linus' current kernel or the dev branch of the ASoC repository at
git://opensource.wolfsonmicro.com/linux-2.6-asoc should be fine -
whichever you find most convenient.
