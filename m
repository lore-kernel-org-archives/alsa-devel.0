From: "Lin, Mengdong" <mengdong.lin@intel.com>
Subject: Re: [PATCH] ALSA: hda - delay resume haswell hdmi
 codec in system resume
Date: Tue, 26 Mar 2013 07:02:54 +0000
Message-ID: <F46914AEC2663F4A9BB62374E5EEF8F8361C9E@SHSMSX101.ccr.corp.intel.com>
References: <1364321572-2634-1-git-send-email-mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id DB6BF264F45
 for <alsa-devel@alsa-project.org>; Tue, 26 Mar 2013 08:02:58 +0100 (CET)
In-Reply-To: <1364321572-2634-1-git-send-email-mengdong.lin@intel.com>
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
To: "Lin, Mengdong" <mengdong.lin@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tiwai@suse.de" <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

Is it okay to add a new parameter to snd_hda_resume(), to indicate whether codec resume should be delayed or not?
Is because snd_hda_resume() is only only called by azx_resume() but also called by azx_bus_reset(). 
The latter can be called on a fatal verb execution failure and codec resume delay is not suitable for this case.

Thanks
Mengdong
