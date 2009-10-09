From: David Henningsson <launchpad.web@epost.diwic.se>
Subject: PATCH: ESI Juli@ fails to set sample rate
Date: Fri, 09 Oct 2009 21:29:55 +0200
Message-ID: <4ACF8F33.7020800@epost.diwic.se>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020402080806010206000208"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ch-smtp01.sth.basefarm.net (ch-smtp01.sth.basefarm.net
	[80.76.149.212])
	by alsa0.perex.cz (Postfix) with ESMTP id 56869103A78
	for <alsa-devel@alsa-project.org>;
	Fri,  9 Oct 2009 21:30:36 +0200 (CEST)
Received: from c83-254-137-104.bredband.comhem.se ([83.254.137.104]:59063
	helo=[192.168.0.157])
	by ch-smtp01.sth.basefarm.net with esmtp (Exim 4.68)
	(envelope-from <launchpad.web@epost.diwic.se>) id 1MwLA4-0005kB-55
	for alsa-devel@alsa-project.org; Fri, 09 Oct 2009 21:29:58 +0200
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

This is a multi-part message in MIME format.
--------------020402080806010206000208
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This one-line patch fixes bug 
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/441446
and is likely to fix bug https://bugzilla.redhat.com/show_bug.cgi?id=525595
as well.

The problem for me is that if two streams are started immediately after 
one another (such as a playback and a recording stream, e g pulseaudio 
does that on startup), the call to hw_params fail with EBUSY. This patch 
makes the call succeed, and playback and recording works.

I do not have any other ice1724 soundcard than the ESI Juli@ so I don't 
know if/how this patch will affect them.

// David

--------------020402080806010206000208
Content-Type: text/x-patch;
 name="ice1724-hwparams-fail.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ice1724-hwparams-fail.patch"

diff --git a/sound/pci/ice1712/ice1724.c b/sound/pci/ice1712/ice1724.c
index cc84a83..56d1bd8 100644
--- a/sound/pci/ice1712/ice1724.c
+++ b/sound/pci/ice1712/ice1724.c
@@ -643,7 +643,7 @@ static int snd_vt1724_set_pro_rate(struct snd_ice1712 *ice, unsigned int rate,
 	    (inb(ICEMT1724(ice, DMA_PAUSE)) & DMA_PAUSES)) {
 		/* running? we cannot change the rate now... */
 		spin_unlock_irqrestore(&ice->reg_lock, flags);
-		return -EBUSY;
+		return ((rate == ice->cur_rate) && !force) ? 0 : -EBUSY;
 	}
 	if (!force && is_pro_rate_locked(ice)) {
 		spin_unlock_irqrestore(&ice->reg_lock, flags);

--------------020402080806010206000208
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------020402080806010206000208--
