From: Julia Lawall <julia@diku.dk>
Subject: Re: [PATCH 5/5] sound/aoa: Add kmalloc NULL tests
Date: Fri, 31 Jul 2009 08:32:03 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0907310831330.13462@ask.diku.dk>
References: <Pine.LNX.4.64.0907301610550.8734@ask.diku.dk>
 <1248963420.16129.0.camel@johannes.local> <Pine.LNX.4.64.0907301627260.8734@ask.diku.dk>
 <s5hws5pid6u.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752295AbZGaGcJ@vger.kernel.org>
In-Reply-To: <s5hws5pid6u.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Johannes Berg <johannes@sipsolutions.net>, linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Julia Lawall <julia@diku.dk>

Check that the result of kzalloc is not NULL before a dereference.

The semantic match that finds this problem is as follows:
(http://www.emn.fr/x-info/coccinelle/)

// <smpl>
@@
expression *x;
identifier f;
constant char *C;
@@

x = \(kmalloc\|kcalloc\|kzalloc\)(...);
... when != x == NULL
    when != x != NULL
    when != (x || ...)
(
kfree(x)
|
f(...,C,...,x,...)
|
*f(...,x,...)
|
*x->f
)
// </smpl>

Signed-off-by: Julia Lawall <julia@diku.dk>

---
 sound/aoa/core/gpio-pmf.c           |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/var/linuxes/linux-next/sound/aoa/core/gpio-pmf.c b/var/julia/linuxcopy/sound/aoa/core/gpio-pmf.c
index 5ca2220..1dd0c28 100644
--- a/var/linuxes/linux-next/sound/aoa/core/gpio-pmf.c
+++ b/var/julia/linuxcopy/sound/aoa/core/gpio-pmf.c
@@ -182,6 +182,10 @@ static int pmf_set_notify(struct gpio_runtime *rt,
 	if (!old && notify) {
 		irq_client = kzalloc(sizeof(struct pmf_irq_client),
 				     GFP_KERNEL);
+		if (!irq_client) {
+			err = -ENOMEM;
+			goto out_unlock;
+		}
 		irq_client->data = notif;
 		irq_client->handler = pmf_handle_notify_irq;
 		irq_client->owner = THIS_MODULE;
