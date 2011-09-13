From: Arun Raghavan <arun.raghavan@collabora.co.uk>
Subject: Re: [PATCH 0/3] Fallback mechanism for pulse plugin
Date: Tue, 13 Sep 2011 22:39:52 +0530
Message-ID: <1315933800.7511.53.camel@snowflake>
References: <s5hk4b5w7aq.wl%tiwai@suse.de> <4E624761.5000305@colin.guthr.ie>
	<s5hipoy89ss.wl%tiwai@suse.de> <4E6DC6DB.7080204@colin.guthr.ie>
	<s5hbouq868a.wl%tiwai@suse.de> <4E6E51FF.9070508@colin.guthr.ie>
	<s5hty8gvpuz.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [93.93.128.226])
	by alsa0.perex.cz (Postfix) with ESMTP id E2CA8103811
	for <alsa-devel@alsa-project.org>;
	Tue, 13 Sep 2011 19:09:13 +0200 (CEST)
In-Reply-To: <s5hty8gvpuz.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Colin Guthrie <gmane@colin.guthr.ie>
List-Id: alsa-devel@alsa-project.org

On Tue, 2011-09-13 at 09:55 +0200, Takashi Iwai wrote:
> > So the problem I have is thus:
> > 
> >  1. If the user wants to use PA and it's configure in the system
> that
> > way, then ALSA (or any other PA client) will autospawn PA if it's
> not
> > running. If that doesn't work, I would prefer that no ALSA-only
> fallback
> > happens as it masks where the real problem lies.
> 
> Right.  In this case, PA should have been started beforehand.  But,
> the start-up is always racy, so it might happen that ALSA-pulse app is
> kicked off before PA daemon gets started.  This is one possible
> problem.
> 
> Another possible problem is when PA daemon crashes by some reason and
> ALSA-pulse app is started just after it.

I don't think this is a case that we should plan or design for. It's an
outlier, and pretending to work seamlessly when the underlying system
breaks is just going to make it harder to fix problems.

Extending this as a general comment -- I think it's bad to try to
fallback to ALSA in any case if PulseAudio isn't functioning properly.
We got to the currently decent shape we're in by refusing to take that
route and IMO we should continue doing so until there's nothing left to
fix. :)

> >  2. If a given user does not want to use PA, but the system is
> > configured to run PA, then that user will typically have a PA daemon
> > started anyway via XDG autostart, unless they have specifically
> chosen
> > via their DE to override this startup option. In this scenario, PA
> is
> > running already and the automatic fallback stuff in the alsa-plugin
> > won't work as intended.
> 
> XDG isn't used in every environment.  Many window managers won't use
> it.  So, there are two cases: 2a) PA starts up via XDG but user
> doesn't want to use.  2b) PA doesn't start up and user doesn't want to
> use PA.
> 
> >  3. If the system is not configured for PA but a given user does
> want to
> > use it, then the system will not run PA at login (due to hacks on
> the
> > XDG startup scripts and by setting autospawn=no in the
> > /etc/pulse/client.conf file), and thus the user will have to find a
> way
> > to start pulseaudio themselves (e.g. by copying the client.conf to
> their
> > own directory and setting autospawn=yes).
> 
> Right. 

So, summarising the thread so far, we should standardise how PA is
disabled in config (daemon.conf option to add "enabled = no" sounds good
to me) and have clients call some libpulse API to check whether PA is
enabled or not. The alsa pulse plugin should fallback *only* if PA has
specifically been disabled (not if PA failed to start up for some reason
-- that's a bug we need to resolve). This will give per-user control
over PA being enabled/disabled which was the original use-case.

I've summarised this in the hope that we can convert the thread into "we
need to do this in alsa-* and this in pulse*" and then get it done. It's
a long thread, and some of the corner cases are subtle, so feel free to
point out if something isn't clear or not covered.

Regards,
Arun
