From: Eduard Bloch <eb@zombie.inka.de>
Subject: Re: [snd-intel8x0] distortion on PCM volume >> 50%
Date: Sun, 30 Nov 2003 12:36:24 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031130113624.GA1829@zombie.inka.de>
References: <20031130100343.GA12681@zombie.inka.de> <Pine.LNX.4.58.0311301133500.21602@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0311301133500.21602@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Moin Jaroslav!
Jaroslav Kysela schrieb am Sunday, den 30. November 2003:

> > I have some problems with a ac97 based sound card (Notebook built-in)
> > where the kernel driver works fine (except of not beeing able to
> > resample on-the-fly).
> > 
> > When I set the PCM mixer volume to more then 50%, I hear few sound
> > fragments. If I go over 75% I hear them all the time and on 100% PCM,
> > the sound is full of scratching fragments. You can get an example
> > catched with microphone on
> > http://sites.inka.de/W1752/alsa-distortion.ogg and the original is on
> > www.vorbis.com/music/Mists_of_Time-4T.ogg . First I suspected a speaker
> > problem since it sounds very similar to overloud speaker setting, but it
> > is not!
> 
> Are you sure that you don't have enable any other analog input? My 
> notebook has very noisy build-in microphone for example.

No, my microphone is not built-in and not attached, the mixer is set to 0.

> Also note that if you have value over 70% with most of AC'97 controls, the 
> analog gain is applied to the signal (thus you can really overdrive the 
> output or input).

After almost an hour playing different stuff with different settings
with the ALSA, Linux-Kernel and Windows driver, I have the following
assumption: both, Kernel driver and Windows driver are cheating! They do
not present the Bass/Treble boost controls and the PCM volume at 75% in
ALSA  is quite comparable with 100% PCM volume with other drivers,
having quite comparable quality when Bass/Treble boost were set to 0.

So what I wish for the future version of ALSA drivers: a module option
to set the real mixer scale for PCM (or other sources) between 0 and X
percent while the visible scale is between 0 and 100 percent and
recalculated internaly to 0..X%.

But back to the second problem, I created a live example on
http://sites.inka.de/W1752/b.ogg - you can hear the fragments on time
points 0:35 and 1:31.

MfG,
Eduard.
-- 
Wer gar zu viel bedenkt, wird wenig leisten.


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
