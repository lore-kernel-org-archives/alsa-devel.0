From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: hda: Is it ok to enable SND_HDA_I915 to support
 Haswell Gfx power well by default?
Date: Tue, 27 Aug 2013 09:32:43 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F8013274C1@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
 by alsa0.perex.cz (Postfix) with ESMTP id 393B22625D3
 for <alsa-devel@alsa-project.org>; Tue, 27 Aug 2013 11:32:48 +0200 (CEST)
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
To: "Takashi Iwai (tiwai@suse.de)" <tiwai@suse.de>, "David Henningsson
 (david.henningsson@canonical.com)" <david.henningsson@canonical.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi Takashi and David,

Is it okay to enable SND_HDA_I915 by default?

This would make it easy to upgrade kernel on Haswell. A user only needs to apply default configurations for the new kernel, and display audio can work automatically. The user need not have any idea about the display power well.

Now the user needs to manually enable SND_HDA_I915, otherwise display audio won't work since Gfx driver may turn off the power well which make both the controller and codec lose power.

Thanks
Mengdong
