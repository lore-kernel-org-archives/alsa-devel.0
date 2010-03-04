From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] ASoC: Add delay information for
	Samsung	IISv2 DAIs
Date: Thu, 4 Mar 2010 13:24:17 +0000
Message-ID: <20100304132416.GB12350@sirena.org.uk>
References: <1267704358-31501-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1b68c6791003040518k21b0894ap150bcad6a1195da3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 81ABE24337
	for <alsa-devel@alsa-project.org>; Thu,  4 Mar 2010 14:24:18 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1b68c6791003040518k21b0894ap150bcad6a1195da3@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: jassi brar <jassisinghbrar@gmail.com>
Cc: alsa-devel@alsa-project.org, Jassi <jassi.brar@samsung.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 04, 2010 at 10:18:59PM +0900, jassi brar wrote:
> On Thu, Mar 4, 2010 at 9:05 PM, Mark Brown

> > +static long s3c2412_i2s_delay(struct snd_pcm_substream *substream,
> > + ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ?? ??struct snd_soc_dai *dai)

> return type snd_pcm_sframes_t ?

Meh, yeah.  It's actually the same type underneath.

> I am trying to make functions in s3c-i2s-v2.c re-entrant as much as possible,
> 'delay' too seems to be a good candidate.

Could you expand on what you mean by this?  All we're doing here is
directly reporting a value read from a memory mapped register so there's
nothing to be worried about from a locking point of view unless there
were a multi-core system and the bus to the IP needed some locking,
which is vanishingly unlikely to ever happen.
