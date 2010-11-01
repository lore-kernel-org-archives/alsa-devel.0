From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH] ALSA: add support for disabling period irq
Date: Tue, 2 Nov 2010 07:46:17 +0800
Message-ID: <AANLkTimYb3SVnvwOVhoyQEv6p+zGqz_ANdk-eoQnSALu@mail.gmail.com>
References: <1288649573-31545-1-git-send-email-pierre-louis.bossart@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179])
	by alsa0.perex.cz (Postfix) with ESMTP id A435F103870
	for <alsa-devel@alsa-project.org>; Tue,  2 Nov 2010 00:46:24 +0100 (CET)
Received: by eyg24 with SMTP id 24so3355785eyg.38
	for <alsa-devel@alsa-project.org>; Mon, 01 Nov 2010 16:46:18 -0700 (PDT)
In-Reply-To: <1288649573-31545-1-git-send-email-pierre-louis.bossart@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/11/2 Pierre-Louis Bossart <bossart.nospam@gmail.com>

> Merged and cleaned patch based on earlier patches posted
> on alsa-devel by Clemens Ladisch <clemens@ladisch.de> and
> Pierre-Louis Bossart <pierre-louis.bossart@intel.com>
>
> This patch disables period interrupts which are not
> needed when the application relies on a system timer
> to wake-up and refill the ring buffer. The behavior of
> the driver is left unchanged, and interrupts are only
> disabled if the application requests this configuration.
> The behavior in case of underruns is slightly different,
> instead of being detected during the period interrupts the
> underruns are detected when the application calls
> snd_pcm_update_avail, which in turns forces a refresh of the
> hw pointer and shows the buffer is empty.
>

But PA server set stop threshold to boundary, according to

http://www.alsa-project.org/alsa-doc/alsa-lib/group___p_c_m___s_w___params.html

PCM is automatically stopped in SND_PCM_STATE_XRUN state when available
frames is >= threshold. If the stop threshold is equal to boundary (also
software parameter - sw_param) then automatic stop will be disabled (thus
device will do the endless loop in the ring buffer).

The available buffer will not be empty (zero) but negative since device will
do the endless loop
