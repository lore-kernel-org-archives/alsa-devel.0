From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH 2/2] ASoC: twl4030 - Add VDL path support
Date: Tue, 24 Mar 2009 16:21:22 +0000
Message-ID: <20090324162122.GE5990@sirena.org.uk>
References: <49C8D933.5020303@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 3FDD3103810
	for <alsa-devel@alsa-project.org>; Tue, 24 Mar 2009 17:21:23 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <49C8D933.5020303@samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Joonyoung Shim <jy0922.shim@samsung.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, '?????????' <kyungmin.park@samsung.com>, ????????? <bhmin@samsung.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 24, 2009 at 09:59:31PM +0900, Joonyoung Shim wrote:
> Adds DAPMs for VDL(voice down link) path.
> To support VDL path, we have to change DAPM of outputs(Earpiece,
> PreDrive Left/Right, Headset Left/Right, Carkit Left/Right) from mux to
> mixer, also codec mode from option1 to option2.

In this specific case where there is no DAI interfacing with the voice
DAC you could just not tell DAPM it's a DAC - it doesn't buy anything
since the only thing that DACs do at the minute is stream 

Alternatively, if this is for something like playback of an audio stream
take a look at how the Neo1973 driver represents the audio downlink from
the bluetooth chipset.  A dummy audio interface is provided to user
space which user space can set up as normal through ALSA, just skipping
actually transferring any data.  This is hacky but has the advantage of
keeping the power management.

There's a sample user space application driving this here:

	http://opensource.wolfsonmicro.com/~gg/bluetooth-pcm/bluetooth_pcm.c
