From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 16/39] firewire-lib: Add some AV/C general
 commands
Date: Sun, 09 Mar 2014 22:32:54 +0100
Message-ID: <531CDE06.40604@ladisch.de>
References: <5316963F.1000206@sakamocchi.jp>
 <1394016507-15761-1-git-send-email-o-takashi@sakamocchi.jp>
 <1394016507-15761-17-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id C137C2655DF
 for <alsa-devel@alsa-project.org>; Sun,  9 Mar 2014 22:33:31 +0100 (CET)
In-Reply-To: <1394016507-15761-17-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi Sakamoto wrote:
> This commit adds three commands, which may be used by some firewire device
> drivers. These commands are defined in 'AV/C Digital Interface Command Set
> General Specification Version 4.2 (2004006, 1394TA)'.
>
> 1. PLUG INFO command (10.1)
> 2. INPUT PLUG SIGNAL FORMAT command (10.10)
> 3. OUTPUT PLUG SIGNAL FORMAT command (10.11)
>
> By the command 1, the drivers can get the number of plugs for AV/C unit or
> subunit.
> By the command 2 and 3, the drivers can get/set sampling frequency.

All these functions return errors with two different mechanisms, the AV/C
response code or a negative Linux error code.  This forces the caller to
add a second error check that duplicates the one inside the function:

> +	err = avc_general_set_sig_fmt(fwspk->unit, params_rate(hw_params),
> +				      AVC_GENERAL_PLUG_DIR_IN, 0);
>  	if (err < 0)
>  		goto err_buffer;
> +	if (err != 0x09 /* ACCEPTED */) {
> +		dev_err(&fwspk->unit->device, "failed to set sample rate\n");
> +		err = -EIO;
> +		goto error;
> +	}

Would there be problems if any response except ACCEPTED resulted in -EIO?

(And here, error should be err_buffer.)


Regards,
Clemens
