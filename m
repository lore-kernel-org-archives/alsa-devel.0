From: Andrew de Quincey <adq_dvb@lidskialf.net>
Subject: Re: Audigy2 mixer not working
Date: Tue, 11 Mar 2003 22:50:09 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200303112250.10072.adq_dvb@lidskialf.net>
References: <200303110926.14478.adq_dvb@lidskialf.net> <20030311201702.GA260@znex>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030311201702.GA260@znex>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mark J Roberts <mjr@znex.org>, Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


On Tuesday 11 March 2003 20:17, Mark J Roberts wrote:

> > If I run alsamixer, I can adjust sliders.... but it has no effect on the
> > output. I can run other programs (e.g. xmms) simultaneously, and see the
> > silder changing in alsamixer, but again, it has no effect on the output.
>
> My mixer is semi-functional (alsa cvs). The outputs on the audigy2
> look like this:
>
> 	<FIREWIRE> <LINE3> <LINE2> <LINE1> (......)
>
> Line3's channels are independent and controlled by the "Wave Center"
> and "Wave LFE" controls. Line2 is controlled by "Wave Surround"
> (this is what I use at the moment).
>
> Line1 does not work at all, though I will try your hint about -D
> front later.

Unfortunately, I was mistaken; the front thing doesn't work :(

I've done some tests of just the card itself (the drive can wait until this 
lot is sorted). In the following, I set all mixer controls to max. I'll keep 
going and sort these issues myself, but just in case it jogs someone's 
memory.....


Test of alsarc devices:

When playing without choosing a device ("default" I assume):
* Sound plays through the CENTER, LFE, and SURROUND speakers... and not 
through the FRONT ones.
* Active mixer controls: "Wave Center", "Wave LFE", "Wave Surround"

When "front" is chosen:
* Sound plays through the CENTER, LFE, and SURROUND speakers... and not 
through the FRONT ones.
* Active mixer controls: "Wave Center", "Wave LFE", "Wave Surround"

When "rear" is chosen:
* Sound plays through the REAR speakers.
* Active mixer controls: "Surround"

When "center_lfe" is chosen:
* Sound plays through CENTER and LFE speakers.
* Active mixer controls: "Center", "LFE"


Test of connectors on the card:

* LIN_OUT1. Does not work
* LIN_OUT2. Works
* LIN_OUT3. Works. Rear Center out not tested.
* MIC_IN. Does not work.
* LIN_IN. untested.
* Digital out jack. untested.


Tone/Bass/Treble seem to work fine.


Questions:

1) Why are there two seperate mixer controls for Center, LFE, and Surround, 
each of which is only active at a certain time... is this just a weirdness of 
the card, or is this another issue? I'd really rather just have _one_ control 
to adjust each setting :)

2) None of the non-AC97 mixer controls allow muting. Is this just a side 
effect of the card, or is it feasible for me to add this to the driver?

3) Should "front" just play through the front speakers? 

4) What about the Audigy2's extra output, Rear Center? LIN_OUT3 on the card is 
a three-way connector, not a two-way one.





In reply to Takashi Iwai:

> it seems that audigy2 is somewhat different from audigy1 and bypasses
> the AC97.  the master, PCM, etc. volumes are for ac97 and that's why
> these volumes don't affect.
> you can adjust the volume via "Wave" volume, btw.

Does this mean that on the Audigy2, the ac97 mixer is non-functional? I 
patched the driver to disable the creation of an ac97 mixer for Audigy2 
cards.. Means I have a _sane_ number of mixer devices, and everything still 
works... as well as it did before. Is this a valid assumption? If so, shall I 
submit a patch?


-- 
adq


-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
