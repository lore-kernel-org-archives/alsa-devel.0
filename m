From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: link between HDMI ELD and PCM devices
Date: Tue, 20 Sep 2011 18:12:42 -0500
Message-ID: <1316560363.3872.14.camel@pbossart-Dell-N7010>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id 811FE10386E
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Sep 2011 01:13:06 +0200 (CEST)
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
Cc: "; Takashi Iwai" <tiwai@suse.de>, ";
	Wu Fengguang" <fengguang.wu@intel.com>, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

Hi,
I've been trying for some time to expose the HDMI ELD information in a
new control. The problem I am facing with the HDMI/HDA code is that the
ELD is linked to an output pin, and I can't find an elegant way to link
this output pin with a PCM device number to be used by my control. For a
single output, I could hard-code something but it would probably not
work with multiple monitors handled by recent hardware.
There is some existing code such as pin_nid_to_pin_index() in
patch_hdmi.c, but I can't figure out what this pin_idx is, and how to
find the related PCM device number.
Any suggestions?
Thanks,
-Pierre
