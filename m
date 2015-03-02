From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: wm8804: Add DAPM widgets for
	SPDIF/AIF
Date: Mon, 2 Mar 2015 21:35:16 +0000
Message-ID: <20150302213516.GA8553@opensource.wolfsonmicro.com>
References: <1425319075-10400-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <1425319075-10400-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
 <20150302181613.GB21293@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8856A260542
 for <alsa-devel@alsa-project.org>; Mon,  2 Mar 2015 22:41:28 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20150302181613.GB21293@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, info@crazy-audio.com, lgirdwood@gmail.com, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

On Mon, Mar 02, 2015 at 06:16:13PM +0000, Mark Brown wrote:
> On Mon, Mar 02, 2015 at 05:57:55PM +0000, Charles Keepax wrote:
> 
> > Firstly, 'Input Source' changes names to 'Tx Source' this is a
> > lot clearer, but perhaps we shouldn't change this, as it doesn't
> > have to change?
> 
> Yes, leave it be.  If you were renaming this should be in the changelog
> with an explanation as to why.

Cool can do.

> 
> > Secondly, the patch removes the controls 'TX Playback Switch' and
> > 'AIF Playback Switch' as these bits are controlled by DAPM now. I
> > wasn't sure if it would be preferrable to leave dummy controls that
> > do nothing?
> 
> This sounds like you need a more detailed changelog entry explaining why
> it's a good idea to do this in the first place, never mind the proxy
> control - what is the purpose of this change and what benefit will it
> bring?  Given that this is a S/PDIF bridge it's not at all obvious that
> the chip will be used in applications where the sort of power savings
> you're likely to see from powering down one of the links (as opposed to
> cutting the power to the chip) are likely to register.  Why move those
> bits to DAPM control at all?

Hmm... I hadn't really thought about it like that, mostly I had
viewed this somewhat as a nice modernization of the driver. I am
pretty sure there are some benefits around the clocking from
disabling the RX path (which is never disabled currently) as this
exercises some automatic control over the PLL whilst active,
which can be difficult to handle. But I guess that could also
just be handled by adding a control to disable it. Let us try
redrafting the commit message and we can see where that takes us
I guess.

> 
> I also note that this patch is apparently written by but not CCed to
> Sapthagiri Baratam.

He is on the patches alias, but yes that was rather remiss of me
not to directly CC him.

Thanks,
Charles
