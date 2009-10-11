From: David Henningsson <launchpad.web@epost.diwic.se>
Subject: [PATCH 1/1] ALSA: ice1724 - Make call to set hw params
 succeed on ESI Juli@
Date: Sun, 11 Oct 2009 11:37:22 +0200
Message-ID: <4AD1A752.3010703@epost.diwic.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch-smtp03.sth.basefarm.net (ch-smtp03.sth.basefarm.net
	[80.76.149.214])
	by alsa0.perex.cz (Postfix) with ESMTP id 3D10B1037EE
	for <alsa-devel@alsa-project.org>;
	Sun, 11 Oct 2009 11:37:39 +0200 (CEST)
Received: from c83-254-137-104.bredband.comhem.se ([83.254.137.104]:54521
	helo=[192.168.0.157])
	by ch-smtp03.sth.basefarm.net with esmtp (Exim 4.68)
	(envelope-from <launchpad.web@epost.diwic.se>) id 1Mwurj-00042W-BM
	for alsa-devel@alsa-project.org; Sun, 11 Oct 2009 11:37:25 +0200
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
List-Id: alsa-devel@alsa-project.org

From: David Henningsson <launchpad.web@epost.diwic.se>

If two streams are started immediately after one another (such as a playback and a recording stream),
the call to set hw params fails with EBUSY. This patch makes the call succeed, so playback and
recording will work properly.

Signed-off-by: David Henningsson <launchpad.web@epost.diwic.se>
---

  sound/pci/ice1712/ice1724.c |    2 +-
  1 file changed, 1 insertion(+), 1 deletion(-)

* This is likely a regression since 2009-06-05, commit 92d71005e2f305d6dca126d8b8497e885b842dba.

* Tested on ESI Juli@.

* Affected bugs: https://bugs.launchpad.net/ubuntu/+source/linux/+bug/441446
   Probably this one as well: https://bugzilla.redhat.com/show_bug.cgi?id=525595

---
diff --git a/sound/pci/ice1712/ice1724.c b/sound/pci/ice1712/ice1724.c
index cc84a83..56d1bd8 100644
--- a/sound/pci/ice1712/ice1724.c
+++ b/sound/pci/ice1712/ice1724.c
@@ -643,7 +643,7 @@ static int snd_vt1724_set_pro_rate(struct snd_ice1712 *ice, unsigned int rate,
             (inb(ICEMT1724(ice, DMA_PAUSE)) & DMA_PAUSES)) {
                 /* running? we cannot change the rate now... */
                 spin_unlock_irqrestore(&ice->reg_lock, flags);
-               return -EBUSY;
+               return ((rate == ice->cur_rate) && !force) ? 0 : -EBUSY;
         }
         if (!force && is_pro_rate_locked(ice)) {
                 spin_unlock_irqrestore(&ice->reg_lock, flags);
