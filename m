From: Wu Fengguang <fengguang.wu@intel.com>
Subject: PROC_COEF/PROC_INDEX question
Date: Fri, 7 Aug 2009 17:38:59 +0800
Message-ID: <20090807093859.GA2155@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 899BC103883
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Aug 2009 11:39:03 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Hello,

I'm not sure of the usage for GET_PROC_COEF/GET_COEF_INDEX, and found
that their return value is unstable (changing all the time) for codec:

        Codec: Realtek ALC888
        Address: 2
        Function Id: 0x1
        Vendor Id: 0x10ec0888
        Subsystem Id: 0x80860023
        Revision Id: 0x100202

For example:

# hda-verb /dev/snd/hwC0D2 0x20 GET_PROC_COEF 0 
nid = 0x20, verb = 0xc00, param = 0x0
value = 0x80
# hda-verb /dev/snd/hwC0D2 0x20 GET_COEF_INDEX 0
nid = 0x20, verb = 0xd00, param = 0x0
value = 0xe
# hda-verb /dev/snd/hwC0D2 0x20 GET_PROC_COEF 0 
nid = 0x20, verb = 0xc00, param = 0x0
value = 0x9c00
# hda-verb /dev/snd/hwC0D2 0x20 GET_COEF_INDEX 0
nid = 0x20, verb = 0xd00, param = 0x0
value = 0xf

I wonder if this is the normal case?

Thanks,
Fengguang
