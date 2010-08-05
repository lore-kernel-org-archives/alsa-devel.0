From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: arecord: main:552: audio open error: Invalid
 argument
Date: Thu, 5 Aug 2010 12:10:31 +0100
Message-ID: <20100805111031.GB13146@rakim.wolfsonmicro.main>
References: <4C59C5C1.50504@freescale.com>
	<20100804200117.GB5864@sirena.org.uk>
	<AANLkTi=JLB7uqkMjoy7m3yy-aWTeT1opU3QUMXL2VEt8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D40E81038C6
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Aug 2010 13:10:32 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <AANLkTi=JLB7uqkMjoy7m3yy-aWTeT1opU3QUMXL2VEt8@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@freescale.com>
Cc: ALSA development <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 04, 2010 at 04:15:36PM -0500, Timur Tabi wrote:
> On Wed, Aug 4, 2010 at 3:01 PM, Mark Brown

> > The symmetric_rates infrastructure was only ever really intended to work
> > over a single DAI so I'd not be at all surprised if it gets a little
> > confused (though I'm surprised it's doing anything at all).

> Makes sense.  Should I forget the symmetric_rates feature and just
> handle it internally in my driver?

It would seem more sensible to enhance symmetric_rates.
