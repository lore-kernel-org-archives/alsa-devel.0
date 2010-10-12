From: Dan Carpenter <error27@gmail.com>
Subject: Re: [patch] ASoC: soc: snprintf() doesn't return
	negative
Date: Tue, 12 Oct 2010 12:40:22 +0200
Message-ID: <20101012104022.GA6742@bicker>
References: <20101011035416.GD5851@bicker>
	<20101011104009.GB9231@rakim.wolfsonmicro.main>
	<20101011164038.GE5851@bicker>
	<20101011185148.GB22355@opensource.wolfsonmicro.com>
	<20101011194502.GK5851@bicker> <s5hpqvg1m7v.wl%tiwai@suse.de>
	<20101012093506.GB30933@rakim.wolfsonmicro.main>
	<s5hvd57eo60.wl%tiwai@suse.de>
	<20101012095605.GC30933@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id B99B41039C9
	for <alsa-devel@alsa-project.org>;
	Tue, 12 Oct 2010 12:40:48 +0200 (CEST)
Received: by wwb28 with SMTP id 28so3881059wwb.20
	for <alsa-devel@alsa-project.org>; Tue, 12 Oct 2010 03:40:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101012095605.GC30933@rakim.wolfsonmicro.main>
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
Cc: alsa-devel@alsa-project.org, Jassi Brar <jassi.brar@samsung.com>, Takashi Iwai <tiwai@suse.de>, kernel-janitors@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@nokia.com>, linux-kernel@vger.kernel.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 12, 2010 at 10:56:05AM +0100, Mark Brown wrote:
> On Tue, Oct 12, 2010 at 11:49:27AM +0200, Takashi Iwai wrote:
> > Mark Brown wrote:
> 
> > Argh, yes, I'm (again) confused by that behavior.
> > The problem is the potential buffer overflow, indeed.  snprintf()
> > returns the size that would be printed.  Thus a safe code would be
> > like:
> > 
> > 	list_for_each_entry(dai, &dai_list, list) {
> >  		int len = snprintf(buf + ret, PAGE_SIZE - ret, "%s\n", dai->name);
> >  		if (len < 0)
> >  			continue;
> >  		ret += len;
> > 		if (ret >= PAGE_SIZE) {
> > 			ret = PAGE_SIZE;
> > 			break;
> > 		}
> > 	}
> 
> Yes, this form is better for that variant of the loop - that is safe and
> legible without relying on current implementation details of snprintf().

This is fine with me as well.  My original patch had a problem with the
WARN_ON() so your version is better.

regards,
dan carpenter
