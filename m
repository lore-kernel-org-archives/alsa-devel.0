From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: snd_soc_jack_add_gpios vs. SOC_DAPM_PIN_SWITCH
Date: Tue, 1 Feb 2011 11:33:51 +0000
Message-ID: <20110201113351.GB12743@opensource.wolfsonmicro.com>
References: <74CDBE0F657A3D45AFBB94109FB122FF0310C8E333@HQMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 731D02446F
	for <alsa-devel@alsa-project.org>; Tue,  1 Feb 2011 12:33:54 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <74CDBE0F657A3D45AFBB94109FB122FF0310C8E333@HQMAIL01.nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Stephen Warren <swarren@nvidia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 31, 2011 at 04:03:58PM -0800, Stephen Warren wrote:

> However, if I use the control to disable the headphones, then unplug/replug
> the headphones, the jack detect seems to override the control, and I hear
> audio from the headphones.

> Is this something that's known not yet implemented or was never intended to
> be used this way, or should I look further to find the issue?

Using these two together makes no sense.  Either you manually control
the state of the output or you manage it automatically.

Generally a PIN_SWITCH() should only be used to offer control if none is
availabile within the CODEC - in the case of Harmony it wouldn't make
much sense as there's plenty of control in the CODEC for what gets
routed to the various outputs.

> FYI, sound/soc/samsung/smartq_wm8987.c has this same code structure, and I 
> imagine will have the same issue.

Probably.
