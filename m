From: Mark Knecht <markknecht@attbi.com>
Subject: Re: possible problems with rc6 aplay
Date: 16 Dec 2002 04:04:23 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1040040264.1358.8.camel@Godzilla>
References: <E18NleD-0004xk-00@sc8-sf-list1.sourceforge.net>
	<1040013536.2187.4.camel@Godzilla>  <20021216101721.GM773@tuba.home>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20021216101721.GM773@tuba.home>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: martin-langer@gmx.de
Cc: paul@linuxaudiosystems.com, Alsa-Devel <alsa-devel@lists.sourceforge.net>, swpatrick@earthlink.net
List-Id: alsa-devel@alsa-project.org

Martin,
   That might certainly be an answer. How would this amixer switch get
st in the first place? I wouldn't mind doing it by hand once as long as
it was then loaded after that.

   I'm having an interesting problem with this setup with now that's
probably based in this area. If I bring up these two systems with the
main DAW in Linux, and the slave system in Windows everything is fine.
The DAW controls the frequency via my running jack, but even at first
boot the two sides lock together just fine. 

   If I then boot the DAW into Windows, the two sides start making noise
through the speakers, and if I look at the RME app in Windows on the
slave machine, the frequency is bouncing around and so is the mode
saying it's master or slave. The worst part is I get ugly noise out of
my speakers unless I tell one f the two Windows machines what mode to be
in.

   Is sort of makes sense...

   Going back into Linux solves the noise problem.

Mark


On Mon, 2002-12-16 at 02:17, Martin Langer wrote:
> On Sun, Dec 15, 2002 at 08:38:54PM -0800, Mark Knecht wrote:
> > Paul,
> >    I'm using two Hammerfalls in separate boxes. Please try to come up
> > with a solution, either automatically or by asking questions in some
> > configuration process, that allows two Linux boxes to choose which to
> > make the master. It is important in my case.
> > 
> 
> What about the amixer switch? You can use it for switching between master,
> world, ... modes, but I have only small personal experiences with external
> hardware using rme32.
> 
> Another problem I see is the frequency of your master mode. In my opinion
> you can't set your card to master mode without defining it's frequency
> before. On rme32 I have three master three modes (32/44.1/48 kHz). If you
> have a freshly loaded driver and switch to master mode at first it's output
> frquency is totally undefined. But if you play at first some audio stuff
> with your rme32 it's no problem and the card uses this last frequency.
> 
> But using master clock mode without defining a frequency before isn't
> plausible for me and defining one master mode for each frequency was only a
> quick solution by me.
> 
> Any comments or better solutions?
> 
> martin
> 
> 
> > Thanks,
> > Mark
> > 
> > On Sun, 2002-12-15 at 19:13, Paul Davis wrote:
> > > >Latency: 4096 samples (2 periods of 16384 bytes)
> > > >Hardware pointer (frames): 0
> > > >Passthru: no
> > > >Clock mode: autosync
> > > >Pref. sync source: ADAT1
> > > >
> > > >IEC958 input: Coaxial
> > > >IEC958 output: Coaxial only
> > > >IEC958 quality: Consumer
> > > >IEC958 emphasis: off
> > > >IEC958 Dolby: off
> > > >IEC958 sample rate: error flag set
> > > >
> > > >ADAT Sample rate: 44100Hz
> > > 
> > > if you're hammerfall is configured as shown above (and no, the name
> > > change makes no difference), then the SR that it uses will be
> > > determined by your external converter connected to the first ADAT
> > > port. nothing that ALSA does (or any program using ALSA does) will
> > > alter the SR. thats because you are synced to ADAT1, not the card's
> > > internal clock, thus the SR is determined by the clock signal arriving
> > > at ADAT1, which presumably comes from a converter somewhere back up
> > > the ADAT chain.
> > > 
> > > its been on my to-do list for some time to make "master" the default
> > > clock mode on the hammerfall, which avoids any ambiguity about the
> > > sample rate used by the card. i've held back because its really not
> > > the right option for most studio-ish users, who have external
> > > converters that probably have rate switches on them and they expect
> > > the hammerfall to follow the switch setting.
> > > 
> > > does any of this make it any clearer? its really a bit of problem that
> > > the rate setting code doesn't do a full 100% check on all this
> > > stuff. an app can set the rate to 44100, and appear to have succeeded,
> > > but it will have no difference on the actual rate if the sync source
> > > is not the clock's internal clock. this is true, btw, for most digital
> > > cards. if you tried to record at 44100, but your external converters
> > > were running at 48kHz (as you suggest they have been), then the
> > > recordings will be at 48kHz with the sync source set as shown above.
> > > 
> > > --p
> > > 
> > > 
> > > 
> > > 
> > > -------------------------------------------------------
> > > This sf.net email is sponsored by:
> > > With Great Power, Comes Great Responsibility 
> > > Learn to use your power at OSDN's High Performance Computing Channel
> > > http://hpc.devchannel.org/
> > > _______________________________________________
> > > Alsa-devel mailing list
> > > Alsa-devel@lists.sourceforge.net
> > > https://lists.sourceforge.net/lists/listinfo/alsa-devel
> > 
> > 
> > 
> > 
> > -------------------------------------------------------
> > This sf.net email is sponsored by:
> > With Great Power, Comes Great Responsibility 
> > Learn to use your power at OSDN's High Performance Computing Channel
> > http://hpc.devchannel.org/
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/alsa-devel
> > 
> > 
> 
> -- 
> "2b|!2b"




-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
