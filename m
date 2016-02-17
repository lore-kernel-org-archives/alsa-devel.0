From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: ASoC: hdac_hdmi: Add jack reporting
Date: Wed, 17 Feb 2016 11:32:23 +0300
Message-ID: <20160217083223.GA31585@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from aserp1040.oracle.com (aserp1040.oracle.com [141.146.126.69])
 by alsa0.perex.cz (Postfix) with ESMTP id 003FA2659F0
 for <alsa-devel@alsa-project.org>; Wed, 17 Feb 2016 09:32:31 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: jeeja.kp@intel.com
Cc: alsa-devel@alsa-project.org, "Subhransu S. Prusty" <subhransu.s.prusty@intel.com>
List-Id: alsa-devel@alsa-project.org

Hello Jeeja KP,

This is a semi-automatic email about new static checker warnings.

The patch 4a3478debf36: "ASoC: hdac_hdmi: Add jack reporting" from 
Feb 12, 2016, leads to the following Smatch complaint:

sound/soc/codecs/hdac_hdmi.c:971 hdac_hdmi_present_sense()
	 warn: variable dereferenced before check 'edev' (see line 967)

sound/soc/codecs/hdac_hdmi.c
   966		struct hdac_ext_device *edev = pin->edev;
   967		struct hdac_hdmi_priv *hdmi = edev->private_data;
                                              ^^^^^^^^^^^^^^^^^^
Patch introduces a new dereference.

   968		struct hdac_hdmi_pcm *pcm;
   969		int val;
   970	
   971		if (!edev)
                    ^^^^^
Existing code assumed that edev could be NULL.

   972			return;
   973	

regards,
dan carpenter
