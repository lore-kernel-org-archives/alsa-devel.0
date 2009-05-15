From: "Lopez Cruz, Misael" <x0052729@ti.com>
Subject: Re: How to set TWL4030 to Option2
Date: Fri, 15 May 2009 05:05:28 -0500
Message-ID: <2C7D3DF36ADFFC479B44490D912B616705F69E7BAA@dlee07.ent.ti.com>
References: <2C7D3DF36ADFFC479B44490D912B616705F69E7BA4@dlee07.ent.ti.com>
	<4A0D378E.5090004@samsung.com> <20090515094512.GB4449@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 5BC8224334
	for <alsa-devel@alsa-project.org>;
	Fri, 15 May 2009 12:05:39 +0200 (CEST)
In-Reply-To: <20090515094512.GB4449@sirena.org.uk>
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
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Joonyoung Shim <jy0922.shim@samsung.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Peter@alsa-project.org, Ujfalusi <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

> > In current code, as you say, you have to directly change 
> > the value of the reg cache for setting to option2, also
> > you have to modify the REG_OPTION and REG_VOICE_IF reg for
> > voice, but this is temporary method.

> This can be done with a register write from the DAI init()
> function in the machine driver in order to avoid modifying
> twl4030.c itself.

For audio and voice interface, following things need to be configured:

Audio interface:
- Output pins state: high impendance or application mode
- Enable audio interface

Voice interface:
- Enable voice data input
- Enable voice data output
- Output pins state: high impedance or application mode
- Enable voice interface

I think that interfaces can be enabled in DAI init as Mark suggests,
but input/output should be enabled depending on whether we are doing
playback/capture or not, and then they should be handled in the codec
driver.

For the codec operation mode selection, I still think Peter's
advice is more appropriate because options1,2 are not really tight to
DAIs. For example, we can be in option2 (voice/audio) and do
transferences using both DAIs: I2S and PCM.
