From: Albert Jongkit Wong <awong@cs.washington.edu>
Subject: Re: ppc usb-audio problems
Date: Wed, 9 Oct 2002 11:08:43 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20021009105855.H24345-100000@fiji.cs.washington.edu>
References: <s5hvg4b28lq.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hvg4b28lq.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> do you mean that the playback position moves but no sounds come out?
> and does oss plugin work?

With the alsa plugin, the playback position moves and I get stuff that 
just sounds like static instead of music (the volume controls still work).  
The oss plugin works fine.  

I just tried another test by doing:

mpg321 -s /mnt/mp3/Mpegs/Anime/Arc\ en\ Ciel,\ Le/DIVE_T~1.MP3 | aplay -c 
2 -t raw -r 44100 -f S16_LE -

Which worked properly.  Is it possible that xmms, esd, mplayer, etc are
the broken ones?
 


> please check /proc/asound/card0/stream0 which format is supported
> actually.

I'm not sure how to read this output, so I'm pasting it below.

terran@Mittermeyer asound $ cat card0/stream0 
Apple Computer, Inc. Speakers : USB Audio

Playback:
  Status: Stop
  Interface 1
    Altset 1
    Format: S16_LE
    Channels: 1
    Endpoint: 1 OUT (ADAPTIVE)
    Rates: 5000 - 50000 (continous)
  Interface 1
    Altset 2
    Format: S16_LE
    Channels: 2
    Endpoint: 1 OUT (ADAPTIVE)
    Rates: 5000 - 50000 (continous)
  Interface 1
    Altset 3
    Format: S24_3LE
    Channels: 2
    Endpoint: 1 OUT (ADAPTIVE)
    Rates: 5000 - 50000 (continous)



Thanks,

Albert



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
