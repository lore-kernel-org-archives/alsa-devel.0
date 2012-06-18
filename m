From: Tanu Kaskinen <tanuk@iki.fi>
Subject: Re: How to redefine "default" to be equivalent
	to	"sysdefault"?
Date: Mon, 18 Jun 2012 17:37:26 +0300
Message-ID: <1340030246.2892.9.camel@laptop>
References: <1339574254.2909.15.camel@laptop> <s5hbokgn375.wl%tiwai@suse.de>
	<1340029054.2892.5.camel@laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 17D471041D6
	for <alsa-devel@alsa-project.org>;
	Mon, 18 Jun 2012 16:37:34 +0200 (CEST)
In-Reply-To: <1340029054.2892.5.camel@laptop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 2012-06-18 at 17:17 +0300, Tanu Kaskinen wrote:
> On Mon, 2012-06-18 at 15:45 +0200, Takashi Iwai wrote:
> > At Wed, 13 Jun 2012 10:57:34 +0300,
> > Tanu Kaskinen wrote:
> > > 
> > > Hi,
> > > 
> > > I have a file with the following contents:
> > > 
> > > 
> > > 
> > > # This file an alsa configuration file, used by pasuspender to make the
> > > # "default" Alsa device work while PulseAudio is in suspended state.
> > > 
> > > # Include the system configuration first. Is there any easier way to do this?
> > > # 14 lines for including one file is a bit much...
> > > @hooks [
> > >         {
> > >                 func load
> > >                 files [
> > >                         {
> > >                                 @func concat
> > >                                 strings [
> > >                                         { @func datadir }
> > >                                         "/alsa.conf"
> > >                                 ]
> > >                         }
> > >                 ]
> > >         }
> > > ]

As a sidenote, I've now discovered that the cumbersome hooks block can
be replaced simply with

<confdir:alsa.conf>

> > > 
> > > # Redefine "default" to be the same as "sysdefault". On most systems
> > > # "sysdefault" is configured to use dmix.
> > > pcm.!default sysdefault
> > > 
> > > 
> > > 
> > > That doesn't do what I want it to do. When I run
> > > 
> > >     ALSA_CONFIG_PATH=/path/to/file.conf aplay -Ddefault ~/test.wav
> > 
> > Doesn't ALSA_CONFIG_PATH=/path/to/file.conf:/usr/share/alsa/alsa.conf
> > work?
> 
> I didn't know that I can give multiple files, so I haven't tried. One
> minor problem with this approach is that the alsa.conf path would be
> hardcoded, instead of using $(datadir)/alsa.conf.

I tried that now, and it doesn't work any better - "default" still goes
through pulseaudio.

-- 
Tanu
