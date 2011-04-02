From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/2] ASoC: rename dapm_generic_apply_power()
Date: Sat, 2 Apr 2011 16:46:44 +0900
Message-ID: <20110402074643.GB28417@opensource.wolfsonmicro.com>
References: <1301729016-355-1-git-send-email-guanqun.lu@intel.com>
	<1301729016-355-2-git-send-email-guanqun.lu@intel.com>
	<20110402073527.GA28417@opensource.wolfsonmicro.com>
	<20110402074433.GF14553@qtel.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 6D8C210381A
	for <alsa-devel@alsa-project.org>;
	Sat,  2 Apr 2011 09:46:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20110402074433.GF14553@qtel.sh.intel.com>
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
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Sat, Apr 02, 2011 at 03:44:33PM +0800, Lu Guanqun wrote:
> On Sat, Apr 02, 2011 at 03:35:29PM +0800, Mark Brown wrote:

> > I don't think you've really understood what the code is doing here.
> > While it's true that we don't ever call this function for most widget
> > types due to the write compression code it is actually the generic

> I don't get into write compression code yet, do you mean by "coalesce
> register writes", that part of code?

Yes.
