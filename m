From: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] [v2] ASoC: cs4270: use the built-in
 register cache support
Date: Mon, 10 Jan 2011 11:35:50 -0600
Message-ID: <4D2B4376.101@freescale.com>
References: <1294675292-6289-1-git-send-email-timur@freescale.com>	
	<1294676990.11031.10.camel@dplaptop.localdomain>	
	<4D2B34C1.7050209@freescale.com>
	<1294677365.11031.13.camel@dplaptop.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from TX2EHSOBE008.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) by alsa0.perex.cz (Postfix) with ESMTP id E97BB24560
	for <alsa-devel@alsa-project.org>; Mon, 10 Jan 2011 18:35:59 +0100 (CET)
In-Reply-To: <1294677365.11031.13.camel@dplaptop.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

Dimitris Papastamos wrote:
> There's not much that can be done for error recovery at that point.
> Usually a failing snd_soc_read()/snd_soc_write() will complain wildly
> with errors from the underlying bus.  The only place that
> snd_soc_read()/snd_soc_write() are checked for errors is usually in
> _probe() functions.

I did a little digging, and I found something of concern, but I'm not sure if
there's a real problem.

On the surface, it appears that all current callers of snd_soc_update_bits() can
handle a negative return code.  In fact, a lot of existing code already assumes
that it does return error codes.

My concern is that there may be some higher-level function that is *not*
expecting a return value of 1 from snd_soc_update_bits().  For example, take
wm8904_put_deemph().  This function calls wm8904_set_deemph(), which ends with this:

	return snd_soc_update_bits(codec, WM8904_DAC_DIGITAL_1,
				   WM8904_DEEMPH_MASK, val);


This doesn't seem right to me.  Here, the .put function returns 0 or 1,
depending on whether or not the bits were actually updated.  Is that what's
intended?  I can't find any documentation that tells me what the return values
of snd_kcontrol_put_t are supposed to be.

-- 
Timur Tabi
Linux kernel developer at Freescale
