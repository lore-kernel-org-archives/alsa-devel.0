From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Reforming s3c2443 ac97 driver
Date: Thu, 21 Jan 2010 11:30:17 +0000
Message-ID: <20100121113017.GA5523@rakim.wolfsonmicro.main>
References: <29946650.33531262928531169.JavaMail.weblogic@epml17>
	<9A9547C8-08FD-4310-A69C-44CA8A3E01C2@opensource.wolfsonmicro.com>
	<1b68c6791001202258p7ef0ebcdt444a3be2eeaaff36@mail.gmail.com>
	<1264070267.2396.92.camel@odin>
	<1b68c6791001210322l2db4ffa4yc65043b4061cae4f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6A97C24364
	for <alsa-devel@alsa-project.org>; Thu, 21 Jan 2010 12:30:19 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1b68c6791001210322l2db4ffa4yc65043b4061cae4f@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: jassi brar <jassisinghbrar@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "jassi.brar@samsung.com" <jassi.brar@samsung.com>, "graeme.gregory@wolfsonmicro.com" <graeme.gregory@wolfsonmicro.com>, "ben-linux@fluff.org" <ben-linux@fluff.org>, SeungHyun Choi <sh428.choi@samsung.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 21, 2010 at 08:22:19PM +0900, jassi brar wrote:
> On Thu, Jan 21, 2010 at 7:37 PM, Liam Girdwood <lrg@slimlogic.co.uk> wrote:

> > It does sound like the AC97 link is up and running. What codec is used
> > here ?

> Yes, link is fine. Irqs happen too and no xruns. Just I can't hear anything.

That sounds like something really simple like a mute that's on by
default in the CODEC.  I'd certainly be comfortable that the controller
is working, anyway.
