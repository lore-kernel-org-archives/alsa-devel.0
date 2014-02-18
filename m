From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 000/105] Rename soc_enum.max field
Date: Tue, 18 Feb 2014 12:29:24 +0100
Message-ID: <1392722967-12472-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 26FA326516D
 for <alsa-devel@alsa-project.org>; Tue, 18 Feb 2014 12:29:34 +0100 (CET)
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

Hi,

this is the first chunk of the whole patch serires, preliminary works
for renaming the confusing field name and minor clean ups in the
relevant places.

After this chunk, SOC_ENUM_*_DECL() macro cleanup and the actual fixes
for the wrong number of enum items will follow.

Then introduce SOC_ENUM_SINGLE_CONST() & co for omitting the explicit
ARRAY_SIZE() call, and apply it in the later patches.


Takashi
