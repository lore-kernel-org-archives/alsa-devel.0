From: steve@snewbury.org.uk
Subject: Re: No speaker output with kernel 3.15 and later
Date: Tue, 1 Jul 2014 12:11:50 +0000
Message-ID: <efu8hs.n818kp.1hgeaud-qmf@mail.snewbury.org.uk>
References: <1404050996.31259.2.camel@snewbury.org.uk>
 <s5hr426sqbq.wl%tiwai@suse.de>	<1404215372.2290.0.camel@snewbury.org.uk>
 <s5h61jh8fau.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from know-smtprelay-omc-11.server.virginmedia.net
 (know-smtprelay-omc-11.server.virginmedia.net [80.0.253.75])
 by alsa0.perex.cz (Postfix) with ESMTP id D4436264FDF
 for <alsa-devel@alsa-project.org>; Tue,  1 Jul 2014 14:12:30 +0200 (CEST)
In-Reply-To: <s5h61jh8fau.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



On Tue Jul 01 2014 12:54:49 GMT+0100 (BST), Takashi Iwai wrote:
> At Tue, 01 Jul 2014 12:49:32 +0100,
> Steven Newbury wrote:
> > 
> > On Mon, 2014-06-30 at 11:24 +0200, Takashi Iwai wrote:
> > > At Sun, 29 Jun 2014 15:09:56 +0100,
> > > Steven Newbury wrote:
> > > >  I sent 
> > > > Takashi an email mentioning this regression a month ago, and
> > > >  it's 
> > > > taken me this long to send this email... :-$
> > > >  Since updating to 
> > > > kernel versions >=3.15 I've had no audio from my
> > > >  laptop speakers.  
> > > > Earlier versions worked fine.
> > > >  It's a CLEVO W270EUQ laptop.  The 
> > > > output mixer device is showing up,
> > > >  but no sound comes out at any 
> > > > volume level.
> > > >  As requested I've attached compressed alsa-info.sh 
> > > > output for both the
> > > >  working and non-working cases.
> > > >  I'm perfectly 
> > > > willing to test patches etc.
> > >  
> > > Hm, I see no significant difference between 3.14 and 3.15 alsa-info.sh
> > > outputs, and there's been very little change for VIA codecs between
> > > these versions.  So, in short, I have no idea what went wrong.
> > >  
> > > Could you double-check whether it's really a kernel issue?
> > > That is, switch between 3.14 and 3.15 and confirm the problem happens
> > > only with 3.15.  Also, for testing the sound, try like
> > >  
> > >         % aplay -Dplughw -vv foo.wav
> > > 
> > Checked again.
> > 
> > 3.16-rc2: silence
> > 3.14.3: works fine
> 
> Then I'd suggest to bisect between 3.14 and 3.15.
> 
Will do.
-- 
Sent from my Jolla
