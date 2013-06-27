From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH 2/4] MFD: twl6040: Update register bit
	definitions
Date: Thu, 27 Jun 2013 10:25:03 +0200
Message-ID: <20130627082503.GE4576@zurbaran>
References: <1372081326-6917-1-git-send-email-peter.ujfalusi@ti.com>
 <1372081326-6917-3-git-send-email-peter.ujfalusi@ti.com>
 <20130627080547.GD4576@zurbaran>
 <20130627082003.GU27646@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
 by alsa0.perex.cz (Postfix) with ESMTP id E1068265588
 for <alsa-devel@alsa-project.org>; Thu, 27 Jun 2013 10:26:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20130627082003.GU27646@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, patches@linaro.org, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, Peter Ujfalusi <peter.ujfalusi@ti.com>, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 27, 2013 at 09:20:03AM +0100, Mark Brown wrote:
> On Thu, Jun 27, 2013 at 10:05:47AM +0200, Samuel Ortiz wrote:
> 
> > I don't see the rest of the patchset, so I can't tell if there's a build
> > time dependeny between this one and the other patches.
> > I applied it for now, please let me know if you'd like the whole
> > patchset to go through another tree at once.
> 
> There's build dependencies - the new register bits are used by the
> following patches.  I'd already applied this to ASoC and sent it
> upstream unfortunately so I can't rebase it out or pull in your commit
> instead sadly.
No worries, that shouldn't cause any merge issues.
I dropped it from mfd-next.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
