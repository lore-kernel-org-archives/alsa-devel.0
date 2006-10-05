From: "Dmitry Baikov" <dsbaikov@gmail.com>
Subject: 1.0.13 and hdsp cardbus
Date: Thu, 5 Oct 2006 16:41:55 +0400
Message-ID: <70a871c80610050541r73bbc2d7j408595802bb2c43f@mail.gmail.com>
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello again!
Another problem.

kernel: linux-2.6.18-gentoo
arch: x86, amd64
alsa: 1.0.13

Steps to reproduce:

1) boot or plug hdsp cardbus with multiface box switched off
2) switch multiface on
3) run hdsploader: Input/output error
4) remove cardbus
5) insert cardbus again
6) FREEZE.

alsa-1.0.11 worked ok (hdsploader gave IO error also, but cardbus
reinsertion curied the problem).

Dmitry.

P.S. please CC me in your replies.

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
