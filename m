From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: How to set TWL4030 to Option2
Date: Fri, 15 May 2009 11:35:44 +0100
Message-ID: <20090515103544.GC4449@sirena.org.uk>
References: <2C7D3DF36ADFFC479B44490D912B616705F69E7BA4@dlee07.ent.ti.com>
	<4A0D378E.5090004@samsung.com>
	<20090515094512.GB4449@sirena.org.uk> <4A0D4032.20506@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 9BFB42437E
	for <alsa-devel@alsa-project.org>;
	Fri, 15 May 2009 12:35:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4A0D4032.20506@samsung.com>
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

On Fri, May 15, 2009 at 07:13:06PM +0900, Joonyoung Shim wrote:

> Oh, i see, thanks. But because the startup() function of codec dai is
> called earlier than startup() function of machine, i think that we need
> an control to set option2.

init() is called when the DAI is instantiated, not during playback or
record.
