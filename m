From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: How to set TWL4030 to Option2
Date: Fri, 15 May 2009 10:45:12 +0100
Message-ID: <20090515094512.GB4449@sirena.org.uk>
References: <2C7D3DF36ADFFC479B44490D912B616705F69E7BA4@dlee07.ent.ti.com>
	<4A0D378E.5090004@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 6828810397D
	for <alsa-devel@alsa-project.org>;
	Fri, 15 May 2009 11:45:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4A0D378E.5090004@samsung.com>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, "Lopez Cruz,
	Misael" <x0052729@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, May 15, 2009 at 06:36:14PM +0900, Joonyoung Shim wrote:

> In current code, as you say, you have to directly change the value of
> the reg cache for setting to option2, also you have to modify the
> REG_OPTION and REG_VOICE_IF reg for voice, but this is temporary method.

This can be done with a register write from the DAI init() function in
the machine driver in order to avoid modifying twl4030.c itself.
