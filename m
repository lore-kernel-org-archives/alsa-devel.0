From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 000/102 - chunk#3] Actually fix wrong enum items
Date: Tue, 18 Feb 2014 12:36:51 +0100
Message-ID: <1392723422-12689-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 2F4A6265558
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 12:37:06 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Now, this patch chunk fixes the actual bugs in various codec drivers
that have either off-by-one number of items or lead to array overflow.

sta32x is the latter one, and this can be picked up for 3.14, too.

The other off-by-one fixes would change the driver behavior (now user
will see more items), thus they are potential regression risks
although the "fixes" are correct, per se.


Takashi
