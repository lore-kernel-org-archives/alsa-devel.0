From: John Dey <jsdey@optonline.net>
Subject: Running sound on the Cell Broadband Engine
Date: Thu, 22 Feb 2007 11:42:03 -0500
Message-ID: <5c229ded23bd290380160e9d7e0cd769@optonline.net>
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
To: Alsa Dev <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi List,

I have taken the program midiFMsynth.c written by Dr. Nagorni and built
it on two machines: a PS3/YDL and another AMD64 (processing speed 2ghz)
host (2.6.18-1.2200.fc5).  I calculated the running time (in
microseconds)  for the program that performs the pcm calculation and
got some interesting (although discouraging) results.  I ran the
program two ways: with and without the call to snd_pcm_writei.  The
results were:

PS3:  with sound 11501 us;  without sound 1200 us
AMD64: with sound 379 us; without sound 280 us

Is there anyone that can shed light on the differences.  I would have 
expected similar results from both systems. Thanks.

John Dey



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
