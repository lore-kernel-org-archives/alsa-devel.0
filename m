From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 1/3] ASoC: soc_jack - add function to
 determine jack type
Date: Tue, 1 Feb 2011 13:43:53 +0000
Message-ID: <20110201134352.GF12743@opensource.wolfsonmicro.com>
References: <1296234579-6622-1-git-send-email-priya.harsha@intel.com>
	<20110131120826.GD5123@opensource.wolfsonmicro.com>
	<98769532B4BB14429434178695419EAE08C0FE9A4D@bgsmsx501.gar.corp.intel.com>
	<20110201132206.GE12743@opensource.wolfsonmicro.com>
	<98769532B4BB14429434178695419EAE08C0FE9A6C@bgsmsx501.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C0D0110394A
	for <alsa-devel@alsa-project.org>; Tue,  1 Feb 2011 14:43:56 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <98769532B4BB14429434178695419EAE08C0FE9A6C@bgsmsx501.gar.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Harsha, Priya" <priya.harsha@intel.com>
Cc: "Koul, Vinod" <vinod.koul@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 01, 2011 at 07:05:26PM +0530, Harsha, Priya wrote:

Please fix the word wrapping in your MUA to wrap at less than 80
columns.

> What if I add a field debouce to snd_soc_jack and machine driver needs
> to program the value. The codec driver should wait for that time
> before reading the adc values Will this help

The driver providing the ADC (which may not be part of a CODEC at all)
shouldn't have to worry about this stuff unless it's done the
debouncing - we should avoid having to open code functionality in
individual drivers.  It feels like we should have actual code for
managing the process of detecting what's connected, with flexibility to
handle things like pre-debouncing.  If some of it is left sketchy in the
first instance that's OK but we should have an idea what the overall
picture is.
