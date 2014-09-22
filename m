From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH 0/5] hda-emu: Add more stuff in hda-spec
Date: Mon, 22 Sep 2014 13:09:01 +0200
Message-ID: <1411384146-23286-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 674D726525F
 for <alsa-devel@alsa-project.org>; Mon, 22 Sep 2014 13:09:10 +0200 (CEST)
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
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

After the recent addition of more codecs, the journey towards 0 errors
starts over. Here we work around the latest secret stuff the vendors
decided to add.

In particular, it would be interesting to have a little more info on the
secret IDT EQ verbs, which I just labelled "set_eq_*".

David Henningsson (5):
  hda-spec: Add fixups for Haswell/Broadwell HDMI
  hda-spec: Add access to secret node 0x8 for Haswell/Broadwell HDMI
  hda-spec: Add more secret nodes for Realtek codecs
  hda-spec: Add secret eq verbs for IDT
  hda-spec: Add IDT 92HD95 to IDT verb codec list

 hda-spec.c | 93 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 85 insertions(+), 8 deletions(-)

-- 
1.9.1
