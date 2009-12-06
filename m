From: Alexey Fisher <bug-track@fisher-privat.net>
Subject: Re: line-in on Intel DG45ID
Date: Sun, 06 Dec 2009 11:01:14 +0100
Message-ID: <1260093674.3229.14.camel@zwerg>
References: <1259568400.4835.25.camel@zwerg> <s5hhbsazqgt.wl%tiwai@suse.de>
	<1259682335.3397.9.camel@zwerg> <s5h638qzobx.wl%tiwai@suse.de>
	<1259749850.3195.22.camel@mini> <1260051299.3187.39.camel@zwerg>
	<68720af30912051947t72c307fcm621fae436baa6850@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 3BB351037FC
	for <alsa-devel@alsa-project.org>; Sun,  6 Dec 2009 11:01:16 +0100 (CET)
In-Reply-To: <68720af30912051947t72c307fcm621fae436baa6850@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Paulo Cavalcanti <promac@gmail.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Am Sonntag, den 06.12.2009, 01:47 -0200 schrieb Paulo Cavalcanti:
> On Sat, Dec 5, 2009 at 8:14 PM, Alexey Fisher
> <bug-track@fisher-privat.net>wrote:
> 
> > Am Mittwoch, den 02.12.2009, 11:30 +0100 schrieb Alexey Fisher:
> > > Am Dienstag, den 01.12.2009, 16:49 +0100 schrieb Takashi Iwai:
> > > > At Tue, 01 Dec 2009 16:45:35 +0100,
> > > > Alexey Fisher wrote:
> > > > >
> > > > > Am Dienstag, den 01.12.2009, 16:03 +0100 schrieb Takashi Iwai:
> > > > > > At Mon, 30 Nov 2009 09:06:40 +0100,
> > > > > > Alexey Fisher wrote:
> > > > > > >
> > > > > > > Hi,
> > > > > > > i recently tried to digitalise some tapes and found line-in not
> > enabled
> > > > > > > on my board (Intel DG45ID). (Codec: IDT 92HD73E1X5)
> > > > > > > >From the board documentation i know  blue jack used for line-in
> > or side
> > > > > > > surround. Even i use normal stereo i can't enable line-in.
> > > > > > >
> > > > > > > So my question, is it really to make a switch between surround
> > and
> > > > > > > stereo with line-in? I know it should be possible. Or to have
> > this
> > > > > > > switch for mic input?
> > > > > >
> > > > > > Which ALSA driver version are you using?
> > > > > >
> > > > > > The very latest one should have a "Line Jack Mode", with which you
> > > > > > can change the input/output via enum control.
> > > > >
> > > > > i use recent alsa-kernel.git, i found this switch.
> > > >
> > > > Check sound GIT tree, to be sure:
> > > >   git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound-2.6.git
> > > >
> > > > A snapshot tarball for external builds is:
> > > >
> > ftp://ftp.kernel.org/pub/linux/kernel/people/tiwai/snapshot/alsa-driver-snapshot.tar.gz
> > > >
> > > > > Currently i trying to
> > > > > dig deeper in the code. Seems like this board is not really
> > supported...
> > > > > for normal tasks like stereo in / stereo out - is ok, but surround
> > seems
> > > > > to be messed up, mixer map too.
> > > > > For example: "speaker-test -c 6" will produce "Front L/R" on all
> > jacks.
> > > >
> > > > You have to pass -Dsurround51, too.
> > >
> > > Tank you for the tip, speaker-test worked for my Hercules so i thout
> > > should work for intel too. So with tiwai.git and -Dsurround51 or
> > > surrounf71 outputs are working. Bad the mixer map is in really bad
> > > state. Here is my current investigation, here are the controls i tested:
> > >
> > > [jack]  [surround]; [mixers;...]
> > > green - front r/l;Master; PCM; Speeker 0;
> > > blue - side r/l ------- PCM; Speaker 3;
> > > black - rear r/l; Master; PCM; Speaker 1;
> > > orange - cenrat f/r; Master; PCM; ------; swap;
> > > ('Swap Center/LFE Playback Switch' (change front and reare outputs))
> >
> > I need help,
> >
> > one and half problem solved:
> > hp_out and mic_in didn't worked on front panel,
> > mic was silent, and hp did only high frequency noise (sound like
> > something wrong).
> > Now front and rear mic working. hp don't do the noise any more but i
> > still can't get any output from it.
> > Mixer is working now too, so i can use three inputs together, but it
> > seems not supported by driver, so i force selection with:
> > hda-verb /dev/snd/hwC0D2 0x20 SET_CONNECT_SEL 0x0b
> >
> > I used .ini file from windows to set it up, see attachment. There is
> > cadec dump before and after tweaks, and patch.
> >
> >
> >
> http://mailman.alsa-project.org/pipermail/alsa-devel/2009-February/014825.html
> 

Thank you,
now it is working, currently only SPDIF not checked.
i do not wont to touch blue jack, there is ready two mic inputs and you
can switch on each of them between mic and line-in. If i'll make blue
jack - line in, it will reduce surround 7.1 to 5.1. Probably not all
will be happy about this.
