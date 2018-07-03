From: Jerome Brunet <jbrunet@baylibre.com>
Subject: Re: [PATCH v3 0/2] ASoC: add es7241 support
Date: Tue, 03 Jul 2018 17:36:19 +0200
Message-ID: <1530632179.2900.210.camel@baylibre.com>
References: <20180703132845.26554-1-jbrunet@baylibre.com>
 <20180703153212.GC13744@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f67.google.com (mail-wm0-f67.google.com [74.125.82.67])
 by alsa0.perex.cz (Postfix) with ESMTP id D0C7426771C
 for <alsa-devel@alsa-project.org>; Tue,  3 Jul 2018 17:36:20 +0200 (CEST)
Received: by mail-wm0-f67.google.com with SMTP id n17-v6so2792612wmh.2
 for <alsa-devel@alsa-project.org>; Tue, 03 Jul 2018 08:36:20 -0700 (PDT)
In-Reply-To: <20180703153212.GC13744@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Tue, 2018-07-03 at 16:32 +0100, Mark Brown wrote:
> On Tue, Jul 03, 2018 at 03:28:43PM +0200, Jerome Brunet wrote:
> > Add support for the es7241 which is a simple 2 channels analog to
> > digital converter.
> 
> Please don't resubmit patches that have already been applied, you should
> submit patches against current code in the tree you're expecting things
> to be applied to.  If any updates are needed to a patch that's already
> been applied you should submit incremental patches which make those
> updates.  This avoids having to change published git commits which could
> cause problems for people working against git.

Unless I missed something, which entirely possible, I don't think any patches of
this series have been applied yet. You asked me resubmit after the v1 because of
 power supply bindings and the mode selection.

I don't see anything related to the es7241 in your tree ATM.
