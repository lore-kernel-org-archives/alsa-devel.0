From: Tommi Kyntola <tommi.kyntola@ray.fi>
Subject: [RFC][PATCH] intel8x0: revert regression that broke
 sounds after S3 suspend
Date: Wed, 28 Feb 2007 16:09:49 +0200
Message-ID: <45E58D2D.6010308@ray.fi>
Reply-To: tommi.kyntola@ray.fi
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
To: linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


The regression in 2.6.19-rc3 (namely 30b35399ceb2398d05837863476dcb12f12f3a82,
"[ALSA] Various fixes for suspend/resume of ALSA PCI drivers"),
broke HP nw8000 speaker sounds after S3 suspend (headphones still worked).
Removing this line makes the sounds work again...

Signed-off-by: Tommi Kyntola <tommi.kyntola@ray.fi>
---
This is a FYI kinda message, which Rafael Wysocki asekd me to send,
and something that is clearly not the correct way to go with this,
but I was unable to locate the actual reason for the regression
and this does fix it for me, so here it goes.

Wether other devices suffer from this or not, I don't know. I was only
able test this on an HP nw8000, which has the said intel8x0.

I'll gladly try out further patches or submit configs, or whatever
more verbose information is asked for.
         Kynde

diff --git a/sound/pci/intel8x0.c b/sound/pci/intel8x0.c
index a289abf..f62a456 100644
--- a/sound/pci/intel8x0.c
+++ b/sound/pci/intel8x0.c
@@ -2470,7 +2470,6 @@ static int intel8x0_suspend(struct pci_dev *pci, pm_message_t state)
         }
         pci_disable_device(pci);
         pci_save_state(pci);
-       pci_set_power_state(pci, pci_choose_state(pci, state));
         return 0;
  }



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
