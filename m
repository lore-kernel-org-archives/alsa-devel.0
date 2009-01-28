From: Will Wagner <will_wagner@carallon.com>
Subject: alsa-lib failing at runtime
Date: Wed, 28 Jan 2009 13:43:51 +0000
Message-ID: <49806117.8090205@carallon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from carallon.f9.co.uk (carallon.force9.co.uk [80.229.37.120])
	by alsa0.perex.cz (Postfix) with ESMTP id 55F9F243F9
	for <alsa-devel@alsa-project.org>; Wed, 28 Jan 2009 14:43:49 +0100 (CET)
Received: from [127.0.0.1] by carallon.f9.co.uk (MDaemon PRO v9.6.5)
	with ESMTP id md50000339308.msg
	for <alsa-devel@alsa-project.org>; Wed, 28 Jan 2009 13:43:43 +0000
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
List-Id: alsa-devel@alsa-project.org

Hi All,

I have found a problem with alsa-lib 1.0.19 running on an embedded arm board. It all
compiles ok but aplay fails to play a .wav file and the kernel reports this error:

ALSA sound/core/pcm_native.c:2587: unknown ioctl = 0x80184132

Decoding this ioctl it is SNDRV_PCM_IOCTL_CHANNEL_INFO defined in asound.h.

The reason it is not working is that the kernel and alsa-lib think that the
sndrv_pcm_channel_info struct is different sizes.

The definition in asound.h is:

struct sndrv_pcm_channel_info {
	unsigned int channel;
	off_t offset;			/* mmap offset */
	unsigned int first;		/* offset to first sample in bits */
	unsigned int step;		/* samples distance in bits */
};

The problem is that when compiling linux it thinks off_t is 4 bytes but when compiling
alsa-lib it thought it was 8 bytes.

After discussion on the buildroot mailing list (see
http://lists.busybox.net/pipermail/buildroot/2009-January/025458.html) it seems like for
the kernel off_t is always 4 bytes but for user space it can be either 4 or 8 bytes
depending on whether large file support is enabled.

It appears that the fix is that the type of offset should be changed to long.

Hope this all makes sense.

Thanks,

Will.
-- 
------------------------------------------------------------------------
Will Wagner                                     will_wagner@carallon.com
Development Manager                      Office Tel: +44 (0)20 7371 2032
Carallon Ltd, Studio G20, Shepherds Building, Rockley Rd, London W14 0DA
------------------------------------------------------------------------
