From: "Gabriel M. Beddingfield" <gabrbedd@gmail.com>
Subject: Re: Using UCM with PulseAudio
Date: Wed, 20 Jun 2012 21:50:02 -0500
Message-ID: <4FE28BDA.4060707@gmail.com>
References: <1339728813.5228.48.camel@localhost>
	<1339780110.7609.21.camel@odin> <1340195448.8622.7.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 3BB591040A1
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Jun 2012 03:29:13 +0200 (CEST)
Received: by obbeh20 with SMTP id eh20so247604obb.38
	for <alsa-devel@alsa-project.org>; Wed, 20 Jun 2012 19:50:25 -0700 (PDT)
In-Reply-To: <1340195448.8622.7.camel@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Arun Raghavan <arun.raghavan@collabora.co.uk>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, Feng Wei <feng.wei@linaro.org>, Liam Girdwood <lrg@ti.com>, pulseaudio-discuss@lists.freedesktop.org
List-Id: alsa-devel@alsa-project.org

On 06/20/2012 07:30 AM, Arun Raghavan wrote:
>> UCM provides the "modifier" to allow ad-hoc modifications to the audio
>> use case like above where we want to play an end of call tone. In this
>> case the verb is still VoiceCall, but PA would enable the "PlayTone"
>> modifer to play the tone (UCM can also tell Pulseaudio the sink PCM and
>> volume control for the tone data).
>
> Just as an observation, I think the Android HAL just uses PCM 0 and not
> the PCM 3, but in the PA case, I'll do it the way you describe since
> that makes more sense.

Yes, the Galaxy Nexus pretty much only uses PCM 0 -- but that's mostly a 
reflection of AudioFlinger's design and limitations.

-gabriel
