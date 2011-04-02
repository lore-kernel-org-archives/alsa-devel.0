From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: rename dapm_generic_apply_power()
Date: Sat, 2 Apr 2011 16:35:29 +0900
Message-ID: <20110402073527.GA28417@opensource.wolfsonmicro.com>
References: <1301729016-355-1-git-send-email-guanqun.lu@intel.com>
	<1301729016-355-2-git-send-email-guanqun.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 51DF410381A
	for <alsa-devel@alsa-project.org>;
	Sat,  2 Apr 2011 09:35:20 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1301729016-355-2-git-send-email-guanqun.lu@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lu Guanqun <guanqun.lu@intel.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Sat, Apr 02, 2011 at 03:23:36PM +0800, Lu Guanqun wrote:
> dapm_generic_apply_power() is only called in dapm_seq_run() when w->id is
> snd_soc_dapm_{input|output|hp|line|mic}. So, it's not a generic function at
> all, we better rename it to reflect what it's doing.

I don't think you've really understood what the code is doing here.
While it's true that we don't ever call this function for most widget
types due to the write compression code it is actually the generic
method for applying power changes to a widget in isolation - it does a
register update surrounded by the event callbacks in the appropriate
sequence which really is something that is generic to all widgets.  A
better question if you want to refector the code here would be why these
widgets are treated differently to other widgets.
