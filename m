From: "Ash Willis" <ashwillis@programmer.net>
Subject: ALS300 Driver....kinda
Date: Mon, 19 Jul 2004 18:58:31 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040719235831.B509579004D@ws1-14.us4.outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

Hi people, I had this Avance Logic ALS300 card kicking about and I thought I'd make an attempt at writing a driver for it. I know this isn't too interesting though as this card is quite old now and I can't imagine it being too popular but I wanted to do this driver becuase it'd make ALSA that tiny bit more 'complete', and OSS supports it so it'd just generally be nice for it to work with ALSA...

I WAS reversing it but then the lovely people at Realtek sent me the sheet.

Anyway, I've done some work on this, but if I'm honest, I'm a noob to ALSA and to hardware programming in general. I've hit a bit of a wall and I need some help.

I've only been focusing on PCM playback for the moment and the driver is in such a state that it will allow the first dma transfer to take place but then when servicing interrupts, no further writes to dma take place, so the card just sits there playing a small sample over and over...

So yeah, i'm opening this up to anyone who wants to help. It seems a waste for me to be messing around trying to fix this when someone else could probably fix it up in a few minutes :)

I have my (very) partially working code and the datasheet to show anyone who is interested. If no-one else has this card then I'd be happy to test any hacks anyone wants to try. It may just be the case that i have an obvious mess up in my code that anyone used to this stuff would spot. I don't have the code or the sheet on me right now but i can post/email any info anyone wants in the next couple of days.

Thanks,
Ash Willis
-- 
___________________________________________________________
Sign-up for Ads Free at Mail.com
http://promo.mail.com/adsfreejump.htm




-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
