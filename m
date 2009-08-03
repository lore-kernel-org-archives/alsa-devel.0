From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH - amixer] listen to D-Bus for volume-up,
 volume-down and mute signals.
Date: Mon, 3 Aug 2009 18:02:22 +0100
Message-ID: <20090803170222.GA23621@rakim.wolfsonmicro.main>
References: <1249296201-6930-1-git-send-email-stlman@poczta.fm>
	<s5hocqxcgqb.wl%tiwai@suse.de> <4A76D239.70202@poczta.fm>
	<s5hiqh5ccyr.wl%tiwai@suse.de>
	<20090803121747.GD5959@sirena.org.uk> <4A771774.8040408@poczta.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id DBB8E24154
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Aug 2009 00:26:48 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4A771774.8040408@poczta.fm>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Lukasz Stelmach <stlman@poczta.fm>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 03, 2009 at 06:59:32PM +0200, Lukasz Stelmach wrote:
> Mark Brown pisze:

> > I tend to agree, merging it into amixer seems kind of arbatrary.  Such a
> > daemon (and its dbus interface) may also be useful for handling things
> > like scenario management so I can see it growing over time.

> Scenario management? Could you please say something more what I
> have not been missing for so long ;-)

See http://www.slimlogic.co.uk/?p=40
