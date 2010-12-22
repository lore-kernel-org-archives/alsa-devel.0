From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: asoc SND_SOC_DAPM_AIF_IN question
Date: Wed, 22 Dec 2010 17:55:03 +0000
Message-ID: <20101222175503.GA27401@opensource.wolfsonmicro.com>
References: <438BB0150E931F4B9CE701519A44630104C104C2AA@bgsmsx502.gar.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id B472D244E4
	for <alsa-devel@alsa-project.org>; Wed, 22 Dec 2010 18:54:52 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <438BB0150E931F4B9CE701519A44630104C104C2AA@bgsmsx502.gar.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Koul, Vinod" <vinod.koul@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Harsha,
	Priya" <priya.harsha@intel.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, Dec 22, 2010 at 10:39:55PM +0530, Koul, Vinod wrote:

> So my codec map looks like:
>         /*headset map*/
>         { "HSDAC Left", NULL, "PCM_In"},
>         { "HSDAC Right", NULL, "PCM_In"},
>         { "PCM_In", NULL, "Headset Rail"},
>         { "Headset Rail", NULL, "Audio Rail"},

>         /*speaker map*/
>         { "IHFDAC Left", NULL, "PCM_In"},
>         { "IHFDAC Right", NULL, "PCM_In"},
>         { "PCM_In", NULL, "Speaker Rail"},
>         { "Speaker Rail", NULL, "Audio Rail"},

> But when the stream is started now all the widgets get powered on. The debugfs 
> entry says

You have unconditionally connected both speaker and headphone widgets to
the same input so when that input becomes active paths are completed to
both outputs and both outpus are enabled.

These "Rail" widgets look quite unusual - what are they?

> What could I be doing wrong here? I want to add this PCM button for all streams 
> (4 eventually) and this be enabled whenever anyone of them is started.

What is a "PCM button" and what do you mean by starting a "stream"?
Normally a stream would be a path between the CPU and the CODEC.

The way this works is that as described in reply to your previous mail
DAPM powers anything on which has a completed path from input to output.
As mentioned then if you have no routing control in the device the
machine driver will arrange to enable and disable input and output
widgets on the edge of the CODEC, either automatically using jack
detection or by offering SOC_DAPM_PIN_SWITCH() or similar controls to
applications.
