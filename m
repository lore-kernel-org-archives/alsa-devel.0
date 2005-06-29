From: christophe barbe <christophe@cattlegrid.net>
Subject: Re: intel8x0 ACPI suspend/resume bug
Date: Wed, 29 Jun 2005 10:36:19 -0400
Message-ID: <20050629143619.GA8460@cattlegrid.net>
References: <20050628150638.GB6677@cattlegrid.net> <s5hacl97blk.wl%tiwai@suse.de> <1120052108.14654.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1120052108.14654.3.camel@localhost.localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 29, 2005 at 09:35:08AM -0400, christophe barbe wrote:
> Le mercredi 29 juin 2005 ?? 11:31 +0200, Takashi Iwai a ??crit :
> > First of all, use alsa-1.0.9b, just to be sure.
> 
> I will try it asap.

Done with same results.

> I saved all proc files before and after a suspend/resume cycle and look
> at the diff:
> 
> In /proc/asound/card0/intel8x0 
> I have the following diff:
> before: Global control : 0xc0000002
> after: Global control : 0x00000002
> 
> /proc/asound/card0/pcm0p/sub0/[status,sw_params,hw_params] contains
> "closed" after while they have more content before but I suspect it's
> normal.
> And the file /proc/asound/card0/pcm0p/sub0/info contains the same in
> both case except the value of subdevices_avail which is 0 before and 1
> before.
> 
> Finally I have the following change in the registers:

I downloaded the datasheet for Intel 82801DB which I think is what I
have and found what I believe to be the registers of the file
codec97#0/ac97#0-0+regs and found the following
 
> before:
> 0:10 = 8989
> 0:12 = 9f9f
> 0:14 = 0000
> 0:16 = 9f9f
> 0:18 = 1010
> 0:1a = 0000
> 0:1c = 8080
> ...
> 0:76 = 2010
> 
> after:
> 0:10 = 8909
Line in volume
> 0:12 = 9f1f
CD volume
> 0:14 = 0000
> 0:16 = 9f1f
Aux in volume
> 0:18 = 1010
> 0:1a = 0000
> 0:1c = 8000
Record gain
> ...
> 0:76 = 0010
This one seems to be undocumented.

I have not yet find how the volume is encoded but I suspect it's two 8-bit words one for the left and one for the right which seems to match the fact that I usually loose the sound on one side. But all registers seems to be unrelated to mp3-to-pcm output.

Any idea for the register 76 ?

Christophe

-- 
Christophe Barbe <christophe.barbe@ufies.org>
GnuPG FingerPrint: E0F6 FADF 2A5C F072 6AF8  F67A 8F45 2F1E D72C B41E



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
