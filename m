From: Thomas Preston <thomas.preston@codethink.co.uk>
Subject: Re: [alsa-devel] [PATCH v2 3/3] ASoC: TDA7802: Add turn-on diagnostic
 routine
Date: Tue, 30 Jul 2019 17:28:11 +0100
Message-ID: <9b47a360-3b62-b968-b8d5-8639dc4b468d@codethink.co.uk>
References: <20190730120937.16271-1-thomas.preston@codethink.co.uk>
 <20190730120937.16271-4-thomas.preston@codethink.co.uk>
 <20190730141935.GF4264@sirena.org.uk>
 <45156592-a90f-b4f8-4d30-9631c03f1280@codethink.co.uk>
 <20190730155027.GJ4264@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190730155027.GJ4264@sirena.org.uk>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.cirrus.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Kirill Marinushkin <kmarinushkin@birdec.tech>, Liam Girdwood <lgirdwood@gmail.com>, Marco Felsch <m.felsch@pengutronix.de>, Annaliese McDermond <nh6z@nh6z.net>, Takashi Iwai <tiwai@suse.com>, Paul Cercueil <paul@crapouillou.net>, Vinod Koul <vkoul@kernel.org>, Rob Herring <robh+dt@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Jerome Brunet <jbrunet@baylibre.com>, linux-kernel@vger.kernel.org, Cheng-Yi Chiang <cychiang@chromium.org>
List-Id: alsa-devel@alsa-project.org

On 30/07/2019 16:50, Mark Brown wrote:
> On Tue, Jul 30, 2019 at 04:25:56PM +0100, Thomas Preston wrote:
>> On 30/07/2019 15:19, Mark Brown wrote:
> 
>>> It is unclear what this mutex usefully protects, it only gets taken when
>>> writing to the debugfs file to trigger this diagnostic mode but doesn't
>>> do anything to control interactions with any other code path in the
>>> driver.
> 
>> If another process reads the debugfs node "diagnostic" while the turn-on 
>> diagnostic mode is running, this mutex prevents the second process
>> restarting the diagnostics.
> 
>> This is redundant if debugfs reads are atomic, but I don't think they are.
> 
> Like I say it's not just debugfs though, there's the standard driver
> interface too.
> 

Ah right, I understand. So if we run the turn-on diagnostics routine, there's
nothing stopping anyone from interacting with the device in other ways.

I guess there's no way to share that mutex with ALSA? In that case, it doesn't
matter if this mutex is there or not - this feature is incompatible. How
compatible do debugfs interfaces have to be? I was under the impression anything
goes. I would argue that the debugfs is better off for having the mutex so
that no one re-reads "diagnostic" within the 5s poll timeout.

Alternatively, this diagnostic feature could be handled with an external-handler
kcontrol SOC_SINGLE_EXT? I'm not sure if this is an atomic interface either.

What would be acceptable?
