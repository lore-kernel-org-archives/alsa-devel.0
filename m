From: Simon Lewis <simon.lewis@mnet-online.de>
Subject: pcm_multi broken in alsa-lib - no duplex mode with
	jackd
Date: Thu, 08 Mar 2007 18:17:30 +0100
Message-ID: <45F0452A.40205@mnet-online.de>
Reply-To: simon.lewis@mnet-online.de
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Dear ALSA Developers

When I attempted to combine several device drivers using the pcm_multi
function in .asound.conf I learned the hardway that pcm_multi doesn't
work in duplex mode with jackd. Apparently pcm_multi was broken in
alsa-lib 1.0.9rc1 and has never been fixed.

Many JACK users have successfully used the following patch:

http://www.sound-man.co.uk/linuxaudio/pcm_multi-patch

I have since learned that many studio64 users have been bitten by this bug.

Please, please, please add the above patch to version 1.014 of ALSA libs
before they are finally released as stable.


With many thanks, Simon.



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
