From: Arun Raghavan <arun.raghavan@collabora.co.uk>
Subject: Re: Using UCM with PulseAudio
Date: Mon, 25 Jun 2012 06:55:21 +0530
Message-ID: <1340587521.5794.0.camel@localhost>
References: <1339728813.5228.48.camel@localhost>
	<1339780110.7609.21.camel@odin> <1340195448.8622.7.camel@localhost>
	<4FE28BDA.4060707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [93.93.135.160])
	by alsa0.perex.cz (Postfix) with ESMTP id ACE2D24574
	for <alsa-devel@alsa-project.org>;
	Mon, 25 Jun 2012 03:25:26 +0200 (CEST)
In-Reply-To: <4FE28BDA.4060707@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Gabriel M. Beddingfield" <gabrbedd@gmail.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, Feng Wei <feng.wei@linaro.org>, Liam Girdwood <lrg@ti.com>, pulseaudio-discuss@lists.freedesktop.org
List-Id: alsa-devel@alsa-project.org

On Wed, 2012-06-20 at 21:50 -0500, Gabriel M. Beddingfield wrote:
> On 06/20/2012 07:30 AM, Arun Raghavan wrote:
> >> UCM provides the "modifier" to allow ad-hoc modifications to the audio
> >> use case like above where we want to play an end of call tone. In this
> >> case the verb is still VoiceCall, but PA would enable the "PlayTone"
> >> modifer to play the tone (UCM can also tell Pulseaudio the sink PCM and
> >> volume control for the tone data).
> >
> > Just as an observation, I think the Android HAL just uses PCM 0 and not
> > the PCM 3, but in the PA case, I'll do it the way you describe since
> > that makes more sense.
> 
> Yes, the Galaxy Nexus pretty much only uses PCM 0 -- but that's mostly a 
> reflection of AudioFlinger's design and limitations.

Ah, that's good to know. :)

-- Arun
