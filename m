From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 2/3 v4] ALSA: usb-audio: Add mixer control
	for Digidesign	mbox 1 clock source
Date: Mon, 10 Nov 2014 10:47:53 +0100
Message-ID: <546089C9.1020301@ladisch.de>
References: <1415612437-5557-1-git-send-email-damien@zamaudio.com>
 <1415612437-5557-3-git-send-email-damien@zamaudio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id B5697260586
 for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2014 10:47:55 +0100 (CET)
In-Reply-To: <1415612437-5557-3-git-send-email-damien@zamaudio.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Damien Zammit <damien.zammit@gmail.com>, alsa-devel@alsa-project.org
Cc: tiwai@suse.de, Damien Zammit <damien@zamaudio.com>
List-Id: alsa-devel@alsa-project.org

Damien Zammit wrote:
> This patch provides the infrastructure for the Digidesign Mbox 1
> to have a mixer control for selecting the clock source.
> Valid options are Internal and S/PDIF external sync.
> A non-documented command is sent to the device to enable this feature
> found by reverse engineering and bus snooping.
>
> +++ b/sound/usb/mixer_quirks.c
> +static int snd_mbox1_switch_put(struct snd_kcontrol *kctl,
> +				struct snd_ctl_elem_value *ucontrol)
> +{
> ...
> +		down_read(&chip->shutdown_rwsem);

When I wrote "semaphore", I meant this one.


Regards,
Clemens
