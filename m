From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [Alsa-user] Re: [linux-audio-dev] E-MU 1212m Linux drivers
Date: Sun, 01 May 2005 19:30:31 -0400
Message-ID: <1114990231.23959.2.camel@mindpipe>
References: <200505010231.19540.beppe.miletto@tiscali.it>
	 <1114908114.5626.3.camel@mindpipe>
	 <200505020124.16569.beppe.miletto@tiscali.it>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200505020124.16569.beppe.miletto@tiscali.it>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Giuseppe Miletto <beppe.miletto@tiscali.it>
Cc: James Courtier-Dutton <James@superbug.co.uk>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 2005-05-02 at 01:24 +0200, Giuseppe Miletto wrote:
> Alle 02:41, domenica 1 maggio 2005, hai scritto:
> > On Sun, 2005-05-01 at 02:31 +0200, Giuseppe Miletto wrote:
> > > I've already bought a EMU-1212 and I've doing very good job with windows
> > > operating system. This has been a forced choice: trying to use EMU-1212
> > > with my suse 9.2 linux system I haven't been able to go over the use of
> > > MIDI port of my EMU-1212.
> > > Since I'm still an entusiastic of linux, I'll be very gratefull if some
> > > linux driver allow me to work with my EMU-1212 under this system: the
> > > only use of windows I'm doing now is for sound and music.And EMU-1212 is
> > > really a great soundcard.
> >
> > Can you provide the "lspci -vn" output?  It's possible that some
> > functionality will work if the driver just treats the card like an APS
> > (that is, an emu10k1 with no AC97).
> >
> > Lee
> 
> Hereby is what you asked for.
> Thanks in advance
> BYE
> 

James, here's the entry for the 1212m:

0000:02:0a.0 Class 0401: 1102:0004 (rev 03)
        Subsystem: 1102:4001
        Flags: bus master, medium devsel, latency 32, IRQ 5
        I/O ports at 9000
        Capabilities: [dc] Power Management version 2

Let's add this to the driver & see what happens.  I'll try to get a
patch together, feel free to post one if you get a chance before I do.

Lee



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
