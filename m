From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Programming the unknow P16v chip on the Audigy2
Date: Fri, 28 May 2004 19:49:59 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40B789D7.8060704@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

The Audigy2 has lots of registers for the emu10k2 chip.
These are accessed by programming
#define PTR 0x00  /* Indexed register set pointer register        */
                   /* NOTE: The CHANNELNUM and ADDRESS words can   */
                   /* be modified independently of each other.     */
#define DATA 0x04 /* Indexed register set data register           */

Basically, one writes the register address to PTR, and then read or 
write to DATA.

On the Audigy2 there is a similar setup for 0x20 and 0x24. I suspect 
that this is used to program the p16v chip.

Had anyone looked into those registers, and tried to guess what they do ?

I might give it a go, once I finish the Audigy LS driver.

Cheers
James


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
