From: Thomas Klausner <tk@giga.or.at>
Subject: byteswap.h
Date: Thu, 3 Mar 2016 11:10:05 +0100
Message-ID: <20160303101005.GI8492@danbala.tuwien.ac.at>
References: <1456758321-2256-2-git-send-email-tk@giga.or.at>
 <s5h8u23xzt1.wl-tiwai@suse.de>
 <20160302221454.GC8492@danbala.tuwien.ac.at>
 <s5h60x3sy97.wl-tiwai@suse.de>
 <20160303095041.GG8492@danbala.tuwien.ac.at>
 <s5hwppjriol.wl-tiwai@suse.de> <s5hvb53rimi.wl-tiwai@suse.de>
 <20160303095852.GH8492@danbala.tuwien.ac.at>
 <sfid-H20160303-110137-+037.81-1@spamfilter.osbf.lua>
 <s5hsi07ribw.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from danbala.ifoer.tuwien.ac.at (danbala.ifoer.tuwien.ac.at
 [128.130.168.64])
 by alsa0.perex.cz (Postfix) with ESMTP id CDB49261ABB
 for <alsa-devel@alsa-project.org>; Thu,  3 Mar 2016 11:10:08 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5hsi07ribw.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, Mar 03, 2016 at 11:01:23AM +0100, Takashi Iwai wrote:
> Applied now.  Thanks.

Thank you!

Next big issue: Many places include byteswap.h to get bswap_16,
bswap_32, bswap_64.

This header does not exist on *BSD or Solaris.

However, all of these provide similar macros under different names,
from different header files (bswap16 etc, or BSWAP_16).

Do you want a compat header, e.g. include/bswap.h that takes care of
this and is included by local.h, or do you prefer a different
solution?
 Thomas
