From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: adding an external dsp under soc-dsp framework
Date: Wed, 8 Aug 2012 11:59:20 +0100
Message-ID: <20120808105919.GJ16861@opensource.wolfsonmicro.com>
References: <FC1850374E3CB245B9E97002380578E0022216D4@ILMAIL01.dspg.com>
 <20120806154822.GP16861@opensource.wolfsonmicro.com>
 <loom.20120806T203950-581@post.gmane.org>
 <20120807140902.GH29272@sirena.org.uk>
 <FC1850374E3CB245B9E97002380578E002221820@ILMAIL01.dspg.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 525E6265F91
 for <alsa-devel@alsa-project.org>; Wed,  8 Aug 2012 12:36:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <FC1850374E3CB245B9E97002380578E002221820@ILMAIL01.dspg.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Ziv Haziz <Ziv.Haziz@dspg.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Aug 08, 2012 at 11:21:20AM +0300, Ziv Haziz wrote:

> >I n that case what you're saying above with a DAI link is exactly what
> > you're supposed to do, I don't see any structural problem here?

> Creating two dai links will create two separated devices which must be
> open for setting configurations, but the dsp-codec dai cannot be started
> (or I will get an  error). This means changing the codec driver to
> enable everything not from trigger callback.

> Is it possible to have a dai link without a platform for data transfer?
> I saw in the plumbers agenda you are going to talk on codec-codec
> interface - do you have any preliminary suggestion?

This is already supported in mainline, look at littlemill for one
example user.

Alternatively for older kernels you can easily support this from
userspace by just not starting the DMA, this has been deployed for some
considerable time on many systems (OpenMoko is one long standing
mainline example).
