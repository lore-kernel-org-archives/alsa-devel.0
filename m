From: Frank Barknecht <fbar@footils.org>
Subject: Re: Quattro woes or: What does "SNDRV_PCM_IOCTL_START failed" mean?
Date: Tue, 11 Mar 2003 19:57:35 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030311185735.GA4312@fliwatut.scifi>
References: <20030311180209.GC1812@fliwatut.scifi> <20030311184050.5D539C6F38@mailproxy1.netcologne.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20030311184050.5D539C6F38@mailproxy1.netcologne.de>
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
Paul Davis hat gesagt: // Paul Davis wrote:

> >But this doesn't work with Pd, which expects powers of 2...
> 
> i suggest you try to find an "ALSA-native" configuration that Pd and
> your quattro *do* work with, then we can map that to JACK.

Well, jack was a workaround because I couldn't get Pd to work
ALSA-natively in the first place, while the Jack-solution now works.
In fact, I just 0 minutes ago found a working Pd solution as well, by
taking Takashi's tip to run at 48000 Hz at work with Pd. And voila,
now Pd works with the Quattro...

It only required downgrading the kernel and playing (a lot) with all
those parameters, Jack (as I wrote on jack-devel) also had strange
problems on 2.4.20 that went away on 2.4.18, even without Pd involved.

Best Regards,
-- 
 Frank Barknecht                               _ ______footils.org__


-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
