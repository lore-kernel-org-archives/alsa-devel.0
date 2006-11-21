From: Thibault Le Meur <Thibault.LeMeur@supelec.fr>
Subject: Re: snd-usb-audio and M-Audio Quattro problems.
Date: Tue, 21 Nov 2006 22:49:49 +0100
Message-ID: <20061121224949.p1tiihvts08k4k0c@webmail.supelec.fr>
References: <45635941.70406@inbox.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <45635941.70406@inbox.ru>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Pavel Polischouk <pavelvp@inbox.ru>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

> I submitted a bug report on the matter some time ago
> (https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2607), see there
> for detailed description. Short description: Quattro initializes itself
> to an unusable (or semi-usable) state and refuses to change its mode
> afterwards.
>
> After seeing no activity on the bug for some time I decided to
> investigate the problem further. First I tried to extend the Audiophile
> hack to Quattro (that disables all altsettings on driver init except the
> one desired). Surprisingly it worked - almost. It only works the first
> time after Quattro has been powered up, after that, re-loading the
> driver doesn't help - the device sticks to the old state.


Yes that's the same for the audiophile Usb device: I have to turn off  
the audiophile usb card, then deregister (modprobe -r) the driver, and  
register it back with a device_setup parameter corresponding to the  
new device mode.

> Are there any suggestions on how to make the device accept the changing
> settings? Perhaps there's a need for hardware reset or something similar
> between mode changes? Any suggestions/patches are appreciated.

The windows driver only selects AltSettings 0 for all interfaces  
"multiple times" before switching modes. I tried to implement this but  
with no success. That's why I didn't included this in the first  
Audiophile USB patch. However I'm still interrested in a way to do this.

Another 'M-audio usb' user recently wrote a patch for the Fast track  
pro (however I'm not sure it has been included in the hg repository  
yet). I wonder if he had managed to handle such setup switching for  
his device.

Regards,
Thibault


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
