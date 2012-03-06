From: Ashish Chavan <ashish.chavan@kpitcummins.com>
Subject: Re: Query about regmap SPI
Date: Tue, 6 Mar 2012 20:38:52 +0530
Message-ID: <1331046532.32512.35.camel@matrix>
References: <1331045140.32512.7.camel@matrix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1331045140.32512.7.camel@matrix>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, linux-kernel <linux-kernel@vger.kernel.org>, lrg <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2012-03-06 at 20:15 +0530, Ashish Chavan wrote:
> On Tue, Mar 06, 2012 at 12:53:51PM +0500, Ashish Chavan wrote:
> 

> Please always CC the relevant mailing lists on postings.  I shouldn't
> need to remind you about this stuff.

Yes, I agree :-(
It's my mistake that I missed linux-kernel@vger.kernel.org


> No, implementing stuff like this in individual device drivers rather
> defeats the point of having frameworks.  It sounds like it should be
> trivial to add support for this to regmap.

I also think that there should be a way to handle this kind of stuff by
the framework. May I know if you have any plan to add this to regmap? or
should I come up with a patch to extend regmap to support this and
propose you?
