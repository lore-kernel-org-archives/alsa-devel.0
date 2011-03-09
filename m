From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: Fix double addition of prefixes due
 to widget prefixing
Date: Wed, 09 Mar 2011 11:56:05 +0000
Message-ID: <1299671765.3360.91.camel@odin>
References: <1299670452-13290-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20110309134748.014ab0fd.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id D83691039CF
	for <alsa-devel@alsa-project.org>; Wed,  9 Mar 2011 12:56:08 +0100 (CET)
Received: by mail-wy0-f179.google.com with SMTP id 26so347300wyj.38
	for <alsa-devel@alsa-project.org>; Wed, 09 Mar 2011 03:56:08 -0800 (PST)
In-Reply-To: <20110309134748.014ab0fd.jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Wed, 2011-03-09 at 13:47 +0200, Jarkko Nikula wrote:
> On Wed,  9 Mar 2011 11:34:12 +0000
> Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:
> 
> > We're not only prefixing all controls, we're also prefixing the widget
> > names in the runtime data. This causes us to add the prefix twice - once
> > when using the widget name to generate the control name and once when
> > adding the control.
> > 
> > Really we shouldn't be prefixing the widget names at all, the matching
> > code should be handing this as we always know which DAPM context a
> > widget came from and always display the widget name in terms of a DAPM
> > context.  However, we're quite close to the merge window and that's
> > relatively invasive.
> > 
> > Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
> > ---
> >  sound/soc/soc-dapm.c |   29 ++++++++++++++++++++++++++---
> >  1 files changed, 26 insertions(+), 3 deletions(-)
> > 
> No problem anymore on N900.
> 
> Acked-by: Jarkko Nikula <jhnikula@gmail.com>

Acked-by: Liam Girdwood <lrg@ti.com>
