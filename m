From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: AW: usb quattro
Date: Fri, 06 Sep 2002 04:25:34 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D77AFAE.6030803@boosthardware.com>
References: <DAELIEGDPLDDCIJPAICBGEHNCDAA.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Karsten Wiese <annabellesgarden@yahoo.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Karsten Wiese wrote:

>> >>EIP; c01e52e4 <uhci_remove_pending_qhs+44/90>   <=====
>>
> 
> 
> the Tascam US-428 driver (copied / changed from snd-usb-audio ) showed a
> similar problem.
> I worked around it by not using ASYNC_UNLINKing of the urbs.
> 
> uhci_remove_pending_qhs is called to unlink urbs in ASYNC mode.
> seems as if uhci has a bug ? or may we asyncly unlink only 1 urb at a time?
> any experiences with kernels > 2.4.18 ?
> 

This is with kernel 2.4.19pre10

It may be that the code is fixed for the 2.5.x series. there seems to be 
a few different versions of the uhci code floating around.



-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.boosthardware.com/LAU/guide/
========================================

"Um...symbol_get and symbol_put... They're
kindof like does anyone remember like get_symbol
and put_symbol I think we used to have..."
- Rusty Russell in his talk on the module subsystem



-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
