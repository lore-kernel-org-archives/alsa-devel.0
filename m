From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Subject: [PATCH 0/5] ASoC codecs
Date: Mon, 02 Oct 2006 17:15:15 +0100
Message-ID: <1159805715.2382.108.camel@localhost.localdomain>
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
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

This patch series will add initial ASoC codec support for the WM8731,
WM8750 and WM9712 codecs. It also adds support for AC97 codecs through a
generic AC97 codec driver (this connects any ASoC AC97 controller driver
to the std alsa ac97 codec driver). These codec drivers were chosen as
they are all working well and have good machine support (Zaurus).

The ak4535, uda1380, wm8753 and wm9713 ASoC codec drivers are all beta
quality atm and will hopefully be submitted soon, after some further
testing.

Liam






-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
