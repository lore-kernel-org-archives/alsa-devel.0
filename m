From: Doug McLain <nostar@comcast.net>
Subject: Re: EZ8 ADAT I/O card (ICE1712 chipset)
Date: Wed, 31 Mar 2004 23:05:48 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <406B951C.7010705@comcast.net>
References: <401A62AD.2050302@comcast.net>	<402203D6.3030308@comcast.net> <s5hisilah4g.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070707030901010609020809"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hisilah4g.wl@alsa2.suse.de>
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

This is a multi-part message in MIME format.
--------------070707030901010609020809
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Here is a patch for EZ8 support with the snd-ice1712 driver.  I kept 
everything contained within hoontech.c, as you suggested.  I never 
bothered to go farther trying to uniquely identify between the 2 cards 
since, this has been working fine for me. Also, I have contacted both 
Hoontech and Event, informing them of the conflict by not creating their 
own uniqe subvendor id. Hopefully one or both will release a driver 
update that will give either one a unique id.  I never made a patch 
before, but it looks fine to me.  Please let me know otherwise.

Just load the driver with the ez8=1 option to enable EZ8 support.

Takashi Iwai wrote:
> At Thu, 05 Feb 2004 03:50:30 -0500,
> Doug wrote:
> 
>>Here is what I have done to the ice1712.c file in order to add support 
>>for my EZ8 card.  It's a temporary hack (emphesis on 'hack') until I add 
>>code to reliably identify the ez8 from the hoontech (both cards share 
>>the same subvendorid).
>>
>>/* EZ8 Hack */
>>int ez8=0;
>>MODULE_PARM(ez8, "i");
>>
>>I added this at the end of all ofthe MODULE_PARM() definitions.
>>
>>On line 2505, I made this change:
>>
>>for (tbl = card_tables+(ez8 ? 1 : 0); *tbl; tbl++) { /* EZ8 Hack */
>>
>>Just a quick and dirty way to skip over the hoontech card_table entry so 
>>that my EZ8 is recognized as a generic device, while still correctly 
>>detecting my Delta 1010LT card when ez8=1 is added as argument to the 
>>snd-ice1712 module.  Module functions normally if ez8 is not added to 
>>command line (or is set to 0).  This would not work if an ez8 and 
>>hoontech were used together.
> 
> 
> i'd suggest to check ez8 option in hoontech.c rather than in the
> ice1712.c routine.
> 
> 
> 
>>This, of course, is only a temporary fix for my own use, while I work on 
>>code to correctly differentiate between the ez8 and the hoontech card. 
>>In addition, there are a few EZ8 specific features that don't seem to be 
>>implemented with the generic driver.  Since ADAT is fully functional, 
>>though, I now will spend much more time using the card/driver (with 
>>ardour/jack) and less finishing support.  I don't think there will be 
>>any objection here, since I think I am the only linux using EZ8/EZBus 
>>owner on the planet :)
>>
>>Does anyone have the ICE1712 chip documentation?
> 
> 
> ice1712 chip spec is open.  you can find it on ALSA's ftp.
> maybe mirrored on somewhere else, too. 
> 
> but usually it's not enough for writing the complete driver, since the
> choice and connection of codec chips depends on the board.
> 
> 
>>  How were the drivers 
>>for the other ice1712 based cards written?
> 
> 
> in most cases, we have contact with the hardware vendor, and get some
> information about the hardware.
> 
> 
>> Were the manufacturers 
>>contacted and data released under some sort of non-disclosure agreement? 
> 
> 
> depends.
> 
> 
> Takashi
> 

--
http://nostar.isa-geek.com/

--------------070707030901010609020809
Content-Type: text/plain;
 name="alsa-driver-cvs.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa-driver-cvs.diff"

Index: alsa-kernel/pci/ice1712/hoontech.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/ice1712/hoontech.c,v
retrieving revision 1.3
diff -c -r1.3 hoontech.c
*** alsa-kernel/pci/ice1712/hoontech.c  5 Mar 2004 09:08:39 -0000       1.3
--- alsa-kernel/pci/ice1712/hoontech.c  1 Apr 2004 03:31:52 -0000
***************
*** 32,37 ****
--- 32,40 ----
  #include "ice1712.h"
  #include "hoontech.h"

+ /* EZ8 Hack:  pass ez8=1 for EZ8 card */
+ int ez8=0;
+ MODULE_PARM(ez8, "i");

  static void __devinit snd_ice1712_stdsp24_gpio_write(ice1712_t *ice, unsigned char byte)
  {
***************
*** 151,156 ****
--- 154,173 ----
  static int __devinit snd_ice1712_hoontech_init(ice1712_t *ice)
  {
        int box, chn;
+
+       /* EZ8 Hack: Change shortname and subvendor id, Recall functions called in
+        * snd_ice1712_chip_init when it still thinks it is a Hoontech DSP24 card.
+        */
+       if (ez8) {
+               strcpy(ice->card->shortname, "Event Electronics EZ8");
+               ice->eeprom.subvendor = 0;
+               ice->gpio.write_mask = ice->eeprom.gpiomask;
+               ice->gpio.direction = ice->eeprom.gpiodir;
+               snd_ice1712_write(ice, ICE1712_IREG_GPIO_WRITE_MASK, ice->eeprom.gpiomask);
+               snd_ice1712_write(ice, ICE1712_IREG_GPIO_DIRECTION, ice->eeprom.gpiodir);
+               snd_ice1712_write(ice, ICE1712_IREG_GPIO_DATA, ice->eeprom.gpiostate);
+               return 0;
+       }

        ice->num_total_dacs = 8;
        ice->num_total_adcs = 8;
Index: alsa-kernel/pci/ice1712/ice1712.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/ice1712/ice1712.c,v
retrieving revision 1.47
diff -c -r1.47 ice1712.c
*** alsa-kernel/pci/ice1712/ice1712.c   26 Mar 2004 12:25:51 -0000      1.47
--- alsa-kernel/pci/ice1712/ice1712.c   1 Apr 2004 03:31:55 -0000
***************
*** 41,46 ****
--- 41,49 ----
   *  2003.02.20  Taksahi Iwai <tiwai@suse.de>
   *    Split vt1724 part to an independent driver.
   *    The GPIO is accessed through the callback functions now.
+  *
+  * 2004.03.31 Doug McLain <nostar@comcast.net>
+  *    Added support for Event Electronics EZ8 card to hoontech.c.
   */




--------------070707030901010609020809--



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
