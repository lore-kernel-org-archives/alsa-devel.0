From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] asoc: replace 0xffffffff with DMA_BIT_MASK
	macro
Date: Sat, 7 Jan 2012 11:12:23 -0800
Message-ID: <20120107191222.GB3590@opensource.wolfsonmicro.com>
References: <1325382183-21717-1-git-send-email-manabian@gmail.com>
	<20120102132933.GN4300@opensource.wolfsonmicro.com>
	<CAGhQ9VyxHvCFy4EJyabi8Tfy5NRQaOe4huAPXVYsrQ0GBDsc9g@mail.gmail.com>
	<20120105053625.GA11867@opensource.wolfsonmicro.com>
	<CAGhQ9VxiCpZdNWRfwMgbg6Jam7pcffdUs7xuMiQYaFJ1FfV-AA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E0E3E24352
	for <alsa-devel@alsa-project.org>; Sat,  7 Jan 2012 20:12:39 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <CAGhQ9VxiCpZdNWRfwMgbg6Jam7pcffdUs7xuMiQYaFJ1FfV-AA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Joachim Eastwood <manabian@gmail.com>
Cc: Joachim Eastwood <joachim.eastwood@jotron.com>, alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 05, 2012 at 05:31:14PM +0100, Joachim Eastwood wrote:

> One other thing; which git tree should I base them on? The ones I sent
> was based on Linus master.

Definitely don't use that, the latest version of the tree you're
submitting against is usually best (-next tends to work also) except for
bugfixes for the next release which should go to the latest test version
of the subsystem or Linus' tree if there is none.
