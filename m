From: Riccardo Tempesta <info@riccardotempesta.com>
Subject: More than 8 soundcards
Date: Thu, 06 Apr 2006 21:31:25 +0200
Message-ID: <44356C8D.1010402@riccardotempesta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
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

I'm trying to use more than 8 soundcards with ALSA.

I've seen the following line in "driver.h"
#define SNDRV_CARDS 8 /* number of supported soundcards - don't change - 
minor numbers */

What does "don't change - minor numbers" mean?

I tried to increase it to 16 and I can see new /proc/asound/cardX 
folders, but no /dev/dspX devices.

Any help will be appreciated.
Thank you in advantage.

Riccardo.


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
