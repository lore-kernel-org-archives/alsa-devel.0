From: Niklas Werner <bergtroll@gmx.li>
Subject: USB-Audio strangeness
Date: Sat, 22 Mar 2003 14:03:53 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E7C5F39.4050003@gmx.li>
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
To: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi List!

I am just wondering whether anybody has a solution for following 
(admittedly minor) bug:

When I cold-boot (doesn't matter whether PPC or Intel) with my emi 2|6 
or reconnect the device the range of the mixer always is set to 0-50% 
while using the full range in the hardware. So 50% mixer-value is 100% 
volume.
If the emi already has its firmware when booting (ie warm reboot), the 
mixer settings are right.
when using the oss- audio-module this doesn't happen.

I am using newest cvs-alsa (from yesterday) on Gentoo-1.4, SuSE-7.3 or 
debian-sarge (all the same).

Thanks

Niklas





-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
