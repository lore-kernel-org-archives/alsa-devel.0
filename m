From: andrea <andrea@dottout.com>
Subject: snd-hda-intel model missing
Date: Wed, 27 Dec 2006 22:55:39 +0100
Message-ID: <4592EBDB.7060707@dottout.com>
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

Hi, the driver snd-hda-intel does not have a right 'model' for my card:
lspci|grep Audio
00:1b.0 Audio device: Intel Corporation 82801G (ICH7 Family) High
Definition Audio Controller (rev 02)
lspci -nv |grep 1b    
00:1b.0 0403: 8086:27d8 (rev 02)
on a fujitsu pi1536
in order to have everything working, in particoular pc speaker, I have
to load model 5stack-digout, but alsamixer's sliders are too many for my
card's feature and the names are wrong. e.g.: the main speaker is
managed by 'side' slider.
this happens with 1.0.14rc1 alsa-driver and with older version, with
kernel 2.6.19.1 and older ones

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
