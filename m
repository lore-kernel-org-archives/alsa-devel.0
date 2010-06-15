From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH RFC 2/3] input: wm97xx: set GPIOs with AC97
	GPIO busops if implemented
Date: Tue, 15 Jun 2010 17:55:46 +0200
Message-ID: <1276617347-3522-3-git-send-email-manuel.lauss__30873.3951337219$1276617392$gmane$org@googlemail.com>
References: <1276617347-3522-1-git-send-email-manuel.lauss@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1276617347-3522-1-git-send-email-manuel.lauss@googlemail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Manuel Lauss <manuel.lauss@googlemail.com>, linux-input@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

If the AC97 controller implements the ->setgpio callback, use it.
Some codecs (i.e. WM9712) only accept GPIO data through AC97 slot 12.

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
 drivers/input/touchscreen/wm97xx-core.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/drivers/input/touchscreen/wm97xx-core.c b/drivers/input/touchscreen/wm97xx-core.c
index cbfef1e..4f7b38c 100644
--- a/drivers/input/touchscreen/wm97xx-core.c
+++ b/drivers/input/touchscreen/wm97xx-core.c
@@ -206,7 +206,10 @@ void wm97xx_set_gpio(struct wm97xx *wm, u32 gpio,
 		reg &= ~gpio;
 
 	if (wm->id == WM9712_ID2 && wm->variant != WM97xx_WM1613)
-		wm97xx_reg_write(wm, AC97_GPIO_STATUS, reg << 1);
+		reg <<= 1;
+
+	if (wm->ac97->bus->ops->setgpio)
+		wm->ac97->bus->ops->setgpio(wm->ac97, reg);
 	else
 		wm97xx_reg_write(wm, AC97_GPIO_STATUS, reg);
 	mutex_unlock(&wm->codec_mutex);
-- 
1.7.1

