From: Torsten Schenk <torsten.schenk@zoho.com>
Subject: Re: [PATCH] ALSA: usb - prevent kernel panic on
 disconnect
Date: Thu, 10 Feb 2011 03:17:27 +0100
Message-ID: <12e0d5bddfc.-957256567165512453.3394632391713713714@zoho.com>
References: <1297278804-21011-1-git-send-email-pierre-louis.bossart@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sender1.zohomail.com (sender1.zohomail.com [72.5.230.95])
	by alsa0.perex.cz (Postfix) with ESMTP id D37121039AB
	for <alsa-devel@alsa-project.org>; Thu, 10 Feb 2011 03:17:34 +0100 (CET)
In-Reply-To: <1297278804-21011-1-git-send-email-pierre-louis.bossart@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
Cc: sarah.a.sharp@linux.intel.com, bossart.nospam@gmail.com, alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@intel.com>
List-Id: alsa-devel@alsa-project.org

Hello,

I encountered a similar problem while developing drivers for the dmx 6fire usb. Perhaps my finding could provide you with some more information about the kernel panic. I found out that if the device is removed,
the isoc-packet status indicate an error in the in-urb-retire method; the urb status still is 0. This happens a few ms before the actual disconnect() handler is called.
I also looked into the snd-usb-audio driver and could not find any isoc-packet status check. Maybe this could lead to inconsistencies between PCM stream state
and urbs.

Greets, Torsten

---- On Wed, 09 Feb 2011 20:13:24 +0100 Pierre-Louis Bossart  wrote ---- 

>Fix 100% reproducible kernel panic when a USB audio device is 
>disconnected during playback. When the PCM substream is NULL, any 
>dereference causes a kernel panic. This isn't a recent problem, the crash 
>happened with a 2.6.35 kernel as well 
> 
>Note that this is only a work-around, it does not address the 
>root cause of this inconsistency between urbs and PCM states. The 
>dmesg below shows two calls to snd_urb_complete, the substream is 
>NULL and the state is either running or stopped. This doesn't make 
>any sense. 
> 
>Thanks to Sarah Sharp  for her 
>help. 
