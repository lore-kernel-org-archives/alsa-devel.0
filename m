From: John covici <covici@ccs.covici.com>
Subject: Re: controls for the ice1712
Date: Mon, 8 Jul 2002 11:03:38 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <15657.43466.645747.163894@ccs.covici.com>
References: <15655.22587.420039.270085@ccs.covici.com>
	<Pine.LNX.4.44.0207081526230.21289-100000@pc40.e18.physik.tu-muenchen.de>
Reply-To: covici@ccs.covici.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0207081526230.21289-100000@pc40.e18.physik.tu-muenchen.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Roland Kuhn <rkuhn@e18.physik.tu-muenchen.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

OK, you have been of great help -- just one more question -- or
rather two, I cannot find a control for the pcm out, although other
things are set up which say value 'PCM OUT' I cannot find a control
labelled 'PCM OUT' to either capture or do anything about.  Also what
are h/w in 0 through 7 and what are the multi capture switches and
volumes 1 through 9.  I think I am slowly getting to understand this,
but it is a bit confusing.

Thank you for all your help.

on Monday 07/08/2002 Roland Kuhn(rkuhn@e18.physik.tu-muenchen.de) wrote
 > On Sat, 6 Jul 2002, John covici wrote:
 > 
 > > I found some controls "iec958 Playback Default" which can be changed
 > > but its a number of probably hex digits whose meaning I don't know.
 > > There is an Iec958 Playback Stream which says inactive in its comment
 > > should I ignore that one?
 > > I found Iec958 Master as a boolean so I can turn that on for playback.
 > > I found something called "H/w Playback Route" which has many possible
 > > values -- the only ones to do with iec958 say iec958 In L and R -- is
 > > that how you play through the sp/diff out  by setting the hw playback
 > > route to this value?  And should I use l or r for stereo programs?
 > > And there is another control of the same name but an index 1  what is
 > > this?
 > > 
 > The "H/W Playback Route" defines which input will be routed to the analog 
 > output. I usually put it to "Digital Mixer" to be able to set the volumes 
 > with the alsamixer. It you set it e.g. to PCM or SP/DIF, the respective 
 > input signal is passed directly to the DAC, meaning you cannot change 
 > anything about it.
 > 
 > > I also have two iec958 playbback routes with one of them having
 > > index 1.
 > > 
 > These are the settings you looked for: The one with index=1 is the right 
 > channel, the other the left. Set them to whatever source you want to send 
 > to the SP/DIF output: to make a direct copy you can set it to SP/DIF In, 
 > but you can also use PCM or the Digital Mixer to route the computer 
 > generated sounds to your SP/DIF output. The advantage of the Digital Mixer 
 > setting is that you will be able to listen to a CD (from your CD-drive) 
 > while also hearing other sounds (if you set the volumes/mute settings 
 > correctly with alsamixer).
 > 
 > > Many of these controls have 12 enumerations 0 to pcmout and hw
 > > numbers except the last ones which are the iec958 and digital mixer
 > > whatever that is.
 > > 
 > > So you see why I need some help on these -- its hard to tell what all
 > > these do.
 > > 
 > I hope I was able to help a bit...
 > 
 > Ciao,
 > 					Roland
 > 
 > +---------------------------+-------------------------+
 > |    TU Muenchen            |                         |
 > |    Physik-Department E18  |  Raum    3558           |
 > |    James-Franck-Str.      |  Telefon 089/289-12592  |
 > |    85747 Garching         |                         |
 > +---------------------------+-------------------------+

-- 
         John Covici
         covici@ccs.covici.com


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Oh, it's good to be a geek.
http://thinkgeek.com/sf
