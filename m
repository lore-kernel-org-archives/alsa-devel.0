From: Josh Huber <huber+keyword+alsa.9c0e1c@alum.wpi.edu>
Subject: Re: snd-powermac in CVS busted?
Date: Sun, 22 Sep 2002 13:07:29 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <87d6r66jhq.fsf@mail.paradoxical.net>
References: <87it11icm2.fsf@mail.paradoxical.net> <s5hr8fpouks.wl@alsa2.suse.de>
 <87k7lg2ykf.fsf@mail.paradoxical.net>
Reply-To: Josh Huber <huber+dated+1033144972.b0fc92@alum.wpi.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Josh Huber <huber+keyword+alsa.9c0e1c@alum.wpi.edu> writes:

> Takashi Iwai <tiwai@suse.de> writes:
>
>> could you change 'Mic Boost' once to another value?
>> i got reports that this affects even on the pcm playback...
>
> Okay, thanks.  I'll try this tonight after I get home from work!

It works after tweaking the Mic Boot settings, but there are some
issues unfortunately :(

Things are close though!

1) The OSS emulation interface seems to be working very well -- xmms
   functions perfectly with it using the OSS output plugin.
2) alsaplayer generates static unless you turn the volume slider
   almost to 0, and even then the audio contains static during the
   loud parts of the music.
3) the xmms alsa output plugin always generates static
4) terminatorX does NOT generate static, and the audio sounds great...

I suspect there are some endian issues, eh? :)  I wonder why the oss
emulation layer works fine though.

As a review, I'm running the CVS versions of all the libraries and
tools now as well as the drivers:

Module                  Size  Used by    Not tainted
snd-pcm-oss            45972   1
snd-mixer-oss          12960   0 [snd-pcm-oss]
snd-usb-midi            8208   0 (unused)
snd-seq-virmidi         3808   0 [snd-usb-midi]
snd-seq-midi-event      3888   0 [snd-usb-midi snd-seq-virmidi]
snd-seq                45560   1 [snd-usb-midi snd-seq-virmidi
snd-seq-midi-event]
snd-rawmidi            16048   0 [snd-seq-virmidi]
snd-seq-device          5012   0 [snd-usb-midi snd-seq snd-rawmidi]
snd-powermac           35508   2
snd-pcm                69296   0 [snd-pcm-oss snd-powermac]
snd-timer              12960   0 [snd-seq snd-pcm]
snd                    31452   1 [snd-pcm-oss snd-mixer-oss
snd-usb-midi snd-seq-virmidi snd-seq-midi-event snd-seq snd-rawmidi
snd-seq-device snd-powermac snd-pcm snd-timer]
soundcore               4616   3 [snd]
orinoco_cs              5336   1
orinoco                33408   0 [orinoco_cs]
hermes                  9632   0 [orinoco_cs orinoco]
i2c-core               14568   0 [snd-powermac]

All the fun applictions use the ALSA interface, which is what I really
want to start using.
-- 
Josh Huber




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
