From: Frank Barknecht <fbar@footils.org>
Subject: Re: Quattro woes or: What does "SNDRV_PCM_IOCTL_START failed" mean?
Date: Tue, 11 Mar 2003 19:02:10 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030311180209.GC1812@fliwatut.scifi>
References: <20030310223321.GA10836@fliwatut.scifi> <s5hwuj62pbv.wl@alsa2.suse.de> <20030311103209.GA4139@fliwatut.scifi> <s5hllzm2hcc.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hllzm2hcc.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hallo,
Takashi Iwai hat gesagt: // Takashi Iwai wrote:

> make sure that you starting the jack with 48kHz and the period size
> aligned to 48, such as 48, 96, 192...

Sorry, but I do not understand this fully. First, I'd rather like to
run at 44.1 kHz, because that's a bit less computation for the
softsynth I'm using. Will this lead to problems? I can live with a bit
higher latency.

Second: the alsa driver of jack has these options:

alsa PCM driver args: 
    -d alsa-pcm-name (default: default)
    -r sample-rate (default: 48kHz)
    -p frames-per-period (default: 1024)
    -n periods-per-hardware-buffer (default: 2)

I had to run with "-n 3", with "-n 2" jack wouldn't start. 

The period size you mentioned must be "-p frames-per-period", if I'm
right?
So if running with 44.1 kHz, should I use something like "-p 1025"
where  41*25 = 1025?

But this doesn't work with Pd, which expects powers of 2...

ciao
-- 
 Frank Barknecht                               _ ______footils.org__


-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
