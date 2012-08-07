From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Plumbers: Please split audio topics into separate
	sessions
Date: Tue, 7 Aug 2012 15:06:24 +0100
Message-ID: <20120807140624.GJ16861@opensource.wolfsonmicro.com>
References: <50202500.5060607@canonical.com>
 <20120806222417.GF26698@opensource.wolfsonmicro.com>
 <s5htxwfi6pb.wl%tiwai@suse.de> <5020B8AF.3090003@canonical.com>
 <s5hhasfi3b4.wl%tiwai@suse.de> <5020CD16.6020705@canonical.com>
 <20120807111519.GY16861@opensource.wolfsonmicro.com>
 <5020FB6D.6000503@canonical.com>
 <20120807135735.GG16861@opensource.wolfsonmicro.com>
 <s5hpq72hk8b.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3FFF3265FA4
 for <alsa-devel@alsa-project.org>; Tue,  7 Aug 2012 19:51:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hpq72hk8b.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Aug 07, 2012 at 04:04:04PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > Oh, that's very surprising - my understanding had been that PulseAudio
> > was essentially just ignoring the configuration it got on startup.  Is
> > there any great reason not to subsume the functionality currently done
> > using alsactl?

> Well, you can't know all subtle controls exactly.  For example, what
> PA should do for a control like "Never Turn Off This Capture Switch"?
> It can be included in a card-specific database PA holds, but if it's
> not there (suppose it's a shiny new driver), the safest way is to
> leave it as is.

Yes, I was assuming that this was what it was doing - I just thought
that there was functionality for doing the stuff alsactl is being used
for in PulseAudio.
