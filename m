From: Sampo Savolainen <v2@iki.fi>
Subject: Intel HDA recording
Date: Thu, 21 Sep 2006 20:14:49 +0300
Message-ID: <1158858889.6991.31.camel@mustis>
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

Hi,

I understand there has been some discussion about the hda-intel driver
with jackd. I have a new laptop and I ran into similar issues: jackd
doesn't start in full-duplex mode.

But I think I figured out what's wrong with the driver. The driver
doesn't give any samples to applications capturing with it if the
"Capture" element in the mixer is not enabled for capturing.

Everything, including jackd works well when the element is enabled for
capturing (i used the terminal program alsamixer to test this). If it
isn't enabled even arecord doesn't work.

(tested on 2.6.17.13 and alsa 1.0.13rc2)


 Sampo Savolainen


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
