From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [snd-intel8x0] distortion on PCM volume >> 50%
Date: Sun, 30 Nov 2003 11:35:27 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0311301133500.21602@pnote.perex-int.cz>
References: <20031130100343.GA12681@zombie.inka.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20031130100343.GA12681@zombie.inka.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Eduard Bloch <eb@zombie.inka.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sun, 30 Nov 2003, Eduard Bloch wrote:

> Hello,
> 
> I have some problems with a ac97 based sound card (Notebook built-in)
> where the kernel driver works fine (except of not beeing able to
> resample on-the-fly).
> 
> When I set the PCM mixer volume to more then 50%, I hear few sound
> fragments. If I go over 75% I hear them all the time and on 100% PCM,
> the sound is full of scratching fragments. You can get an example
> catched with microphone on
> http://sites.inka.de/W1752/alsa-distortion.ogg and the original is on
> www.vorbis.com/music/Mists_of_Time-4T.ogg . First I suspected a speaker
> problem since it sounds very similar to overloud speaker setting, but it
> is not!

Are you sure that you don't have enable any other analog input? My 
notebook has very noisy build-in microphone for example.

Also note that if you have value over 70% with most of AC'97 controls, the 
analog gain is applied to the signal (thus you can really overdrive the 
output or input).

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
