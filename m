From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 3/3] ALSA SoC: Add Texas
	Instruments	TLV320AIC26 codec driver
Date: Fri, 18 Jul 2008 10:14:13 -0600
Message-ID: <20080718161413.GA10317@secretlab.ca>
References: <20080701235330.16923.67218.stgit@trillian.secretlab.ca>
	<20080701235340.16923.48024.stgit@trillian.secretlab.ca>
	<1214995713.4882.54.camel@localhost.localdomain>
	<20080712060018.GB23213@secretlab.ca>
	<20080712173609.GA6523@sirena.org.uk>
	<20080717233153.GA8187@secretlab.ca>
	<20080718095823.GA14416@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from yx-out-1718.google.com (yx-out-1718.google.com [74.125.44.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 03FF62451C
	for <alsa-devel@alsa-project.org>;
	Fri, 18 Jul 2008 18:14:17 +0200 (CEST)
Received: by yx-out-1718.google.com with SMTP id 36so125062yxh.2
	for <alsa-devel@alsa-project.org>; Fri, 18 Jul 2008 09:14:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20080718095823.GA14416@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.girdwood@wolfsonmicro.com>, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, timur@freescale.com
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 18, 2008 at 10:58:25AM +0100, Mark Brown wrote:
> Sparse (or sparsely used) register maps are pretty common - in practice
> it's not been a problem to just have a cache that covers everything and
> only gets read, the amount of data involved is rarely that large in the
> context of what you need to store the audio you're working with.

okay.

g.
