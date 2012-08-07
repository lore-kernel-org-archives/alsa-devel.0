From: "Wang, Xingchao" <xingchao.wang@intel.com>
Subject: ICT Bits for HDMI HBR feature
Date: Tue, 7 Aug 2012 08:09:26 +0000
Message-ID: <46B810F6945F7C4788E11DCE57EC48900FF4245B@SHSMSX102.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id AAFF2265020
 for <alsa-devel@alsa-project.org>; Tue,  7 Aug 2012 09:39:44 +0200 (CEST)
Content-Language: en-US
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

Should we set ICT bits when enable HDMI HBR features? Here's quote from HDA Specification Rev1.0a(page 150).
"
ICT[3:0] (IEC Coding Type): Programmed according to IEC standards to enable stream types for High Bit Rate Encoding. This is valid only for HDMI and Display port digital Pin Widgets.
"
Since HDMI HBR already works on some chips, I wonder if they set the bits correctly.

Thanks
--xingchao
