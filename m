From: "Matti J. Aaltonen" <matti.j.aaltonen@nokia.com>
Subject: Re: WL1273 FM Radio driver...
Date: Mon, 07 Feb 2011 16:17:22 +0200
Message-ID: <1297088242.15320.62.camel@masi.mnp.nokia.com>
References: <1297075922.15320.31.camel@masi.mnp.nokia.com>
	<4D4FDED0.7070008@redhat.com>
	<20110207120234.GE10564@opensource.wolfsonmicro.com>
	<4D4FEA03.7090109@redhat.com>
	<20110207131045.GG10564@opensource.wolfsonmicro.com>
	<4D4FF821.4010701@redhat.com>
	<20110207135225.GJ10564@opensource.wolfsonmicro.com>
Reply-To: matti.j.aaltonen@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-sa02.nokia.com (smtp.nokia.com [147.243.1.48])
	by alsa0.perex.cz (Postfix) with ESMTP id 3EC8124392
	for <alsa-devel@alsa-project.org>; Mon,  7 Feb 2011 15:17:25 +0100 (CET)
In-Reply-To: <20110207135225.GJ10564@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, sameo@linux.intel.com, Mauro Carvalho Chehab <mchehab@redhat.com>, hverkuil@xs4all.nl, lrg@slimlogic.co.uk, linux-media@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2011-02-07 at 13:52 +0000, ext Mark Brown wrote:
> On Mon, Feb 07, 2011 at 11:48:17AM -0200, Mauro Carvalho Chehab wrote:
> > Em 07-02-2011 11:10, Mark Brown escreveu:
> 
> > > There is an audio driver for this chip and it is using those functions.
> 
> > Where are the other drivers that depend on it?
> 
> Nothing's been merged yet to my knowledge, Matti can comment on any
> incoming boards which will use it (rx51?).

Yes, nothing's been merged yet. There are only dependencies between the
parts of this driver... I cannot comment on upcoming boards, I just hope
we could agree on a sensible structure for this thing.

Matti.
