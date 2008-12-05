From: "Jarkko Nikula" <jhnikula@gmail.com>
Subject: Re: [PATCH] tlv320aic3x: control additions and cleanups
Date: Fri, 5 Dec 2008 15:37:52 +0200
Message-ID: <bd7b27490812050537h2b5cec3cge0bc19de90d585f2@mail.gmail.com>
References: <20081204175121.GD21010@buzzloop.caiaq.de>
	<20081204183746.GB6628@sirena.org.uk>
	<20081204184751.GE21010@buzzloop.caiaq.de>
	<bd7b27490812050502o331d4f5dn2c9bbb3c4fd36169@mail.gmail.com>
	<20081205131256.GC10489@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.181])
	by alsa0.perex.cz (Postfix) with ESMTP id C705D244D5
	for <alsa-devel@alsa-project.org>; Fri,  5 Dec 2008 14:37:53 +0100 (CET)
Received: by wa-out-1112.google.com with SMTP id l35so2359629waf.16
	for <alsa-devel@alsa-project.org>; Fri, 05 Dec 2008 05:37:52 -0800 (PST)
In-Reply-To: <20081205131256.GC10489@sirena.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: u.luckas@road.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 5, 2008 at 3:12 PM, Mark Brown <broonie@sirena.org.uk> wrote:

> On Fri, Dec 05, 2008 at 03:02:20PM +0200, Jarkko Nikula wrote:
>
> > I just checked & tested a fix which changes those "xxx DAC Playback
> Switch"
> > to "xxx Playback Switch" are correct. That would also allow to develop
> new
> > "xxx Playback Volume" controls and gain 9 dB more of output level :-)
>
> So does the patch have your ack?
>

I think patch misses control like "HP Left PGA Bypass Playback Volume"?


Jarkko
