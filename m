From: Allan Klinbail <allank@labyrinth.net.au>
Subject: Re: Re: MTP-AV problems (Re: intel8x0 sequencer &
	MTP-AV) - success
Date: 17 Feb 2003 22:36:31 +1100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1045481799.16503.33.camel@littlewolf2.littlewolf>
References: <1044258789.30428.61.camel@littlewolf2.littlewolf>
	<s5h3cn5ino4.wl@alsa2.suse.de>
	<1044273602.2013.6.camel@littlewolf2.littlewolf>
	<s5hheb8l05o.wl@alsa2.suse.de>
	<1045193186.10268.392.camel@littlewolf2.littlewolf>
	<s5h4r77jdmm.wl@alsa2.suse.de>
	<1045389509.6765.21.camel@littlewolf2.littlewolf>
	<s5hfzqni39i.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hfzqni39i.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Alsa-dev <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi Takashi

At this stage till I get the cvs version of ALSA I have no further
information. 

I did only notice at the start of using the sequencer.. once it happened
once it didn't happen again. 

However, Ryan Pavlik has also seen this behaviour and may be able to
tell you a little more. 


cheers

Allan


On Mon, 2003-02-17 at 21:56, Takashi Iwai wrote:
> At 16 Feb 2003 20:58:23 +1100,
> Allan Klinbail wrote:
> > 
> > One glitch I noticed was that the driver seemed to send the note
> > information to all ports when the sequence I had only sent to one of the
> > MTPAV ports... When I assigned a second to a different port it began
> > behaving correctly.
> 
> i'm not sure whether the driver bug or what else.
> i guess the hardware port is initialized to 0 (or it IS as default),
> which corresponds to the broadcast.
> this may happen even if a message "F5 00" is sent by an application.
> so, we'll need to trace all F5 xx messages.
> 
> does this broadcast behavior appear at the first start only?
> 
> 
> Takashi




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
