From: Doug <nostar@comcast.net>
Subject: Re: EZ8 ADAT I/O card (ICE1712 chipset)
Date: Thu, 05 Feb 2004 15:41:53 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <4022AA91.6080706@comcast.net>
References: <401A62AD.2050302@comcast.net>	<402203D6.3030308@comcast.net> <s5hisilah4g.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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
> 
> i'd suggest to check ez8 option in hoontech.c rather than in the
> ice1712.c routine.
> 

Good advice, but after I reealized the chip docs were right there on the 
alsa ftp the whole time, I went ahead and decided to do it right.  I put 
ice1712.c back to its original state, adding a new struct 
snd_ice1712_card_info called snd_ice1712_event_cards, and 
MODULE_DEVICES, etc.  I created an event.c (and .h) and will add support 
following suit with hoontech.c and friends.  Now, armed with the chip 
specs, I will find a way to uniquely identify the ez8 card, and tailor 
the driver to its features.  I'll post the results when finished (or stuck).

Thanks for the info!


-- 
http://nostar.isa-geek.com/



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
