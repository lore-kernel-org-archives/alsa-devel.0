From: Jeeja KP <jeeja.kp@intel.com>
Subject: Re: [PATCH 5/6] ASoC: Intel: bxtn: Fix to store the
 FW/Library context at boot
Date: Mon, 9 Jan 2017 13:53:17 +0530
Message-ID: <20170109082317.GA8440@kpjeeja-desk>
References: <1483330807-9518-1-git-send-email-jeeja.kp@intel.com>
 <1483330807-9518-6-git-send-email-jeeja.kp@intel.com>
 <20170106181404.iv7zpaceif3svlil@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id D401326669C
 for <alsa-devel@alsa-project.org>; Mon,  9 Jan 2017 09:12:20 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20170106181404.iv7zpaceif3svlil@sirena.org.uk>
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

On Fri, Jan 06, 2017 at 06:14:04PM +0000, Mark Brown wrote:
> On Mon, Jan 02, 2017 at 09:50:06AM +0530, jeeja.kp@intel.com wrote:
> > From: Jeeja KP <jeeja.kp@intel.com>
> > 
> > Store the DSP firmware/library at boot, so that for S3 to S0 transition
> > use the stored ctx for downloading the firmware to DSP memory.
> 
> This doesn't apply against current code, please check and resend.  It's
> also odd to see fixes like this at the end of the series after cleanups,
> I'd expect fixes to come earlier in the series as they should go to
> Linus wheras cleanups just go on the development branches.

I have developed this fix on the firmware download optimization. This fix
depends on this in the series "Driver updates on DSP firmware" for firmware
download optimization. 
Sorry I missed to mention that in the cover letter, will take care of this
details from next time.
-- 
