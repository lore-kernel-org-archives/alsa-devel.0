From: Samuel Ortiz <sameo@linux.intel.com>
Subject: Re: [PATCH 2/4] MFD: twl6040: Update register bit
	definitions
Date: Thu, 27 Jun 2013 10:05:47 +0200
Message-ID: <20130627080547.GD4576@zurbaran>
References: <1372081326-6917-1-git-send-email-peter.ujfalusi@ti.com>
 <1372081326-6917-3-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 790FF265583
 for <alsa-devel@alsa-project.org>; Thu, 27 Jun 2013 10:07:00 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1372081326-6917-3-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, patches@linaro.org, Liam Girdwood <lgirdwood@gmail.com>, Jyri Sarha <jsarha@ti.com>, Mark Brown <broonie@kernel.org>, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

Hi Peter,

On Mon, Jun 24, 2013 at 03:42:04PM +0200, Peter Ujfalusi wrote:
> Add define for: HSDRV, HFDAC, HFPGA and HFDRV enable bits
> 
> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> CC: Samuel Ortiz <sameo@linux.intel.com>
> ---
>  include/linux/mfd/twl6040.h | 7 +++++++
>  1 file changed, 7 insertions(+)
I don't see the rest of the patchset, so I can't tell if there's a build
time dependeny between this one and the other patches.
I applied it for now, please let me know if you'd like the whole
patchset to go through another tree at once.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
