From: Thomas Fjellstrom <tfjellstrom@shaw.ca>
Subject: Re: rawmidi problem (was Re: ALSA homepage redesign)
Date: Mon, 22 Apr 2002 13:50:27 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <0GUZ006OEJ0ZSC@l-daemon>
References: <Pine.LNX.4.33.0204221307200.564-100000@pnote.perex-int.cz>
 <0GUZ004K22BUKO@l-daemon> <s5hsn5n3ee8.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hsn5n3ee8.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On April 22, 2002 10:07 am, you wrote:
> Hi Thomas,
>
> At Mon, 22 Apr 2002 07:49:41 -0600,
>
> Thomas Fjellstrom wrote:
> > On April 22, 2002 05:10 am, you wrote:
> > > On Sun, 21 Apr 2002, Patrick Shirkey wrote:
> > > > I can add something but what is the official view from Jaroslav?
> > >
> > > 0.5.x release is no longer supported from the developer perspective.
> > > All our focus is in 0.9.x codebase. I'll release 0.9.0rc1 ASAP (after
> > > fixing and testing a few changes), so it'll be clear that the API is
> > > finished and code is working.
> >
> > It is? Last time I tried using Rawmidi on an emu10k1 chip I got no sound.
> > I had a soundfont loaded, and tried with my own code and the rawmidi demo
> > source. Midi would play with the pmidi program. I've mentioned it once
> > before, nothing came of it, so Im mentioning it again. :)
>
> ok now let's fix it ;)

Sory for being such a pain....

> however i don't understand quite well the situation from your posts.
> could you elaborate the symptom?
> which program and how did you test?
>
>

I don't hear any sound when playing midi using the rawmidi interface (using 
my SBLive! Value), I tried, some code written by me, and the rawmidi.c source 
demo that is included with the driver package. (A sound font is loaded, and 
midis play fine with sound, using the pmidi program.)

-- 
Thomas Fjellstrom
tfjellstrom@shaw.ca
http://strangesoft.net
