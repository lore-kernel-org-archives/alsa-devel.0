From: Stefan Schmidt <stefan@datenfreihafen.org>
Subject: Re: [RFC] Add scenario management
Date: Fri, 2 Oct 2009 11:55:16 +0200
Message-ID: <20091002095516.GA8432@dodger.lab.datenfreihafen.org>
References: <1254390436-5283-1-git-send-email-stefan@datenfreihafen.org>
	<s5hws3egnwc.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sirius.lasnet.de (sirius.lasnet.de [78.47.116.19])
	by alsa0.perex.cz (Postfix) with ESMTP id 394AB103969
	for <alsa-devel@alsa-project.org>;
	Fri,  2 Oct 2009 11:55:37 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hws3egnwc.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Stefan Schmidt <stefan@datenfreihafen.org>
List-Id: alsa-devel@alsa-project.org

Hello.

On Fri, 2009-10-02 at 11:12, Takashi Iwai wrote:
> At Thu,  1 Oct 2009 11:47:14 +0200,
> Stefan Schmidt wrote:
> > 
> > This patchset add support for scenario management, aka use cases, in alsa-lib
> > and example programs in alsa-utils. It allows to adjust the current audio kcontrol
> > settings from a prespective of a changed use case like the switch from listening
> > to music on your phone to an incoming phone call and back.
> 
> Great, I've been waiting for this :)

:)

> > To achieve this it offers control aliasing for playback, capture master and
> > switch as well as the option to post- and prefix a sequence of control changes
> > avoiding pops and other unwanted noise.
> > 
> > This is of course not meant to replace gstreamer, PulseAudio or a sound server,
> > but is meant to work in tandem with such audio software. We think alsa-lib is
> > the best place for this as it will be used on small embedded system which only
> > use alsa from the full stack of audio libs in linux. We see potential for
> > desktop usage as well though.
> 
> Agreed.  If any need, I can merge it to salsa-lib, too.

Do you prefer doing that yourself or should I sent you another patch for salsa?
We definetly want it there, too. I already downloaded the last salsa release but
was waiting if everyone is happy with the updated patch I sent yesterday.

regards
Stefan Schmidt
