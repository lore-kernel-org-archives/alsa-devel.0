From: Johannes Stezenbach <js@sig21.net>
Subject: Re: [PATCH 1/2] ALSA: ASoC: add STA32X codec driver
Date: Wed, 15 Jun 2011 22:53:29 +0200
Message-ID: <20110615205329.GA7445@sig21.net>
References: <1308079626-31239-1-git-send-email-zonque@gmail.com>
	<1308079626-31239-2-git-send-email-zonque@gmail.com>
	<20110615150516.GC2806@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bar.sig21.net (bar.sig21.net [80.81.252.164])
	by alsa0.perex.cz (Postfix) with ESMTP id 8642E10382F
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Jun 2011 22:53:39 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110615150516.GC2806@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, lrg@slimlogic.co.uk, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 15, 2011 at 04:05:16PM +0100, Mark Brown wrote:
> On Tue, Jun 14, 2011 at 09:27:05PM +0200, Daniel Mack wrote:
> 
> > +static const char *sta32x_limiter_ac_release_thr[] = {
> > +	"-inf", "-29dB", "-20dB", "-16dB", "-14dB", "-12dB", "-10dB", "-8dB",
> > +	"-7dB", "-6dB", "-5dB", "-4dB", "-3dB", "-2dB", "-1dB", "0dB" };
> > +static const char *sta32x_limiter_drc_attack_thr[] = {
> > +	"-31dB", "-29dB", "-27dB", "-25dB", "-23dB", "-21dB", "-19dB", "-17dB",
> > +	"-16dB", "-15dB", "-14dB", "-13dB", "-12dB", "-10dB", "-7dB", "-4dB" };
> > +static const char *sta32x_limiter_drc_release_thr[] = {
> > +	"-inf", "-38dB", "-36dB", "-33dB", "-31dB", "-30dB", "-28dB", "-26dB",
> > +	"-24dB", "-22dB", "-20dB", "-18dB", "-15dB", "-12dB", "-9dB", "-6dB" };
> > +
> 
> Doing these as regular volume TLVs will tend to work better in UIs.

The steps are not evenly distributed so I thought this is the
only way to describe the hardware correctly.  Or is there a
way to do controls which look like a slider in alsamixer
with steps as shown above?

Thanks for your review.


Johannes
