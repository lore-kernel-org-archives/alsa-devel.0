From: Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH 1/1] ASoC: soc-pcm: DPCM cares BE channel
 constraint
Date: Tue, 26 Jun 2018 14:08:40 +0200
Message-ID: <1530014920.2900.50.camel@baylibre.com>
References: <20180620092520.14101-1-jiada_wang@mentor.com>
 <1530008318.2900.44.camel@baylibre.com>
 <20180626115526.GC1779@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f68.google.com (mail-wm0-f68.google.com [74.125.82.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 6FCC12675C8
 for <alsa-devel@alsa-project.org>; Tue, 26 Jun 2018 14:08:42 +0200 (CEST)
Received: by mail-wm0-f68.google.com with SMTP id u18-v6so1573810wmc.1
 for <alsa-devel@alsa-project.org>; Tue, 26 Jun 2018 05:08:42 -0700 (PDT)
In-Reply-To: <20180626115526.GC1779@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, jiada_wang@mentor.com, linux-kernel@vger.kernel.org, tiwai@suse.com
List-Id: alsa-devel@alsa-project.org

On Tue, 2018-06-26 at 12:55 +0100, Mark Brown wrote:
> On Tue, Jun 26, 2018 at 12:18:38PM +0200, Jerome Brunet wrote:
> > On Wed, 2018-06-20 at 18:25 +0900, jiada_wang@mentor.com wrote:
> > > +	/* DPCM used FE & BE merged channel */
> > > +	unsigned int dpcm_merged_chan:1;
> > Jiada, Mark,
> > Do you think we could extend this flag to let the link choose whether the merge
> > should be performed on the codec dais (as done here) or on the backend cpu dais
> > ?
> > I have more less the same need as Jiada but since my card uses multicodec links,
> > merging on the codec dais does not work for me.
> > Like in soc_pcm_init_runtime_hw(), we can't enforce channels min/max based on
> > the codec when there is multiple codecs on the link.
> 
> Ugh, probably that'd work.  The ideal thing would be to remove DPCM but
> we're stuck with it for the time being :(

>From comment here and in other mails, I get that you are not big fan of DPCM :)
It is indeed a complex beast ...

It there anything else we can use to represent audio routing within the SoC ?
The SoC I'm working on make heavy use of this, unfortunately. 
