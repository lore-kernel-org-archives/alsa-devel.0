From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: /usr/share/alsa conf files. How to restrict certain rates.
Date: Thu, 28 Aug 2003 22:06:04 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F4E6EBC.7060109@superbug.demon.co.uk>
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
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,

With the addition of AC3 passthru to the Audigy driver, we need a way to 
restrict it to only work at 48000 Hz.

Is there something we can put in the Audigy.conf file that will force 
any device opened with iec958:xxxx to only allow 48Khz ?

The reason for this, is that AC3 passthru only works at 48Khz when doing 
passthru, but other speeds are ok when doing PCM.

Cheers
James



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
