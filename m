From: Frank Barknecht <fbar@footils.org>
Subject: Re: Creative MP3+ or Hercules Muse Pocket
Date: Tue, 4 May 2004 23:53:46 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040504215346.GD20897@fliwatut.scifi>
References: <1083645143.18667.22.camel@pheuri>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <1083645143.18667.22.camel@pheuri>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hallo,
Robin Cook hat gesagt: // Robin Cook wrote:

> Trying to find out if either or both of the Creative Soundblaster MP3+
> or the Hercules Muse Pocket usb sound cards are supported by the usb
> driver in ALSA?
> 
> If so are is there anything special that needs to be done to get them
> setup under alsa?

Normally these cards just all use the snd-usb-audio driver. If you run
kernel 2.6 you can just "modprobe snd-usb-audio" to get sound. I never
hear of the Hercules card, but it looks very cool with that knob,
which might even work as an input device on Linux. This would then
maybe require the hid/event interface of the USB system in the kernel,
which is not part of ALSA.

I'd say, if somehow possible, try to test the Muse if it works. 

Ciao
-- 
 Frank Barknecht                               _ ______footils.org__


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
