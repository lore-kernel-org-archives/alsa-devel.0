From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [RFC] ASoC: multi-component: Add optional kcontrol
 prefix name for a DAI link
Date: Mon, 30 Aug 2010 14:17:29 +0300
Message-ID: <20100830141729.75388459.jhnikula@gmail.com>
References: <20100816135328.077b5ea3.jhnikula@gmail.com>
	<20100816110902.GA10354@sirena.org.uk>
	<20100819144451.1d827367.jhnikula@gmail.com>
	<20100819135413.GA19582@opensource.wolfsonmicro.com>
	<20100819182049.3ecdd0bc.jhnikula@gmail.com>
	<20100820115144.451b474f.jhnikula@gmail.com>
	<20100823152145.GD14504@rakim.wolfsonmicro.main>
	<20100824102343.4dfaafe1.jhnikula@gmail.com>
	<20100824101032.GA15278@rakim.wolfsonmicro.main>
	<20100825135922.5589ba30.jhnikula@gmail.com>
	<20100826133229.GA3803@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 5A73C103856
	for <alsa-devel@alsa-project.org>;
	Mon, 30 Aug 2010 13:16:25 +0200 (CEST)
Received: by eyd9 with SMTP id 9so3044382eyd.38
	for <alsa-devel@alsa-project.org>; Mon, 30 Aug 2010 04:16:25 -0700 (PDT)
In-Reply-To: <20100826133229.GA3803@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, 26 Aug 2010 14:32:29 +0100
Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> On Wed, Aug 25, 2010 at 01:59:22PM +0300, Jarkko Nikula wrote:
> 
> > I went back to original idea that prefixes only kcontrols of codec and
> > doesn't add any new API. So if we can have DAIless codec drivers (i.e.
> > amplifiers) then there is no immediate need for prefixing widgets and
> > routes.
> 
> Note that even DAIless drivers can have routing in them - see WM9090 for
> example.
> 
I don't see it are there any problems. For me it looks the routes in
WM9090 are unique and registered to own codec instance so there should
not be route prefixing needed.

How these amplifier drivers are actually meant to be probed? Currently
struct snd_soc_codec_driver->probe is called only from
soc_probe_dai_link.


-- 
Jarkko
