From: Jussi Laako <jussi@sonarnerd.net>
Subject: [PATCH] More generic way to detect DSD capabilities
Date: Wed, 13 Jun 2018 01:43:00 +0300
Message-ID: <1528843382-15206-1-git-send-email-jussi@sonarnerd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.sonarnerd.net (rankki.sonarnerd.net [194.142.149.154])
 by alsa0.perex.cz (Postfix) with ESMTP id C43A926720C
 for <alsa-devel@alsa-project.org>; Wed, 13 Jun 2018 00:43:21 +0200 (CEST)
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

There is a more generic way to detect DSD capability of popular UAC2
implementations. Advantage is that each new device with DSD capability
doesn't have to be explicitly listed through VID:PID.

XMOS/Thesycon implementation uses this method. As a safety precaution
I have still left VID detection in place. Many of the implementations
use XMOS' VID, but not all. I have moved over the devices that have
been tested with these patches. Likely more of at least XMOS VID ones
could be removed from the explicit list, but I opted for careful
approach.
