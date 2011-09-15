From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] ASoC: support sample sizes properly in
 the WM8776 codec driver
Date: Thu, 15 Sep 2011 14:21:54 +0100
Message-ID: <20110915132154.GF7988@opensource.wolfsonmicro.com>
References: <1315936777-27994-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 27DEF103BC2
	for <alsa-devel@alsa-project.org>;
	Thu, 15 Sep 2011 15:21:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1315936777-27994-1-git-send-email-timur@freescale.com>
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
Cc: alsa-devel@alsa-project.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 13, 2011 at 12:59:35PM -0500, Timur Tabi wrote:

> -	iface = 0;
> -

Random stylistic changes like this make review harder, especially when
they're not mentioned in the changelog.  In this case it's not clear
from the diff alone that there are no other places where iface gets
written to which are going to get trashed by the change and since it
wasn't mentioned in the changelog it's not clear if the change was
intentional or committed by mistake.

An important aspect of review is checking that the change being made
actually do what they're supposed to do, unexpected additional stuff is
a red flag - you have to work out if it's something the sender meant to
include, what it's supposed to do and if it's a good idea.
