From: Thomas Fjellstrom <tfjellstrom@telusplanet.net>
Subject: Re: final release - Tuesday
Date: Sun, 9 Mar 2003 16:13:38 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200303091613.38425.tfjellstrom@telusplanet.net>
References: <Pine.LNX.4.44.0303101113450.1071-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from priv-edtnes44.telusplanet.net (outbound05.telus.net [199.185.220.224])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id MAA27960
	for <alsa-devel@alsa-project.org>; Mon, 10 Mar 2003 12:12:33 +0100
In-Reply-To: <Pine.LNX.4.44.0303101113450.1071-100000@pnote.perex-int.cz>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On March 10, 2003 03:15 am, Jaroslav Kysela wrote:
> On Sun, 9 Mar 2003, Thomas Fjellstrom wrote:
> > On March 9, 2003 05:13 pm, Jaroslav Kysela wrote:
> > > Hi all,
> > >
> > > 	I have just released the 0.9.0rc8d version of the ALSA driver for
> > > tests. It should fix the trident problems as Paul noticed. If no major
> > > bug is reported until Tuesday, I will release the final packages.
> > >
> > > 					Have fun,
> > > 						Jaroslav
> >
> > Hey,
> >
> > I've brought this up a couple times, and It looked like Takashi was
> > working on it. I added alsa 0.5 and 0.9x rawmidi support to a library
> > called Allegro (alleg.sf.net) but since upgrading to alsa 9x (I also just
> > installed the latest release from alsa-project.org) the midi test app
> > that comes with allegro (and a midi player of mine...) will eventually
> > (in a couple minutes) eat up 100% cpu time. The allegro midi system has
> > no problems with its software synth, in OSS (or so I've heard), Windows,
> > or any of the other platforms it supports.
>
> I cannot find 0.9 code in your CVS tree.

Yes.. Thats becasue I couldn't get the driver to work, so I didn't submit all 
my changes for alsa 0.9. You want me to send you the one driver file? (which 
won't work on its own in the cvs.. I havent worked on the code in a while, 
and even a patch I might generate will probably not apply to cvs. I've made a 
few changes to the configure stuff to automatically detect the alsa version) 
Or anything?

> Note: Don't use the APPEND mode for single-byte writting. This mode is
> indended for full MIDI messages (including running state) otherwhise there
> is no guarantee that another application doesn't break the stream with
> other bytes.
>

Ok. I'll get that fixed.

-- 
Thomas Fjellstrom
tfjellstrom@telusplanet.net
http://strangesoft.net


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
