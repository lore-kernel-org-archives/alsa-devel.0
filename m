From: Lawrie Abbott <lawrieabbott@iinet.net.au>
Subject: 2.5.64 & ice1712
Date: Sun, 16 Mar 2003 06:25:07 +0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E73A843.5050203@iinet.net.au>
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

Hi
I've just been trying out a 2.5.64 kernel and had a problem during 
compile with ice1712.
An error is reported at Line 1995 of ice1712.c, (currently reads)
static snd_kcontrol_new_t snd_ice1712_pro_internal_clock = __devinitdata {
Should it be?
static snd_kcontrol_new_t snd_ice1712_pro_internal_clock __devinitdata = {
Which enables compile to be succesfully completed

Lawrie



-------------------------------------------------------
This SF.net email is sponsored by:Crypto Challenge is now open! 
Get cracking and register here for some mind boggling fun and 
the chance of winning an Apple iPod:
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0031en
