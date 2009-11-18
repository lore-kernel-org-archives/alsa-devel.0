From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: [PATCH 00/10] Intel HDMI fixes v2
Date: Wed, 18 Nov 2009 12:58:24 +0800
Message-ID: <20091118045824.GA29128@localhost>
References: <20091118043758.141785140@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id 35F1A2458B
	for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2009 05:58:30 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20091118043758.141785140@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Shane W <shane-alsa@csy.ca>, David =?utf-8?B?SMOkcmRlbWFu?= <david@hardeman.nu>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 18, 2009 at 12:37:58PM +0800, Wu, Fengguang wrote:
> Takashi,
> 
> Here are the updated Intel HDMI fixes.

- removed the keep-power-on patch (need more investigation)
- added snd_hda_jack_detect()
- added comments to snd_hda_jack_detect()/snd_hda_pin_sense()

Thanks,
Fengguang
