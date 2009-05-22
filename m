From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Disabling HFL/R outputs in twl4030
Date: Fri, 22 May 2009 12:26:17 +0100
Message-ID: <20090522112616.GB8542@sirena.org.uk>
References: <2C7D3DF36ADFFC479B44490D912B616705F6AC2661@dlee07.ent.ti.com>
	<200905221248.28656.peter.ujfalusi@nokia.com>
	<20090522103603.GA8542@sirena.org.uk>
	<200905221403.28771.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id DE1EC103907
	for <alsa-devel@alsa-project.org>;
	Fri, 22 May 2009 13:26:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <200905221403.28771.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "ext Lopez Cruz, Misael" <x0052729@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, May 22, 2009 at 02:03:28PM +0300, Peter Ujfalusi wrote:

> So changing the stream names in the twl4030_dai:
> for HiFi:
> .stream_name = "HiFi Playback" and leave the "Capture"
> and for voice:
> .stream_name = "Voice Playback" and leave the "Capture"

> Than changing the DAPM_DACs stream names for the HiFi stream:
> "Right Front HiFi Playback", "Left Front HiFi Playback", "Right Rear HiFi 
> Playback", "Left Rear HiFi Playback"

> Should do the trick?

I'd expect so, yes.
