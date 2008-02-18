From: Brian Austin <brian.austin@cirrus.com>
Subject: Re: Cirrus Logic CS42L52 Low power codec
Date: Mon, 18 Feb 2008 10:34:33 -0600
Message-ID: <1203352473.4063.22.camel@localhost.localdomain>
References: <1203344273.4063.6.camel@localhost.localdomain>
	<20080218143655.GE21314@rakim.wolfsonmicro.main>
	<1203345949.4063.8.camel@localhost.localdomain>
	<20080218152259.GA7939@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from outbound6-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	by alsa0.perex.cz (Postfix) with ESMTP id C295C2443B
	for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2008 17:36:28 +0100 (CET)
Received: from outbound6-dub.bigfish.com (localhost.localdomain [127.0.0.1])
	by outbound6-dub-R.bigfish.com (Postfix) with ESMTP id ACB324680C8
	for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2008 16:36:27 +0000 (UTC)
Received: from mail185-dub-R.bigfish.com (unknown [10.5.252.3])
	by outbound6-dub.bigfish.com (Postfix) with ESMTP id A1A59D5804E
	for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2008 16:36:27 +0000 (UTC)
Received: from mail185-dub (localhost.localdomain [127.0.0.1])
	by mail185-dub-R.bigfish.com (Postfix) with ESMTP id 4F89419F0370
	for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2008 16:36:27 +0000 (UTC)
Received: from mail1.cirrus.com (mail1.cirrus.com [141.131.3.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail185-dub.bigfish.com (Postfix) with ESMTP id 06EF691806A
	for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2008 16:36:25 +0000 (UTC)
Received: from CLMSG-01.ad.cirrus.com ([198.61.95.37])
	by mail1.cirrus.com (8.12.11.20060308/8.12.11) with ESMTP id
	m1IGSbw2032198
	for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2008 10:28:37 -0600
In-Reply-To: <20080218152259.GA7939@rakim.wolfsonmicro.main>
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

On Mon, Feb 18, 2008 at 08:45:49AM -0600, Brian Austin wrote:
> I was under the impression that the ASoc v1 ties the codec to a specific
> machine, and that v2 eliminates that need.  Is that a correct
> assumption?

No, codec drivers shouldn't be tied to a specific platform in either
version - the main new feature in v2 from the point of view of codec
support is that it allows a machine to have more than one codec at once,
but that's not a change that affects the codec driver.

Since the codecs are not tied to the machine, the user must then add to the Kconfig of the 
ARCH to select which codec they want to use?

Using s3c2410_defconfig will only let you select the devices that are added in the Kconfig for the s3c24xx.

If the codec isn't tied to the machine, why can't we select from a list of supported codecs?
Just trying to get a better understanding of how this works.


Thanks,

Brian
