From: Ralf Haller <ralf@brap.de>
Subject: ISA plug and play with alsa 0.9.3a
Date: Thu, 08 May 2003 15:11:23 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3EBA577B.4050409@brap.de>
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello,

I am using a Phillips PCA721AF PnP sound card (snd-opti92x-ad1848) which 
worked great with alsa 0.9.0rc7 and kernel 2.4.19.

I updated to kernel 2.4.20 and installed alsa 0.9.3a. The ISA plug and 
play configuration didn't work anymore. When running alsaconf the 
correct sound card was found, however when starting alsa the sound card 
could not be found. I downgraded to alsa 0.9.0rc and the sound card was 
successfully found and everything works fine.

Maybe there is a bug in 0.9.3a concerning plug and play configuration?

Ralf



-------------------------------------------------------
Enterprise Linux Forum Conference & Expo, June 4-6, 2003, Santa Clara
The only event dedicated to issues related to Linux enterprise solutions
www.enterpriselinuxforum.com
