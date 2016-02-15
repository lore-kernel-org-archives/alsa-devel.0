From: Randy Dunlap <rdunlap@infradead.org>
Subject: sound compress_driver.h: missing kernel-doc notation
	for a few fields
Date: Sun, 14 Feb 2016 20:56:22 -0800
Message-ID: <56C15A76.5040507@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from casper.infradead.org (casper.infradead.org [85.118.1.10])
 by alsa0.perex.cz (Postfix) with ESMTP id 8F2CD2605C1
 for <alsa-devel@alsa-project.org>; Mon, 15 Feb 2016 05:56:37 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, moderated for non-subscribers <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Richard,

Please add kernel-doc notation for these fields:

..//include/sound/compress_driver.h:160: warning: No description found for parameter 'id[64]'
..//include/sound/compress_driver.h:160: warning: No description found for parameter 'proc_root'
..//include/sound/compress_driver.h:160: warning: No description found for parameter 'proc_info_entry'


thanks,
-- 
~Randy
