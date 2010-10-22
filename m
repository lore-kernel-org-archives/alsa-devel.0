From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] wm1133-ev1: fix init for multimachine
 kernel
Date: Thu, 21 Oct 2010 18:17:57 -0700
Message-ID: <20101022011757.GC28350@opensource.wolfsonmicro.com>
References: <1287696915-10392-1-git-send-email-eric@eukrea.com>
	<20101021215840.GF30466@opensource.wolfsonmicro.com>
	<4CC0BC73.8070709@eukrea.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id F34F7103AB8
	for <alsa-devel@alsa-project.org>;
	Fri, 22 Oct 2010 03:17:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4CC0BC73.8070709@eukrea.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Eric =?iso-8859-1?Q?B=E9nard?= <eric@eukrea.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 22, 2010 at 12:19:31AM +0200, Eric B=E9nard wrote:
> Le 21/10/2010 23:58, Mark Brown a =E9crit :
> >On Thu, Oct 21, 2010 at 11:35:15PM +0200, Eric B=E9nard wrote:

> >This is not a sufficient check, we may be running on an mx31ads with a
> >different PMIC module.

> in which case the current code would also fail ;-)

> I don't have such a board but actual code triggers the error log
> when running the kernel on my board so I'm open to your suggestion
> for a better fix.

Without adding machine fit checks it's always going to fail; machine
type isn't quite enough.  What we should be doing here is using the
multi-component work to allow us to replace soc-audio devices with
devices named for the machine driver (which is all round better anyway).
I'll try to look at this for .38.
