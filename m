From: John Frankish <john.frankish@outlook.com>
Subject: Re: No sound from speakers with Realtek ALC3226
Date: Wed, 25 Feb 2015 13:25:35 +0400
Message-ID: <COL403-EAS2576E554CAD96126742849BF3170@phx.gbl>
References: <COL403-EAS144CB85A708197E0DF2965FF3160@phx.gbl>
 <s5h61are4m2.wl-tiwai@suse.de>
 <COL403-EAS2907AF9B8908D92F837F8E5F3170@phx.gbl>
 <s5h4mqa5p3c.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from COL004-OMC3S6.hotmail.com (col004-omc3s6.hotmail.com
 [65.55.34.144]) by alsa0.perex.cz (Postfix) with ESMTP id 8AD602605D1
 for <alsa-devel@alsa-project.org>; Wed, 25 Feb 2015 10:25:43 +0100 (CET)
In-Reply-To: <s5h4mqa5p3c.wl-tiwai@suse.de>
Content-Language: en-us
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: 'Takashi Iwai' <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

> > > > 
> > > > I posted this on the alsa-user list, but did not get a reply.
> > > > 
> > > > Although it occasionally works, I am usually unable to get any 
> > > > sound out of the speakers on a dell latitude e7240 using 
> > > > alsa-1.0.28 and
> > > > linux-3.16.6 - see details at the end of the post.
> > >
> > > If so, Windows or BIOS is the problem.  It doesn't set up the pin
configuration properly Linux driver relies on.
> > >
> > I just updated the bios to the latest version, but no change :(
> > >
> > > If you get the status where the speaker works (e.g. after Windows
clean
> > reboot), try to take alsa-info.sh snapshot.  Run alsa-> info.sh with 
> > --no-upload option, and save the generated output.  Then, take another 
> > alsa-info.sh snapshot while the speaker > doesn't work.  Compare these 
> > two outputs.  (At best, attach both (compressed) files.)
> > >
> > Alsa_info_works and alsa_info_no_works attached - diff didn't show an 
> > obvious difference between getting sound from the speakers and not 
> > getting sound from the speakers.
>
> OK, then this is not about the pin configuration, but likely the EAPD
setup BIOS does.
>
> Did you try the newer kernels?  There has been a fix for EAPD control, and
this might already fix your problem.

I'd rather patch my current kernel if possible - do you know where the EPAD
control patch is by any chance?
