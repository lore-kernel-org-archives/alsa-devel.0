From: Alex Riesen <raa.lkml@gmail.com>
Subject: Fwd: regression: from 3.8 to 3.9: headphones output no
 sound on Intel HDA, codec VIA VT1802
Date: Sun, 12 May 2013 11:58:09 +0200
Message-ID: <CALxABCY+kS_oNmQjN4iWDEpLotnT9s3Y2O2Bkpi3VM07+d255g@mail.gmail.com>
References: <CALxABCbP9hkNQ=xTEUMWb+6UhmVs2N-5kauYJe7d=j1z_RL+LA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oa0-f45.google.com (mail-oa0-f45.google.com
 [209.85.219.45])
 by alsa0.perex.cz (Postfix) with ESMTP id E2DC02615DC
 for <alsa-devel@alsa-project.org>; Sun, 12 May 2013 11:58:30 +0200 (CEST)
Received: by mail-oa0-f45.google.com with SMTP id j6so5352493oag.4
 for <alsa-devel@alsa-project.org>; Sun, 12 May 2013 02:58:30 -0700 (PDT)
In-Reply-To: <CALxABCbP9hkNQ=xTEUMWb+6UhmVs2N-5kauYJe7d=j1z_RL+LA@mail.gmail.com>
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

The original message is being held hostage by moderator approval.
The attachments (alsa-info output) can be found here:

  http://marc.info/?l=linux-kernel&m=136835246706699&w=2

---------- Forwarded message ----------

Hi,

I just noticed (use the headphones rarely) that the headphones on this
System76 Lemur Ultra (lemu4) stopped working. There is absolutely no
output.

I tried reverting all changes to patch_via.c since v3.8, and
have the sound back, but there wasn't much to revert:

Revert "ALSA: hda - Rearrange INPUT_PIN_ATTR_*"
Revert "ALSA: hda - Use generic parser for VIA codec driver"
Revert "ALSA: hda - Enable parsing the independent HP mode as default
for VIA codecs"
Revert "ALSA: hda/via - Fix wrong checks of power state bits"
Revert "ALSA: hda - Fix phantom jacks on VT1708"
Revert "ALSA: hda - detect jacks on VT1708 even when no streams are active"
Revert "ALSA: hda - Use generic array for loopback list management"

and one change (which I indeed suspect) is large: the use of generic parser.

The problem is also present in 3.10-rc1. The output of alsa-info.sh attached,
for 3.8.12 and 3.9.2 respectively.

Regards,
Alex Riesen
