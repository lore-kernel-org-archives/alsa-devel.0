From: Lu Guanqun <guanqun.lu@intel.com>
Subject: Re: [PATCH 2/2] ASoC: rename dapm_generic_apply_power()
Date: Sat, 2 Apr 2011 15:44:33 +0800
Message-ID: <20110402074433.GF14553@qtel.sh.intel.com>
References: <1301729016-355-1-git-send-email-guanqun.lu@intel.com>
	<1301729016-355-2-git-send-email-guanqun.lu@intel.com>
	<20110402073527.GA28417@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 4DBC510381A
	for <alsa-devel@alsa-project.org>;
	Sat,  2 Apr 2011 09:45:06 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110402073527.GA28417@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

On Sat, Apr 02, 2011 at 03:35:29PM +0800, Mark Brown wrote:
> On Sat, Apr 02, 2011 at 03:23:36PM +0800, Lu Guanqun wrote:
> > dapm_generic_apply_power() is only called in dapm_seq_run() when w->id is
> > snd_soc_dapm_{input|output|hp|line|mic}. So, it's not a generic function at
> > all, we better rename it to reflect what it's doing.
> 
> I don't think you've really understood what the code is doing here.
> While it's true that we don't ever call this function for most widget
> types due to the write compression code it is actually the generic

I don't get into write compression code yet, do you mean by "coalesce
register writes", that part of code?

> method for applying power changes to a widget in isolation - it does a
> register update surrounded by the event callbacks in the appropriate
> sequence which really is something that is generic to all widgets.  A
> better question if you want to refector the code here would be why these
> widgets are treated differently to other widgets.

-- 
guanqun
