From: Dan Carpenter <error27@gmail.com>
Subject: Re: [patch] ASoC: soc: snprintf() doesn't return
	negative
Date: Mon, 11 Oct 2010 18:40:38 +0200
Message-ID: <20101011164038.GE5851@bicker>
References: <20101011035416.GD5851@bicker>
	<20101011104009.GB9231@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 467A2103800
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Oct 2010 18:41:06 +0200 (CEST)
Received: by wyb32 with SMTP id 32so2015549wyb.38
	for <alsa-devel@alsa-project.org>; Mon, 11 Oct 2010 09:41:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20101011104009.GB9231@rakim.wolfsonmicro.main>
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

On Mon, Oct 11, 2010 at 11:40:09AM +0100, Mark Brown wrote:
> On Mon, Oct 11, 2010 at 05:54:17AM +0200, Dan Carpenter wrote:
> > In user space snprintf() returns negative on errors but the kernel
> > version only returns positives.  It could potentially return sizes
> 
> I'm not going to apply this. snprintf() returns a signed type, checking
> that the return value is a reasonable thing to do here - at worst we're
> wasting a few cycles in code that's nowhere near a hot path, at best
> we're robust in the face of a decision to add error reporting to
> snprintf() so it's hard to see this change as an improvement.
> 

It's not a matter of cycles.  My check probably takes the exact same
number of cycles as your check.  The point is that checking for negative
doesn't make any sort of sense.  If we did return an error code then we
should check it immediately after return instead of adding it to previous
return code.

The snprintf() function is documented.  It can't be changed because that
would break a ton of code as explained below.

> > larger than the size of the buffer so we should check for that.
> 
> > -	if (ret >= 0)
> > -		ret = simple_read_from_buffer(user_buf, count, ppos, buf, ret);
> > +	if (ret > PAGE_SIZE)
> > +		ret = PAGE_SIZE;
> > +
> > +	ret = simple_read_from_buffer(user_buf, count, ppos, buf, ret);
> 
> The PAGE_SIZE part of the change has an issue too, the code immediately
> preceeding this is:
> 
> 	list_for_each_entry(codec, &codec_list, list)
> 		ret += snprintf(buf + ret, PAGE_SIZE - ret, "%s\n",
> 				codec->name);
> 
> so it's rather late to be worrying about PAGE_SIZE after the loop.
> 

There is no buffer overflow in these lines.  If "ret" *were* a negative
then there would be.  In that scenario we could end up copying data
before the start of the buffer because "buf - ret" could be before the
start of the buffer and we could end up copying after the end of the
buffer because "PAGE_SIZE - ret" would be larger than PAGE_SIZE.

If "PAGE_SIZE - ret" is a negative number then it triggers a
WARN_ON_ONCE() in vsnprintf().  It's not possible in this case however.
Really the original code works fine in practice because the information
we are printing out is less than PAGE_SIZE.

So my patch is effectively just a code cleanup.  If you don't apply it,
I'll probably sob into my pillow until it's wet but in the end it
doesn't matter much either way.  :P

regards,
dan carpenter

> Please also try to be a bit more thoughtful in your use of
> get_maintainers; try to have a look at why people have come up and
> consider if it's really sensible to include them.
