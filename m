From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH]Change the AZX_MAX_PCMS to 10
Date: Thu, 28 Jan 2010 09:48:44 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1001280941120.25340@eeebox2.perex-int.cz>
References: <6B4D417B830BC44B8026029FD256F7F1BFEAFA4039@HKMAIL01.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 64AB110381A
	for <alsa-devel@alsa-project.org>; Thu, 28 Jan 2010 09:48:45 +0100 (CET)
In-Reply-To: <6B4D417B830BC44B8026029FD256F7F1BFEAFA4039@HKMAIL01.nvidia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Wei Ni <wni@nvidia.com>
Cc: 'Takashi Iwai' <tiwai@suse.de>, 'akpm' <akpm@linux-foundation.org>, 'alsa-devel' <alsa-devel@alsa-project.org>, 'Pavel Hofman' <pavel.hofman@insite.cz>, 'linux-kernel' <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 28 Jan 2010, Wei Ni wrote:

> Hi, Takashi When I develop hdmi audio driver on the GT21x, I found a bug 
> in the had_intel.c In hda_codec.c, it has define "[HDA_PCM_TYPE_HDMI] = 
> { 3, 7, 8, 9, -1 },", it support up to device 9 for HDMI. But in 
> hda_intel.c, it only define AZX_MAX_PCMS as 8. So the GT21x have 4 hdmi 
> codecs, when run azx_attach_pcm_stream(), it will show error "Invalid 
> PCM device number 8", and "... number 9", and return "-EINVAL". We 
> should change the AZX_MAX_PCMS to 10.

I'm afraid, but having more than 8 PCM devices might cause problems when 
CONFIG_SND_DYNAMIC_MINORS is not set. At least, this condition 
(#if SNDRV_PCM_DEVICES < 10) should be handled in the HDA driver.

 					Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
