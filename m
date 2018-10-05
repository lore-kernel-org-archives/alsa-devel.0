From: Jussi Laako <jussi@sonarnerd.net>
Subject: [PATCH v3 0/1] ALSA: usb-audio: Add custom mixer
	status quirks for RME CC devices
Date: Fri,  5 Oct 2018 10:01:29 +0300
Message-ID: <20181005070130.7639-1-jussi@sonarnerd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.sonarnerd.net (rankki.sonarnerd.net [194.142.149.154])
 by alsa0.perex.cz (Postfix) with ESMTP id 94C4C2677F0
 for <alsa-devel@alsa-project.org>; Fri,  5 Oct 2018 09:01:35 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Here are the requested updates. I have kept the locking separate from
the helper, because in frequency calculation result depends on both
values. I can move locking to the helper too if necessary, but I thought
it would be logically cleaner this way...
