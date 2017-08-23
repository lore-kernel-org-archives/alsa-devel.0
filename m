From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] ALSA: ctxfi: make hw structures const
Date: Wed, 23 Aug 2017 17:58:42 +0530
Message-ID: <1503491322-32332-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: julia.lawall@lip6.fr, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: alsa-devel@alsa-project.org

Make these const as they are only used in a copy operation.
Done using Coccinelle:

@match disable optional_qualifier@
identifier s;
@@
static struct hw s = {...};

@ref@
position p;
identifier match.s;
@@
s@p

@good1@
position ref.p;
identifier match.s,f,c;
expression e;
@@
(
e = s@p
|
e = s@p.f
|
c(...,s@p.f,...)
|
c(...,s@p,...)
)

@bad depends on  !good1@
position ref.p;
identifier match.s;
@@
s@p

@depends on forall !bad disable optional_qualifier@
identifier match.s;
@@
static
+ const
struct hw s;

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 sound/pci/ctxfi/cthw20k1.c | 2 +-
 sound/pci/ctxfi/cthw20k2.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/pci/ctxfi/cthw20k1.c b/sound/pci/ctxfi/cthw20k1.c
index 79edd88..8e6eb9d 100644
--- a/sound/pci/ctxfi/cthw20k1.c
+++ b/sound/pci/ctxfi/cthw20k1.c
@@ -2154,7 +2154,7 @@ static void hw_write_pci(struct hw *hw, u32 reg, u32 data)
 		&container_of(hw, struct hw20k1, hw)->reg_pci_lock, flags);
 }
 
-static struct hw ct20k1_preset = {
+static const struct hw ct20k1_preset = {
 	.irq = -1,
 
 	.card_init = hw_card_init,
diff --git a/sound/pci/ctxfi/cthw20k2.c b/sound/pci/ctxfi/cthw20k2.c
index 18ee776..b866d6b 100644
--- a/sound/pci/ctxfi/cthw20k2.c
+++ b/sound/pci/ctxfi/cthw20k2.c
@@ -2220,7 +2220,7 @@ static void hw_write_20kx(struct hw *hw, u32 reg, u32 data)
 	writel(data, hw->mem_base + reg);
 }
 
-static struct hw ct20k2_preset = {
+static const struct hw ct20k2_preset = {
 	.irq = -1,
 
 	.card_init = hw_card_init,
-- 
1.9.1
