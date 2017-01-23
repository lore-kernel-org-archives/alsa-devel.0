From: Jeeja KP <jeeja.kp@intel.com>
Subject: Re: [PATCH v2 02/13] ASoC: hdac_hdmi: Register widget
	event handlers
Date: Mon, 23 Jan 2017 15:35:03 +0530
Message-ID: <20170123100502.GA32369@kpjeeja-desk>
References: <1484755493-30595-1-git-send-email-jeeja.kp@intel.com>
 <1484755493-30595-3-git-send-email-jeeja.kp@intel.com>
 <20170120133535.tun4a57dr3pkispw@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id D1A2826680F
 for <alsa-devel@alsa-project.org>; Mon, 23 Jan 2017 10:53:49 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20170120133535.tun4a57dr3pkispw@sirena.org.uk>
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
Cc: tiwai@suse.de, patches.audio@intel.com, alsa-devel@alsa-project.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

On Fri, Jan 20, 2017 at 01:35:35PM +0000, Mark Brown wrote:
> On Wed, Jan 18, 2017 at 09:34:42PM +0530, jeeja.kp@intel.com wrote:
> > From: Jeeja KP <jeeja.kp@intel.com>
> > 
> > In case of hdmi connect/disconnect or when stream need to be route to
> > multiple monitors, corresponding port and audio infoframe needs to be
> > reconfigured. Currently all the configuration are done in DAI ops which
> > results in silence playback.
> 
> This doesn't apply against current code, please check and resend.

Hi Mark,

This series has dependency on DRM changes. I looked at the topic/intel
branch, and it doesn't have the DRM changes which are already merged in
4.10-rc1. Please let me know how should I resend the patches.

Regards,
Jeeja



-- 
