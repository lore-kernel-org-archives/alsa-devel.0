From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 1/2 v3] ALSA: usb-audio: Add mixer
	control	for Digidesign mbox 1 clock source
Date: Mon, 10 Nov 2014 09:23:47 +0100
Message-ID: <54607613.30802@ladisch.de>
References: <1415605612-2977-1-git-send-email-damien@zamaudio.com>
 <1415605612-2977-2-git-send-email-damien@zamaudio.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 35C51260650
 for <alsa-devel@alsa-project.org>; Mon, 10 Nov 2014 09:23:49 +0100 (CET)
In-Reply-To: <1415605612-2977-2-git-send-email-damien@zamaudio.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Damien Zammit <damien.zammit@gmail.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, Damien Zammit <damien@zamaudio.com>
List-Id: alsa-devel@alsa-project.org

Damien Zammit wrote:
> This patch provides the infrastructure for the Digidesign Mbox 1
> to have a mixer control for selecting the clock source.
> Valid options are Internal and S/PDIF external sync.
> A non-documented command is sent to the device to enable this feature
> found by reverse engineering and bus snooping.
>
> Signed-off-by: Damien Zammit <damien@zamaudio.com>
> ---
>  sound/usb/mixer_maps.c   |   9 +++
>  sound/usb/mixer_quirks.c | 142 +++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 151 insertions(+)
>
> +++ b/sound/usb/mixer_maps.c
> +static int snd_mbox1_switch_put(struct snd_kcontrol *kctl,
> +				struct snd_ctl_elem_value *ucontrol)
> +{
> ...
> +		down_read(&chip->shutdown_rwsem);
> +		if (chip->shutdown) {
> +			err = -ENODEV;
> +		} else {
> +			/* Prepare for magic command to toggle clock source */
> +			err = snd_usb_ctl_msg(chip->dev,
> +				usb_rcvctrlpipe(chip->dev, 0), 0x81,
> +				USB_DIR_IN |
> +				USB_TYPE_CLASS |
> +				USB_RECIP_INTERFACE, 0x00, 0x500, buff, 1);
> +			if (err < 0)
> +				return err;

The semaphore is still locked.

> @@ -1605,6 +1740,13 @@ int snd_usb_mixer_apply_create_quirk(struct usb_mixer_interface *mixer)
>  					      snd_audigy2nx_proc_read);
>  		break;
>
> +	/* Digidesign Mbox 1 */
> +	case USB_ID(0x0dba, 0x1000):

The IDs are supposed to be sorted by their value.

> +		err = snd_mbox1_create_sync_switch(mixer);
> +		if (err < 0)
> +			break;
> +		break;

This if() is meaningless.


Regards,
Clemens
