From: Timur Tabi <timur@freescale.com>
Subject: Re: Underrun errors in aplay
Date: Fri, 14 Mar 2008 10:23:36 -0500
Message-ID: <47DA9878.7050009@freescale.com>
References: <mailman.3199.1205503800.2095.alsa-devel@alsa-project.org>
	<477457A8DCA386439DA800C066CF973E030610D1@azsmsx414.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	by alsa0.perex.cz (Postfix) with ESMTP id 396632448F
	for <alsa-devel@alsa-project.org>; Fri, 14 Mar 2008 16:26:26 +0100 (CET)
In-Reply-To: <477457A8DCA386439DA800C066CF973E030610D1@azsmsx414.amr.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Barclay, Bruce" <bruce.barclay@intel.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Barclay, Bruce wrote:

> I am wondering if I am calling snd_pcm_period_elapsed too often.  I am
> calling that when I have free H/W buffers.  

I believe that function is only supposed to be called once, and only after a
period has been played.

-- 
Timur Tabi
Linux kernel developer at Freescale
