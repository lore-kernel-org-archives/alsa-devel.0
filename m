From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v2] ALSA: ASoC: McASP: add support for 24
 bit samples
Date: Tue, 9 Oct 2012 19:24:21 +0900
Message-ID: <20121009102331.GB15207@opensource.wolfsonmicro.com>
References: <A551BDF323A45B48ACE6A404AA16A1C412786E53@TOP-EX01.TOPIC.LOCAL>
 <5073F2CD.9010407@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BC3B9264EF5
 for <alsa-devel@alsa-project.org>; Tue,  9 Oct 2012 12:24:58 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <5073F2CD.9010407@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: Mike Looijmans <mike.looijmans@topic.nl>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 09, 2012 at 11:47:57AM +0200, Daniel Mack wrote:
> On 09.10.2012 11:41, Mike Looijmans wrote:
> > Sorry for the lack of quoting, but I onle get the digest.

> > These are wrong:

> > +       case SNDRV_PCM_FORMAT_U24_LE: +       case
> > SNDRV_PCM_FORMAT_S24_LE:

> > These pack a 24-bit sample value in a 32-bit word. The codec will
> > send 32 bits to the McASP, and you should transfer 32 bits to the
> > user, not just 24. Hence, SNDRV_PCM_FORMAT_S24_LE must be treated
> > just like SNDRV_PCM_FORMAT_S32_LE.

> > I've tested that on a DA850-alike board with several TLV320AIC3256
> > codecs, treating them as 3-byte samples will reasult in invalid
> > data.

> Ok, thanks for reporting this. Would like to send a patch or want me to
> fix it?

The above explanation isn't quite right.  For 24 bit the CODEC should be
working with 24 bits on the wire (though obviously extra BCLKs are
allowed) and the AP should be working with 32 bit words in memory.  The
issue here is probably that you're working with real 24 bit data in RAM
too.
