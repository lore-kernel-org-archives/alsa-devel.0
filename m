From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH - alsa-lib 2/3] tlv: Handle 'holes'
	in	SND_CTL_TLVT_DB_RANGE array
Date: Mon, 19 Jul 2010 17:01:10 +0100
Message-ID: <20100719160109.GC7002@sirena.org.uk>
References: <1279523646-4987-1-git-send-email-peter.ujfalusi@nokia.com>
	<1279523646-4987-3-git-send-email-peter.ujfalusi@nokia.com>
	<s5heiezfp1c.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id CD65A244F1
	for <alsa-devel@alsa-project.org>;
	Mon, 19 Jul 2010 18:01:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5heiezfp1c.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Peter Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 19, 2010 at 05:51:27PM +0200, Takashi Iwai wrote:
> Peter Ujfalusi wrote:

> > If user asks for 1dB the snd_tlv_convert_from_dB will not find
> > the raw value, since the 1dB is not part of either range.

> In the case above, can't you set like

> 	TLV_DB_RANGE_HEAD(2),
> 	0, 2, TLV_DB_SCALE_ITEM(-1000, 500, 0),
> 	2, 4, TLV_DB_SCALE_ITEM(0, 200, 0)

> ??

So, this came from a review comment from me in response to a patch doing
just that.  The issue I had was that this definition of overlapping
ranges really feels like the kernel is bodging around limitations of the
userspace library - the library is already trying to find the best match
among the actual dB values available, it seems silly that it requires
the kernel to provide patches between the ranges.  It's moderately
painful, especially if you have a bunch of values that aren't very well
joined together in the hardware.
