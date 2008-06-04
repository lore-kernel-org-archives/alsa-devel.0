From: Geoffrey Wossum <geoffrey@pager.net>
Subject: Re: [PATCH] Revised AT32 ASoC Patch
Date: Wed, 4 Jun 2008 08:38:33 -0500
Message-ID: <200806040838.33676.geoffrey@pager.net>
References: <200806031103.10785.geoffrey@pager.net>
	<s5hd4mx5ryk.wl%tiwai@suse.de>
	<20080604132806.GB2166@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from barracuda.pager.net (mail.pager.net [209.253.16.26])
	by alsa0.perex.cz (Postfix) with ESMTP id 9C02524415
	for <alsa-devel@alsa-project.org>;
	Wed,  4 Jun 2008 15:38:07 +0200 (CEST)
Received: from [192.168.1.71] (localhost [127.0.0.1])
	by barracuda.pager.net (Spam Firewall) with ESMTP id B9D83C34AF
	for <alsa-devel@alsa-project.org>; Wed,  4 Jun 2008 08:38:05 -0500 (CDT)
Received: from [192.168.1.71] ([192.168.1.1]) by barracuda.pager.net with
	ESMTP id DjkBYew5NhnOfhlb for <alsa-devel@alsa-project.org>;
	Wed, 04 Jun 2008 08:38:05 -0500 (CDT)
In-Reply-To: <20080604132806.GB2166@sirena.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wednesday 04 June 2008 08:28:07 am Mark Brown wrote:
> On Wed, Jun 04, 2008 at 02:01:55PM +0200, Takashi Iwai wrote:
> > Geoffrey Wossum wrote:
> > > +struct at32_ssc_info {
> > > +	char *name;
> > > +	struct ssc_device *ssc;
> > > +	spinlock_t lock;	/* lock for dir_mask */
> >
> > Just wondering whether this lock is really needed.
> > Is it really racy?
>
> Bidirectional ports could be in two PCMs and have configuration
> happening simultaneously.

To be honest, the AT91 code I was porting to the AT32 had this lock.  I think 
Mark is correct, so it's probably good I wasn't writing this code from 
scratch since I might have missed this detail on the first pass.

---
Geoffrey
