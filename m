From: Yoichi Yuasa <yuasa@linux-mips.org>
Subject: Re: [PATCH 03/19] ALSA: ymu831: add B-DSP driver
Date: Thu, 17 Jan 2013 14:59:12 +0900
Message-ID: <20130117145912.10c5650712b73552ad9c4068@linux-mips.org>
References: <20130116172530.857b627ef3303fb6fe43f603@linux-mips.org>
 <20130116172832.7339f01ca4557727fdc3883f@linux-mips.org>
 <20130116132245.GB16235@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20130116132245.GB16235@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, patch@alsa-project.org, yuasa@linux-mips.org
List-Id: alsa-devel@alsa-project.org

On Wed, 16 Jan 2013 13:22:45 +0000
Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> On Wed, Jan 16, 2013 at 05:28:32PM +0900, Yoichi Yuasa wrote:
> > 
> > Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
> > ---
> >  sound/soc/codecs/ymu831/Makefile    |    1 +
> >  sound/soc/codecs/ymu831/mcbdspdrv.c | 1193 +++++++++++++++++++++++++++++++++++
> 
> Why the subdirectory?

ymu831 driver has 27 files.
It is the reason that I made the subdirectory.
Is it better to put them on sound/soc/codes ?

>  Also this file is over 1000 lines of code with
> basically no comments or relationship with standard kernel code.  This
> is a substandial barrier to review; at the very least it would be
> helpful to split this up into multiple patches, one per algorithm for
> example.

OK, I'll split it.

> 
> > +/*
> > + * changelog:
> > + * - change in the Linux coding style
> > + * - remove unnecessary comments
> > + * - remove unused codes
> > + */
> 
> No changelogs in kernel code.

OK, I'll remove them.

Thank you for your comments.

Yoichi
