From: "Erik Welander" <erikwelander@hotmail.com>
Subject: Verification Request for Filter Divider calculation; ES18XX.c
Date: Wed, 12 Mar 2003 18:25:09 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <BAY1-F199ap7p8bVPZu00035e16@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

I am looking into the ES18XX driver for my ES1878.

Now, I get static when using only the second DMA channel, as dma1=5, dma2=5, 
and no other errors. (The firstDMA channel does not work at all…) My 
investigation points to that there may be problems in the sample rate/filter 
divider calculations.

Could any knowledgeable person verify if this calculation incorrect or not:

/* set filter register */
div0 = 256 - 7160000*20/(8*82*runtime->rate);

Here is the text outlining the procedure from the Datasheet for ES1878:

This register controls the low-pass frequency of the switchcapacitor
filters inside the ES1878. Generally, the filter rolloff
should be positioned at 80% - 90% of the Sample_Rate/
2 frequency. The ratio of the roll-off frequency to the filter
clock frequency is 1:82. In other words, first determine the
desired roll-off frequency by taking 80% of the
Sample_Rate divided by 2, then multiply by 82 to find the
desired Filter Clock frequency. Use the formula below to
determine the closest divider:
Filter_Clock_Frequency = 7.16 MHz / (256-Filter_Divider_Register)

Regards From Erik

_________________________________________________________________
Tired of spam? Get advanced junk mail protection with MSN 8. 
http://join.msn.com/?page=features/junkmail



-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
