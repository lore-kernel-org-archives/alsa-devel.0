From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Clock generators in ASoC setups
Date: Fri, 3 Aug 2012 22:55:46 +0100
Message-ID: <20120803215545.GA4515@opensource.wolfsonmicro.com>
References: <500FABD0.4040001@gmail.com>
 <20120725105258.GH3099@opensource.wolfsonmicro.com>
 <501AE805.1060309@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D89882652AB
 for <alsa-devel@alsa-project.org>; Sat,  4 Aug 2012 12:04:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <501AE805.1060309@gmail.com>
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
Cc: alsa-devel <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Aug 02, 2012 at 10:50:13PM +0200, Daniel Mack wrote:
> On 25.07.2012 12:52, Mark Brown wrote:
> > On Wed, Jul 25, 2012 at 10:18:24AM +0200, Daniel Mack wrote:

> > The problem here is that we don't have a usable clock API to work with.

> Hmm, could you elaborate a bit about the background here? So the idea is
> to have the clock framework that handles all system clocks also take
> care for clocks related to audio?

Yes, since many of them are the same clocks - we certainly have massive
overlap here and clocks can go in both directions.

> What would such a framework need to accomplish, and what missing in -
> for example - the common clock framework in that regard?

Well, for a start it'd need to be deployed on a useful set of platforms.
Right now we've not got any clock API at all on most platforms and only
a vanishingly small set are using the generic API.  I'm hopefully going
to persuade Arnd to unblock the one issue preventing me fixing the first
problem and obviously there's some progress on the second.

As things stand there just isn't a non-specific clock API that anything
that generates clocks can realistically use.
