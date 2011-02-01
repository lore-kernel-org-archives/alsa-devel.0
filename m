From: Stephen Warren <swarren@nvidia.com>
Subject: Re: snd_soc_jack_add_gpios vs. SOC_DAPM_PIN_SWITCH
Date: Tue, 1 Feb 2011 10:59:00 -0800
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF0310C8E48A@HQMAIL01.nvidia.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF0310C8E333@HQMAIL01.nvidia.com>
	<20110201113351.GB12743@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from hqemgate04.nvidia.com (hqemgate04.nvidia.com [216.228.121.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 7801724628
	for <alsa-devel@alsa-project.org>; Tue,  1 Feb 2011 19:59:07 +0100 (CET)
In-Reply-To: <20110201113351.GB12743@opensource.wolfsonmicro.com>
Content-Language: en-US
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Mark Brown wrote at Tuesday, February 01, 2011 4:34 AM:
> On Mon, Jan 31, 2011 at 04:03:58PM -0800, Stephen Warren wrote:
> 
> > However, if I use the control to disable the headphones, then
> > unplug/replug the headphones, the jack detect seems to override
> > the control, and I hear audio from the headphones.
> 
> Using these two together makes no sense.  Either you manually control
> the state of the output or you manage it automatically.

I was thinking that the jack detect would be used to enable/disable widgets
for power purposes, but with a manual override to allow SW to set up use
cases where only the internal speakers were used, and never headphones.

That said, if that isn't something that's ever typically done, I'm fine
not supporting that.

> Generally a PIN_SWITCH() should only be used to offer control if none is
> availabile within the CODEC - in the case of Harmony it wouldn't make
> much sense as there's plenty of control in the CODEC for what gets
> routed to the various outputs.

IIRC, the codec controls allow selecting only what gets routed, but there
wasn't an overall "enable/disable speakers" switch (the mute switch does
not disable the DAPM widgets). One would have to disable all the routing
options to disable the speaker amplifiers, which would entail remembering
what those routing options were to restore them once the speakers were
desired again. A manual switch avoids this.

-- 
nvpublic
