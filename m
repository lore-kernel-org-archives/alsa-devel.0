From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: question on static dapm routes
Date: Fri, 17 Dec 2010 11:20:33 +0000
Message-ID: <20101217112033.GA31453@rakim.wolfsonmicro.main>
References: <w3pr5dhgij9.wl%kuninori.morimoto.gx@renesas.com>
	<98769532B4BB14429434178695419EAE053B898E04@bgsmsx501.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7A5D610388D
	for <alsa-devel@alsa-project.org>; Fri, 17 Dec 2010 12:20:35 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <98769532B4BB14429434178695419EAE053B898E04@bgsmsx501.gar.corp.intel.com>
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
Cc: "Koul, Vinod" <vinod.koul@intel.com>, Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 17, 2010 at 01:56:36PM +0530, Harsha, Priya wrote:

> In the codec file which we are trying to write, we do not have any dynamic 
> Switching paths. So for the structure snd_soc_dapm_route, its always
> 		{sink, NULL, source}.
> The DAPM widgets are getting enabled at the codec probe
> (as we saw that they are getting declared as static) . So this consumes 
> power and we want them do be turned on only when DAI is started?

This most likely indicates an error in your DAPM map.  DAPM will only
power on audio routes which have a fully connected path from an input to
an output - you will have defined a path which includes the widgets
which are getting powered on.  Looking through the debugfs file for DAPM
should let you see which path this is.

> So, does that mean that for every stream, we make use of the startup and 
> shutdown functions to do our power management of the widgets. Or is there a 
> way ASOC automatically takes care of powering of the static paths as well?

If your device contains unconditionally connected paths the machine
driver should use SOC_DAPM_PIN_SWITCH() to add relevant controls for the
power if it needs them, or use something like jack detection if that's
supported.
