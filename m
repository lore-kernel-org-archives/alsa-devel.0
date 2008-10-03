From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: ASoC WM8510 Mic PGA problem
Date: Fri, 3 Oct 2008 14:39:37 +0100
Message-ID: <20081003133936.GD26035@sirena.org.uk>
References: <B9D3C48C98930741A166756A50C44A610F17B555@helx1.corp.vaisala.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 6C2D42472D
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Oct 2008 15:39:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <B9D3C48C98930741A166756A50C44A610F17B555@helx1.corp.vaisala.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext-jukka.hynninen@vaisala.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Oct 03, 2008 at 04:20:20PM +0300, ext-jukka.hynninen@vaisala.com wrote:

> I'm facing trouble with programmable mic gain stage and WM8510 ASoC
> driver. 

> First of all, the DAPM control "Mic PGA Switch" seems to be operating
> just the opposite way the codec datasheet suggests. I inverted the
> control with expected result, PGA now almost works.

Yes, that's right - good catch, thanks.  I will post a patch for this
shortly.

> When I start capturing, the "Mic PGA" control is instantly turned off
> again. If I manually enable the control while the capture is running, it
> works just fine.

Could you expand on what you're seeing here - what exactly is the user
visible behaviour you observe?  Are you looking at dapm_widgets in sysfs
or something else?  Looking at the driver code the power management does
need some fixes but I'd like to confirm exactly what you're seeing
before looking at them.

It might help if you were able to provide your machine driver.
