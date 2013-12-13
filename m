From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH] ASoC: omap-pcm: Lower the dma
	coherent	mask to 32bits
Date: Fri, 13 Dec 2013 11:49:10 +0000
Message-ID: <20131213114910.GF4360@n2100.arm.linux.org.uk>
References: <1386230802-3660-1-git-send-email-peter.ujfalusi@ti.com>
 <20131205095619.GC4360@n2100.arm.linux.org.uk> <52A09CDA.6010700@ti.com>
 <20131205192853.GH4360@n2100.arm.linux.org.uk> <s5h4n6nhxbt.wl%tiwai@suse.de>
 <20131205210707.GI4360@n2100.arm.linux.org.uk> <s5htxemgzyx.wl%tiwai@suse.de>
 <20131209170300.GW4360@n2100.arm.linux.org.uk> <52A6E0C5.1080103@ti.com>
 <52AAF3A6.7000306@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 4F216260320
 for <alsa-devel@alsa-project.org>; Fri, 13 Dec 2013 12:49:27 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <52AAF3A6.7000306@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 13, 2013 at 01:46:46PM +0200, Peter Ujfalusi wrote:
> On 12/10/2013 11:37 AM, Peter Ujfalusi wrote:
> > Hi Russell,
> > 
> > On 12/09/2013 07:03 PM, Russell King - ARM Linux wrote:
> >> Yes, that's a good idea.  Revised version of the patch.  Peter, can you
> >> retest please, thanks.
> > 
> > With this patch PandaES and BeagleXM works fine on top of today's mainline.
> > 
> > Thank you Russell and Takashi!
> > 
> > Tested-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> 
> Russell,
> 
> are you planning to send this for 3.13? Without the patch all OMAP audio fails
> to probe in 3.13 kernel.

It's queued up in -fixes, but there's a few other fixes in progress which
I want to get together before I finally push it to Linus.
