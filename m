From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH v2] ALSA: usb: refine delay information
 with USB frame counter
Date: Sun, 11 Sep 2011 17:49:12 +0200
Message-ID: <4E6CD878.2090606@ladisch.de>
References: <1315354534-5995-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4.smtp.messagingengine.com (out4.smtp.messagingengine.com
	[66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id BE75310380D
	for <alsa-devel@alsa-project.org>;
	Sun, 11 Sep 2011 17:49:37 +0200 (CEST)
In-Reply-To: <1315354534-5995-1-git-send-email-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: sarah.a.sharp@linux.intel.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Pierre-Louis Bossart wrote:
> Existing code only updates the audio delay when URBs were
> submitted/retired. This can introduce an uncertainty of 8ms
> on the number of samples played out with the default settings,
> and a lot more when URBs convey more packets to reduce the
> interrupt rate and power consumption.
>
> This patch relies on the USB frame counter to reduce the
> uncertainty to less than 2ms worst-case. The delay information
> essentially becomes independent of the URB size and number of
> packets. This should help applications like PulseAudio which
> require accurate audio timing. Clemens Ladisch
> <clemens@ladisch.de> reported a decrease of mplayer's
> A-V difference from nrpacks down to at most 1ms.
>
> Thanks to Clemens for also pointing out that the implementation
> of frame counters varies between different HCDs. Only the
> 8 lowest-bits are used to estimate the delay.
>
> Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

Applied, thanks!


Clemens
