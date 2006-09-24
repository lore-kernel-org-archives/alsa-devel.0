From: NosyMan <nosyman@gmail.com>
Subject: snd-bt87x Unknown card
Date: Sun, 24 Sep 2006 15:19:27 +0300
Message-ID: <200609241519.27873.nosyman@gmail.com>
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

Hi there,

I tried to use the snd-bt87x module with my TV Tunner (bttv: Typhoon TView RDS 
+ FM 
Stereo / KNC1 TV Station RDS [card=53] ):

lspci output:
01:0a.0 Multimedia video controller: Brooktree Corporation Bt878 Video Capture 
(rev 11)
01:0a.1 Multimedia controller: Brooktree Corporation Bt878 Audio Capture (rev 
11)

module loading output:
bt87x.c:845: unknown card 0x878-0x00:0x00, using default rate 32000
bt87x.c:848: please mail id, board name, and, if it works, the correct 
digital_rate option to <alsa-devel@lists.sf.net>

The modules refuses to load unless the load_all=1 option is passed.

I'm not an audio freak and I don't know how to use this device. There is only 
a 'capture' feature on my mixer.  Some help will be appreciated. 

Thanks,
NosyMan

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
