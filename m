From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 5/5] ASoC: fsl: mpc5200 remove pcm030 and
 efika audio fabric
Date: Thu, 13 Sep 2012 12:27:39 +0800
Message-ID: <20120913042737.GC6732@opensource.wolfsonmicro.com>
References: <1347416089-23393-1-git-send-email-emillbrandt@dekaresearch.com>
 <1347416089-23393-6-git-send-email-emillbrandt@dekaresearch.com>
 <20120912032026.GI9162@opensource.wolfsonmicro.com>
 <0A40042D85E7C84DB443060EC44B3FD336D854FEE2@dekaexchange07.deka.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C109D2616F1
 for <alsa-devel@alsa-project.org>; Thu, 13 Sep 2012 06:27:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <0A40042D85E7C84DB443060EC44B3FD336D854FEE2@dekaexchange07.deka.local>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Eric Millbrandt <emillbrandt@dekaresearch.com>
Cc: Grant Likely <grant.likely@secretlab.ca>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Anatolij Gustschin <agust@denx.de>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 12, 2012 at 10:05:33AM -0400, Eric Millbrandt wrote:

Please fix your mailer to word wrap within paragraphs.

> On 2012-09-11 Mark Brown wrote:

> > I only noticed DT bindings being added for pcm030, not for efika?

> When I looked I didn't see the Efika (PPC 5200B) DT in-tree.  It only
> appears to exist out-of-tree,

Hrm, well - that's not terribly clever.  It'll mean a regression on
existing systems and since they're clearly taking advantage of the
ability to distribute the device tree separately...  we'd really want
some sort of backwards compatibility to avoid breaking upgrades.  Not
sure what the normal way of doing that is.
