From: Doug <nostar@comcast.net>
Subject: Re: EZ8 ADAT I/O card (ICE1712 chipset)
Date: Thu, 05 Feb 2004 03:50:30 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <402203D6.3030308@comcast.net>
References: <401A62AD.2050302@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <401A62AD.2050302@comcast.net>
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

Here is what I have done to the ice1712.c file in order to add support 
for my EZ8 card.  It's a temporary hack (emphesis on 'hack') until I add 
code to reliably identify the ez8 from the hoontech (both cards share 
the same subvendorid).

/* EZ8 Hack */
int ez8=0;
MODULE_PARM(ez8, "i");

I added this at the end of all ofthe MODULE_PARM() definitions.

On line 2505, I made this change:

for (tbl = card_tables+(ez8 ? 1 : 0); *tbl; tbl++) { /* EZ8 Hack */

Just a quick and dirty way to skip over the hoontech card_table entry so 
that my EZ8 is recognized as a generic device, while still correctly 
detecting my Delta 1010LT card when ez8=1 is added as argument to the 
snd-ice1712 module.  Module functions normally if ez8 is not added to 
command line (or is set to 0).  This would not work if an ez8 and 
hoontech were used together.

This, of course, is only a temporary fix for my own use, while I work on 
code to correctly differentiate between the ez8 and the hoontech card. 
In addition, there are a few EZ8 specific features that don't seem to be 
implemented with the generic driver.  Since ADAT is fully functional, 
though, I now will spend much more time using the card/driver (with 
ardour/jack) and less finishing support.  I don't think there will be 
any objection here, since I think I am the only linux using EZ8/EZBus 
owner on the planet :)

Does anyone have the ICE1712 chip documentation?  How were the drivers 
for the other ice1712 based cards written?  Were the manufacturers 
contacted and data released under some sort of non-disclosure agreement? 
   I dont get why documentation for a chip is kept so secretive, I mean 
rtl8xxx ethernet tranceiver chip docs, for example, are all over the 
place, that seems like the same thing to me.  I would really like to 
have the documetation so that I can study the ice1712 driver line by 
line and understand what exactly is being done on-board the chip.  I 
just like that kind of stuff, I know there is enough info in the 
existing source for the other cards to figure out how to implement my needs.

-- 
http://nostar.isa-geek.com/



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
