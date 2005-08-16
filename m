From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: proper suspend / resume for PCM streams
Date: Tue, 16 Aug 2005 13:18:15 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0508161315320.9566@tm8103.perex-int.cz>
References: <Pine.LNX.4.61.0508152139420.9682@tm8103.perex-int.cz>
 <s5h8xz2xiiz.wl%tiwai@suse.de> <Pine.LNX.4.61.0508161254410.9566@tm8103.perex-int.cz>
 <s5h64u6xhpc.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7144F1F3
	for <alsa-devel@alsa-project.org>; Tue, 16 Aug 2005 13:18:16 +0200 (MEST)
In-Reply-To: <s5h64u6xhpc.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 16 Aug 2005, Takashi Iwai wrote:

> At Tue, 16 Aug 2005 12:57:32 +0200 (CEST),
> Jaroslav wrote:
> > 
> > On Tue, 16 Aug 2005, Takashi Iwai wrote:
> > 
> > > > 	For the first glance: cs4281.c and es1968.c drivers are restoring 
> > > > the registers, so it appears that the full resume should work for them.
> > > 
> > > Do we need another flag, then?  Currently, alsa-lib doesn't handle the
> > > cases with a half-way suspend/resume support as most of drivers
> > > provide.
> > 
> > I don't understand the requirement for the new flag. Could you explain?
> 
> There are drivers which don't support PM at all (the ones without
> suspend/resume callback).  But some do support PM but just lack
> prepare().  Trying resume for the former could be harmfull.

Yes, but they don't have set the INFO_RESUME flag, thus the midlevel
returns an error code for the resule ioctl...

> > > Nevertheless, the current way of snd_pcm_resume() is quite
> > > user-unfriendly.  snd_pcm_prepare() and other complex procedure must
> > > be handled inside snd_pcm_resume(), instead of forcing each app to do
> > > it.
> > > 
> > > Also we can provide a standard PCM error handling routine to do the
> > > standard job like XRUN and PM recovery, too.
> > 
> > Well, I'm not against a helper function for really simple apps, but there 
> > is drastic difference between resume and restart of the PCM stream 
> > (buffering), so the enhanced applications must have a way to know about 
> > these events.
> 
> I've never seen such apps, so far :)

And it's really bad... They should care.

> See the current situation.  Now we have only two worlds:
> - Players/recorders using ALSA API or another layer like gstreamer
> - RT-apps using JACK
> 
> The suspend/resume is anyway out of question for JACK.
> OTOH, the former case prefers a simple way of error handling.
> All higher layer libraries do the same job as a standard error
> handling, too.
> 
> If the simple error handling really matters, we can provide another
> function to turn this feature off.

It's not about error handling, it's about PCM state handling.
As I said, we may add some helper functions to handle these states in some 
default way (like aplay does) and rest of applications will do the state 
handling itself.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
