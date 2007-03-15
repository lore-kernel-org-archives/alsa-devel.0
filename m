From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: [RFC] Sign offs for alsa-driver -> alsa-kernel derived
	works.
Date: Thu, 15 Mar 2007 17:30:20 +0000
Message-ID: <1173979821.27299.182.camel@batley.wolfsonmicro.main>
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
Cc: Giorgio Padrin <giorgio@mandarinlogiq.org>, Richard Purdie <rpurdie@rpsys.net>
List-Id: alsa-devel@alsa-project.org

I'd like to gather some clarification wrt sign offs for alsa-driver to
alsa-kernel derived works.

Example in case: alsa-driver:i2c/uda1380.c was extensively modified to
become alsa-kernel:soc/codecs/uda1380.c

I submitted the derived driver with sign-off from 3 developers who had
worked on the derived work (Richard Purdie, Philipp Zabel and myself)
and the original alsa-driver:uda1380.c author (Giorgio Padrin) who was
not involved in creating the derived work.

I included Giorgio in the sign-off for the following reasons :-

1. There are sections of his original (non alsa-kernel) code and
algorithms within the derived work. This was to certify the origins of
*all* the code and algorithms within the derived driver as the original
driver only existed within alsa-driver and hence none of it's code had
been signed-off into the kernel.

Iirc, sign-off from Giorgio would not have been required if the original
driver was already part of the kernel. 

2. To give credit to where credit was due.


Takashi, Jaroslav, could you guys clarify the sign-off relationship
between alsa-driver -> alsa-kernel (inc derived works). I assume
original work from alsa-driver can be pushed into alsa-kernel due to
it's original sign-off ?

If original author sign-off is not required for this situation, I can
resubmit the code.

Many thanks

Liam



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
