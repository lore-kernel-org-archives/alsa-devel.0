From: Adam Belay <abelay@MIT.EDU>
Subject: Re: snd-cs4236 (possibly all isa-pnp cards or all alsa isa-pnp
 cards) broken in 2.6.16-rc4
Date: Tue, 21 Feb 2006 00:27:26 -0500
Message-ID: <1140499646.21116.30.camel__25415.6916089871$1140499638$gmane$org@localhost.localdomain>
References: <43F9F9F2.4070203@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from biscayne-one-station.mit.edu (BISCAYNE-ONE-STATION.MIT.EDU [18.7.7.80])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 0E996152
	for <alsa-devel@alsa-project.org>; Tue, 21 Feb 2006 06:26:15 +0100 (MET)
In-Reply-To: <43F9F9F2.4070203@keyaccess.nl>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Takashi Iwai <tiwai@suse.de>, Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2006-02-20 at 18:18 +0100, Rene Herman wrote:
> I stuck a few printks in cs4236.c. From "snd_cs423x_unregister_all",
> "pnp_unregister_card_driver(&cs423x_pnpc_driver)" is indeed being called
> but the card driver's own remove method, snd_cs423x_pnpc_remove, is not.
> 
> I started looking, but ran into the next issue again -- when snd-cs4236
> is not card1 but card0, modprobe -r oopses in snd_timer_free (attached)
> meaning debugging this wants someone with more of an overview of recent
> damage done^W^Wchanges made.
> 
> Given that calling pnp_unregister_card_driver() is not cs4236 specific,
> I assume the problem is more general. Possibly all ALSA ISA-PnP drivers.
> Or, given that pnp_unregister_card_driver is not an ALSA function, maybe
> even all ISA-PnP drivers using the card_driver interface.
> 
> The more general this problem turns out, the more reason there would be
> for fixing this pre 2.6.16, obviously. I can test patches...
> 
> Rene.

Hi Rene,

Hopefully this email account will work better.  In any case, thanks for
bringing this bug to my attention.  I may have stumbled across it a
couple days ago, and would appreciate if you would try this patch:
(there may be some fuzz)

--- a/drivers/pnp/card.c        2006-01-02 22:21:10.000000000 -0500
+++ b/drivers/pnp/card.c        2006-02-17 00:45:37.123525896 -0500
@@ -302,13 +302,11 @@
        down_write(&dev->dev.bus->subsys.rwsem);
        dev->card_link = clink;
        dev->dev.driver = &drv->link.driver;
-       if (drv->link.driver.probe) {
-               if (drv->link.driver.probe(&dev->dev)) {
-                       dev->dev.driver = NULL;
-                       dev->card_link = NULL;
-                       up_write(&dev->dev.bus->subsys.rwsem);
-                       return NULL;
-               }
+       if (pnp_bus_type.probe(&dev->dev)) {
+               dev->dev.driver = NULL;
+               dev->card_link = NULL;
+               up_write(&dev->dev.bus->subsys.rwsem);
+               return NULL;
        }
        device_bind_driver(&dev->dev);
        up_write(&dev->dev.bus->subsys.rwsem);


It's possible that the attach mechanism isn't working correctly because
of recent driver model changes.  If this is the case, it would also
explain the detach-not-called issues.

Thanks,
Adam




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
