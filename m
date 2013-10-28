From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 0/6] Small fixes for bugs Coverity reported
Date: Mon, 28 Oct 2013 14:14:04 +0100
Message-ID: <1382966050-12752-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 6DE82261640
 for <alsa-devel@alsa-project.org>; Mon, 28 Oct 2013 14:11:34 +0100 (CET)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id A5E0BA5D7C
 for <alsa-devel@alsa-project.org>; Mon, 28 Oct 2013 14:11:31 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

here is a series of small fixes for bugs reported by Coverity.
The first one for 6fire is a real bad one, but I guess it hits little
users just because of the number of users for such cases.

Others are just minor fixes and code improvements in HD-audio and core
codes.


Takashi
