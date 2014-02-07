From: Jean-Francois Moine <moinejf@free.fr>
Subject: [PATCH RFC 1/2] drivers/base: permit base components to omit the
	bind/unbind ops
Date: Fri, 7 Feb 2014 16:55:00 +0100
Message-ID: <9b3c3c2c982f31b026fd1516a2b608026d55b1e9.1391793068.git.moinejf@free.fr>
References: <cover.1391793068.git.moinejf@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <dri-devel-bounces@lists.freedesktop.org>
In-Reply-To: <cover.1391793068.git.moinejf@free.fr>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/dri-devel>,
	<mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: dri-devel-bounces@lists.freedesktop.org
Errors-To: dri-devel-bounces@lists.freedesktop.org
To: Russell King <rmk+kernel@arm.linux.org.uk>, devel@driverdev.osuosl.org
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, dri-devel@lists.freedesktop.org, Sascha Hauer <kernel@pengutronix.de>, linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Some simple components don't need to do any specific action on
bind to / unbind from a master component.

This patch permits such components to omit the bind/unbind
operations.

Signed-off-by: Jean-Francois Moine <moinejf@free.fr>
---
 drivers/base/component.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/base/component.c b/drivers/base/component.c
index c53efe6..0a39d7a 100644
--- a/drivers/base/component.c
+++ b/drivers/base/component.c
@@ -225,7 +225,8 @@ static void component_unbind(struct component *component,
 {
 	WARN_ON(!component->bound);
 
-	component->ops->unbind(component->dev, master->dev, data);
+	if (component->ops)
+		component->ops->unbind(component->dev, master->dev, data);
 	component->bound = false;
 
 	/* Release all resources claimed in the binding of this component */
@@ -274,7 +275,11 @@ static int component_bind(struct component *component, struct master *master,
 	dev_dbg(master->dev, "binding %s (ops %ps)\n",
 		dev_name(component->dev), component->ops);
 
-	ret = component->ops->bind(component->dev, master->dev, data);
+	if (component->ops)
+		ret = component->ops->bind(component->dev, master->dev, data);
+	else
+		ret = 0;
+
 	if (!ret) {
 		component->bound = true;
 
-- 
1.9.rc1
