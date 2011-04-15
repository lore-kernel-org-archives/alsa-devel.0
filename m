From: Lu Guanqun <guanqun.lu@intel.com>
Subject: Re: [PATCH V3 1/5] sound: asoc: Adding support for
 STA529 Audio Codec
Date: Fri, 15 Apr 2011 22:10:27 +0800
Message-ID: <20110415141027.GA19186@qtel.sh.intel.com>
References: <1302499804-24386-1-git-send-email-rajeev-dlh.kumar@st.com>
	<1302499804-24386-2-git-send-email-rajeev-dlh.kumar@st.com>
	<20110411145621.GA26769@opensource.wolfsonmicro.com>
	<s5h62qhma4c.wl%tiwai@suse.de>
	<20110414141936.GD31985@qtel.sh.intel.com>
	<20110414142845.GE31985@qtel.sh.intel.com>
	<s5hk4evlv9a.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
	by alsa0.perex.cz (Postfix) with ESMTP id 5A9CA1037EC
	for <alsa-devel@alsa-project.org>;
	Fri, 15 Apr 2011 16:11:12 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hk4evlv9a.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Rajeev Kumar <rajeev-dlh.kumar@st.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 15, 2011 at 05:27:29PM +0800, Takashi Iwai wrote:
> In alsa-mixer abstraction, the "Capture Source" enum control is split
> over multiple switches (a switch per enum item).  This was a historical
> design at the time SoundBlaster is still standard.
> 
> One of the problems with this abstraction is that it can't handle
> multiple capture-source controls.  So, many drivers use nowadays
> "Input Source" control instead.  But, in the earlier alsa-lib, this
> wasn't handled as the capture control, thus it appears as a global
> (both directional) control in alsamixer.
> 
> Now, this control is handled as a capture control in alsa-lib, so the
> appearance is corrected.
> 

Thanks for your insightful information. :)
Much appreciated!

-- 
guanqun
