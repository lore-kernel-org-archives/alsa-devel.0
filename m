From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH RFC 0/7] Allow multiple callbacks for hda_jack
Date: Thu, 11 Sep 2014 16:19:10 +0200
Message-ID: <1410445157-23198-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id C8FE52656DE
 for <alsa-devel@alsa-project.org>; Thu, 11 Sep 2014 16:19:20 +0200 (CEST)
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
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Hi,

this is a series of patches I quickly cooked up after the discussion
in this morning: the support of multiple callbacks per jack.

The series is applied on top of the previous fix patch (ALSA: hda -
Fix invalid pin powermap without jack detection).  It begins with
a couple of cleanups, then introduces the new hda_jack_callback
struct and the changes along with it, then ends with another
couple of cleanup patches based on the new infrastructure.

I've tested only with a small set of devices, so far.


Takashi
