From: Marco Canini <m.canini@libero.it>
Subject: Re: Problem with multiplexing
Date: 29 May 2003 10:50:13 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1054198212.524.3.camel@jabawack.canini.org>
References: <1053038198.473.5.camel@jabawack.canini.org>
	 <s5hptmjdysk.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hptmjdysk.wl@alsa2.suse.de>
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

On Fri, 2003-05-16 at 11:30, Takashi Iwai wrote:
> At 16 May 2003 00:36:38 +0200,
> Marco Canini wrote:
> > 
> > Please gimme an answer!
> > 
> > I've a CS4624 sound card, i compiled the kernel 2.5.68 with ALSA all
> > built-in (no modules), i choosed to compile the following:
> > 
> > Sequencer support
> > OSS API emulation
> > OSS Mixer API
> > OSS PCM (digital audio) API
> > RTC Timer support
> > 
> > PCI devices -> Cirrus Logic (Sound Fusion) CS4280/CS461x/CS462x/CS463x
> > 
> > I don't use devfs, so i created the needed devices trough the proper
> > script, and i can actually get sound from native alsa apps and oss apps.
> > 
> > What i can't get to work is the multiplexing: i mean whan more than one
> > app open /dev/dsp and i can listen more than one audio stream at the
> > same time.
> > 
> > I tried today on another machine with a sb live and without alsa, well
> > there it works!
> > 
> > I thought that alsa do some sort of software multiplexing if the
> > hardware multiplexing is unavailable.
> > 
> > Anyway do you have some ideas of what's going on here?
> 
> the latest driver supports multiple playback on this chip but only
> with the new DSP code.  please turn on CONFIG_SND_CS46XX_NEW_DSP
> (still tagged experimental).
> 
Thanks a lot.
I've enabled it and now i can experience hardware mixing.
It's still tagged experimental but what do you think about its
stability?

> 
> Takashi
> 
> 
> -------------------------------------------------------
> Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
> The only event dedicated to issues related to Linux enterprise solutions
> www.enterpriselinuxforum.com
> 
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
-- 
Marco Canini <m.canini@libero.it>



-------------------------------------------------------
This SF.net email is sponsored by: eBay
Get office equipment for less on eBay!
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
