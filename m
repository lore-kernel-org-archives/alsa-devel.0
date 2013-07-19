From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 00/13] Remove static quirks for HD-audio AD
	codecs
Date: Fri, 19 Jul 2013 17:12:09 +0200
Message-ID: <1374246742-14373-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 5D08F265749
 for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2013 17:11:12 +0200 (CEST)
Received: from relay1.suse.de (unknown [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 39CD9A52D9
 for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2013 17:11:12 +0200 (CEST)
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

OK, it's time to clean up the craps in the old room.
Let's start from AD codecs, which I could test a few of them, and
worked well with the generic parser.

 [PATCH 01/13] ALSA: hda - Add GPIO control to AD1884 HP fixup
 [PATCH 02/13] ALSA: hda - Add fixup for Lenovo Thinkpad with AD1984
 [PATCH 03/13] ALSA: hda - Add fixup for HP TouchSmart with AD1984A
 [PATCH 04/13] ALSA: hda - Remove static quirks for AD1882
 [PATCH 05/13] ALSA: hda - Remove static quirks for AD1884/1984 &
 [PATCH 06/13] ALSA: hda - Remove static quirks for AD1981 and AD1983
 [PATCH 07/13] ALSA: hda - Remove static quirks for AD1988 codecs
 [PATCH 08/13] ALSA: hda - Convert the static quirk for Samsung Q1
 [PATCH 09/13] ALSA: hda - Convert static quirks for AD1986A Samsung
 [PATCH 10/13] ALSA: hda - Drop static quirks for other AD1986A
 [PATCH 11/13] ALSA: hda - Drop static quirk for Toshiba Satellite
 [PATCH 12/13] ALSA: hda - Drop a few other static quirks for AD1986A
 [PATCH 13/13] ALSA: hda - Remove static quirks for AD1986A codec


Takashi
