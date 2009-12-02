From: Alexey Fisher <bug-track@fisher-privat.net>
Subject: Re: line-in on Intel DG45ID
Date: Wed, 02 Dec 2009 11:30:50 +0100
Message-ID: <1259749850.3195.22.camel@mini>
References: <1259568400.4835.25.camel@zwerg> <s5hhbsazqgt.wl%tiwai@suse.de>
	<1259682335.3397.9.camel@zwerg>  <s5h638qzobx.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 5772E244D4
	for <alsa-devel@alsa-project.org>; Wed,  2 Dec 2009 11:30:55 +0100 (CET)
In-Reply-To: <s5h638qzobx.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Am Dienstag, den 01.12.2009, 16:49 +0100 schrieb Takashi Iwai:
> At Tue, 01 Dec 2009 16:45:35 +0100,
> Alexey Fisher wrote:
> > 
> > Am Dienstag, den 01.12.2009, 16:03 +0100 schrieb Takashi Iwai:
> > > At Mon, 30 Nov 2009 09:06:40 +0100,
> > > Alexey Fisher wrote:
> > > > 
> > > > Hi,
> > > > i recently tried to digitalise some tapes and found line-in not enabled
> > > > on my board (Intel DG45ID). (Codec: IDT 92HD73E1X5)
> > > > >From the board documentation i know  blue jack used for line-in or side
> > > > surround. Even i use normal stereo i can't enable line-in.
> > > > 
> > > > So my question, is it really to make a switch between surround and
> > > > stereo with line-in? I know it should be possible. Or to have this
> > > > switch for mic input?
> > > 
> > > Which ALSA driver version are you using?
> > > 
> > > The very latest one should have a "Line Jack Mode", with which you
> > > can change the input/output via enum control.
> > 
> > i use recent alsa-kernel.git, i found this switch.
> 
> Check sound GIT tree, to be sure:
>   git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git
> 
> A snapshot tarball for external builds is:
>   ftp://ftp.kernel.org/pub/linux/kernel/people/tiwai/snapshot/alsa-driver-snapshot.tar.gz
> 
> > Currently i trying to
> > dig deeper in the code. Seems like this board is not really supported...
> > for normal tasks like stereo in / stereo out - is ok, but surround seems
> > to be messed up, mixer map too.
> > For example: "speaker-test -c 6" will produce "Front L/R" on all jacks.
> 
> You have to pass -Dsurround51, too.

Tank you for the tip, speaker-test worked for my Hercules so i thout
should work for intel too. So with tiwai.git and -Dsurround51 or
surrounf71 outputs are working. Bad the mixer map is in really bad
state. Here is my current investigation, here are the controls i tested:

[jack]  [surround]; [mixers;...]
green - front r/l;Master; PCM; Speeker 0;
blue - side r/l ------- PCM; Speaker 3;
black - rear r/l; Master; PCM; Speaker 1;
orange - cenrat f/r; Master; PCM; ------; swap;
('Swap Center/LFE Playback Switch' (change front and reare outputs))

You can see - master control not all jacks and most (not all) jacks have
own mixer.

'Master Playback Switch' <- master but not for all (blue jack not
contr)	
'Master Playback Volume' <- master but not for all (blue jack not contr)
'PCM Playback Volume' <- bad sound if too lo
'Center Playback Switch' <- not working?
'Center Playback Volume' <- not working?
'LFE Playback Switch' <- not working?
'LFE Playback Volume' <- not working ?
'Speaker Playback Switch' <- Front Playback			
'Speaker Playback Switch',inx=1	<- Rear Playback
'Speaker Playback Switch',inx=3	<- Side Playback
'Speaker Playback Volume' <- Front Playback
'Speaker Playback Volume',inx=1	<- Rear Playback
'Speaker Playback Volume',inx=3	<- Side Playback
'Swap Center/LFE Playback Switch'<- order switch ?or route?


I will continue to investigate this board.
