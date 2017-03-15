From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 0/3] ASoC: add dio2125 amplifier support
Date: Wed, 15 Mar 2017 12:07:50 -0500
Message-ID: <20170315170750.pw3552bwc6fwwpwg@rob-hp-laptop>
References: <20170306174451.24406-1-jbrunet@baylibre.com>
 <1488903977.28627.4.camel@baylibre.com>
 <20170308100020.dop5pno3m2sj6fmv@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f43.google.com (mail-pg0-f43.google.com [74.125.83.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 4AC0926702B
 for <alsa-devel@alsa-project.org>; Wed, 15 Mar 2017 18:07:52 +0100 (CET)
Received: by mail-pg0-f43.google.com with SMTP id n190so11909546pga.0
 for <alsa-devel@alsa-project.org>; Wed, 15 Mar 2017 10:07:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20170308100020.dop5pno3m2sj6fmv@sirena.org.uk>
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
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Neil Armstrong <narmstrong@baylibre.com>, Kevin Hilman <khilman@baylibre.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Jerome Brunet <jbrunet@baylibre.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Mar 08, 2017 at 11:00:20AM +0100, Mark Brown wrote:
> On Tue, Mar 07, 2017 at 05:26:17PM +0100, Jerome Brunet wrote:
> > Hi Mark,
> 
> Please don't top post, reply in line with needed context.  This allows
> readers to readily follow the flow of conversation and understand what
> you are talking about and also helps ensure that everything in the
> discussion is being addressed.
> 
> > In this series, you applied patch 2 and 3 but not patch 1.
> > (so the dioo prefix is used but not documented)
> 
> > Is it on purpose ?
> > The patch does not have the "ASoC" prefix, this maybe why it was
> > missed. Since, the file does no belong to alsa, I wasn't sure whether
> > to put the prefix or not.
> 
> This is a generic DT patch, not part of the bindings, so I'd expect the
> DT maintainers to take it.

I usually don't if it's part of a series, but I have applied it.

Rob
