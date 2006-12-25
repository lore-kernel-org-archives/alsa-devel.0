From: Stelios Valavanis <stel@onshore.com>
Subject: alsa card id for ati tvwonder ve
Date: Mon, 25 Dec 2006 17:58:26 -0600
Message-ID: <200612251758.26293.stel@onshore.com>
Reply-To: stel@onshore.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

looks like this card can show up as an alsa audio device with the load_all=1 
setting on but it doesn't push audio out the interface. regardless the card 
info is as follows.

driver = snd-bt87x
card = ATI TVWonderVE
ID = 0x31002

i'm not sure i got the id right. this is what dmesg reported.

[17179584.764000] bt878_probe: card id=[0x31002], Unknown card.
[17179585.360000] unknown card 0x878-0x1002:0x03, using default rate 32000

-- 
_______________________________________
stel valavanis  http://www.onshore.com/

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
