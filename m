From: Jussi Laako <jussi@sonarnerd.net>
Subject: Re: [PATCH v3 0/5] ALSA: snd-usb: add support for DSD
Date: Wed, 17 Apr 2013 20:01:12 +0300
Message-ID: <516ED558.3060004@sonarnerd.net>
References: <1366128100-9778-1-git-send-email-zonque@gmail.com>
 <s5hsj2pbexz.wl%tiwai@suse.de> <516E8185.9050705@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.sonarnerd.net (rankki.sonarnerd.net [83.145.240.118])
 by alsa0.perex.cz (Postfix) with ESMTP id 2010A2616F3
 for <alsa-devel@alsa-project.org>; Wed, 17 Apr 2013 19:01:13 +0200 (CEST)
In-Reply-To: <516E8185.9050705@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, clemens@ladisch.de, demian@auraliti.com, ray@auraliti.com, andreas@akdesigninc.com
List-Id: alsa-devel@alsa-project.org

On 04/17/2013 02:03 PM, Daniel Mack wrote:
> I'd like to wait for another day or so for Jussi to state his oppinion.

Looks good to me. Hopefully the necessary details about bit ordering 
find their way to the ALSA API docs.

I was left thinking about how this:

> +	if (pcm_format == SNDRV_PCM_FORMAT_DSD_U16_LE && fmt->dsd_dop) {
> +		/*
> +		 * When operating in DSD DOP mode, the size of a sample frame
> +		 * in hardware differs from the actual physical format width
> +		 * because we need to make room for the DOP markers.
> +		 */
> +		frame_bits += channels << 3;
> +	}

relates to case where the endpoint uses 32-bit int sample format and 
thus needs a zero pad byte for DoP...
