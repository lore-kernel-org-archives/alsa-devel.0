From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC don't apply] ASoC: Add support for optional
 auxiliary dailess codecs
Date: Fri, 26 Nov 2010 13:41:52 +0000
Message-ID: <20101126134151.GF30360@rakim.wolfsonmicro.main>
References: <1290700058-9270-1-git-send-email-jhnikula@gmail.com>
	<20101125213145.GB25162@opensource.wolfsonmicro.com>
	<20101126092524.ea7cf74d.jhnikula@gmail.com>
	<201011261419.42933.peter.ujfalusi@nokia.com>
	<20101126153548.a5a5f3c6.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 62DF8103CDE
	for <alsa-devel@alsa-project.org>; Fri, 26 Nov 2010 14:42:02 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20101126153548.a5a5f3c6.jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel@alsa-project.org, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 26, 2010 at 03:35:48PM +0200, Jarkko Nikula wrote:
> Peter Ujfalusi <peter.ujfalusi@nokia.com> wrote:

> > If DAPM core knows which widget belongs to which component, than I see no real 
> > problem with this method. The DAPM would work just fine. The PCM operatins would 
> > only apply to component with DAI.

> Actually these are already well separated in current ASoC. Like my RFC
> patch didn't not need touch soc-dapm.c at all and efectively other
> changes were around codec probing/removal and by not registering the
> PCM.

That's pretty much where I'm coming from - we already have most of the
infrastructure, we just need to get the devices into the system but once
we do that we should be able to cope with everything already.

> > > If I counted correctly we have currently only three amplifier drivers:
> > > tpa6130a2.c, wm2000.c and wm9090.c so separation doesn't sound worth of
> > > trouble at this point as the core serves well those cases also.

> > One more: max9877, if I recall correctly that was the first amp driver?

> Yeah, true. Looks like wm9090.c doesn't need any conversion after we
> are able to register dailess codecs but those three can be then
> converted to use standard probing mechanism and let them register itself
> own widgets and controls. I.e. machine drivers don't need to call those
> tailored _add_controls functions.

Yup, WM9090 is a DAIless CODEC already as it's using the register cache.
The systems where it's typically deployed have a stub CODEC normally so
this happens to work as-is, it wouldn't work as-is otherwise.
