From: Erik de Castro Lopo <erikd-alsa@mega-nerd.com>
Subject: Re: Two sound cards, only sound out of one
Date: Fri, 29 Aug 2003 13:21:14 +1000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030829132114.4f0ef4f6.erikd-alsa@mega-nerd.com>
References: <20030824121353.06de39c8.erikd-alsa@mega-nerd.com>
	<s5hptiu80km.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hptiu80km.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 25 Aug 2003 12:59:37 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> if aplay -vv shows the correct configuration and VU meters, 

It does.

> i'd
> suspect it's a hardware issue.  i.e. mixer mutes or physical
> connection.  to check the card's playback without physical connection,
> you can record via loopback like the following procedure:
> 
> 1. choose "Mix" as the capture source.
> 2. turn on "Capture" switch.
> 3. raise "Capture" volume.
> 4. adjust "PCM" and "Master" volumees and switches.
> 5. play a file and record at the same time.
> 6. check the recorded file

I'm not really sure how to do all this but it does seem like a good 
debugging method. Could you be a little bit more explicit about how 
the above steps are carried out?


> also, you can try to swap the card order,
> 
> 	options snd-ens1371 index=1,0

Tired this, ran "update-modules" and restarted alsa.

This changes the way that the two cards are listed in the /proc/asound/cards
output but otherwise not much else changes. The same physical card that works
before still works while the one that never worked still doesn't work.

Erik
-- 
+-----------------------------------------------------------+
  Erik de Castro Lopo  nospam@mega-nerd.com (Yes it's valid)
+-----------------------------------------------------------+
"Compiling C code with warnings switched off is like practicing
high wire trapeze without a safety net. Even experienced
practitioners try to avoid it." -- me


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
