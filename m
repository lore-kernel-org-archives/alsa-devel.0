From: Thomas Fjellstrom <tfjellstrom@shaw.ca>
Subject: Re: rawmidi problem (was Re: ALSA homepage redesign)
Date: Wed, 24 Apr 2002 03:13:51 -0600
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <0GV200052EUB9J@l-daemon>
References: <Pine.LNX.4.33.0204221307200.564-100000@pnote.perex-int.cz>
 <s5hk7qxh40p.wl@alsa2.suse.de> <0GV20065JEJMS1@l-daemon>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <0GV20065JEJMS1@l-daemon>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

On April 24, 2002 03:06 am, you wrote:
> On April 24, 2002 02:52 am, you wrote:
[snip]
> > > Three: after a while, about a minute or so of playing a midi, the midi
> > > starts getting slower and slower.. and CPU usage goes to 0... I'm sure
> > > Its not the midi player, as I've tried it's 'DIGIMID' driver (which
> > > uses a converted soundfont to play through the digital pcm interface)
> > > and it doens't have this problem.
> >
> > do you use emu10k1 virmidi or another device?
> > i suspect the bug might still be in virmidi code..
>
> Thanks.

Oops... I didn't see that last bit... Im not exactly sure. I just use the 
rawmidi api, and open 'hw:0,1' or 'hw:0,2' (the only valid options on my 
system, as I have no midi board hoked up to the midi port)

-- 
Thomas Fjellstrom
tfjellstrom@shaw.ca
http://strangesoft.net
