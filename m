From: "Stefano D'Angelo" <zanga.mail@gmail.com>
Subject: Line6 TonePort UX1 USB driver
Date: Thu, 18 May 2006 11:55:52 +0200
Message-ID: <160c13350605180255m41f6af40q6a4f32dc28f200f5@mail.gmail.com>
References: <160c13350605172045p4aba52q6552fd190027c0c0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_28904_15671405.1147946152846"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <160c13350605172045p4aba52q6552fd190027c0c0@mail.gmail.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

------=_Part_28904_15671405.1147946152846
Content-Type: multipart/alternative;
	boundary="----=_Part_28905_20582158.1147946152847"

------=_Part_28905_20582158.1147946152847
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,
here is the code I'm currently working on (some things, expecially regardin=
g
playback, are not updated yet).
First question: how do mmap and DMA work with USB? I'm looking in usbaudio
code, but I'm kind of feeling lost...
Second question: how can I trace and unlink urbs when a substream gets
stopped?
Maybe you can give me some link if you think it's too long to answer right
here.

Stefano D'Angelo

------=_Part_28905_20582158.1147946152847
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<span class=3D"gmail_quote"></span>Hi,<br><div>here is the code I'm current=
ly working on (some things, expecially regarding playback, are not updated =
yet).<br>First question: how do mmap and DMA work with USB? I'm looking in =
usbaudio code, but I'm kind of feeling lost...
<br>Second question: how can I trace and unlink urbs when a substream gets =
stopped?<br>Maybe you can give me some link if you think it's too long to a=
nswer right here.<br></div><div><span class=3D"sg"><br>Stefano D'Angelo<br>


</span></div><br clear=3D"all">

------=_Part_28905_20582158.1147946152847--

------=_Part_28904_15671405.1147946152846
Content-Type: text/x-csrc; name=snd_line6_tp_ux1.c; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_enck0wdl
Content-Disposition: attachment; filename="snd_line6_tp_ux1.c"

/*
 *   Line6 TonePort UX1 (and maybe TonePort UX2) USB driver for ALSA
 *
 *
 *   Copyright (c) 2006 by Stefano D'Angelo <daste@oneonline.it>
 *
 *   Some code borrowed from
 *          USB Audio Driver for ALSA by Takashi Iwai <tiwai@suse.de>
 *          "Writing an ALSA Driver" by Takashi Iwai <tiwai@suse.de>
 *          "Linux USB Driver Basics" at http://www.linuxtecharticles.com
 *   and maybe, consequently, also from audio.c by
 *	    Alan Cox <alan@lxorguk.ukuu.org.uk>
 *	    Thomas Sailer <sailer@ife.ee.ethz.ch>
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation; either version 2 of the License, or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details.
 *
 *   You should have received a copy of the GNU General Public License
 *   along with this program; if not, write to the Free Software
 *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
 *
 */

#include <linux/usb.h>
#include <linux/device.h>
#include <linux/version.h>
#include <sound/driver.h>
#include <sound/core.h>
#include <sound/info.h>
#include <sound/pcm.h>
#include <sound/pcm_params.h>
#include <sound/initval.h>
#include <sound/control.h>

#include "snd_line6_tp_ux1.h"

static int  index[SNDRV_CARDS]  = SNDRV_DEFAULT_IDX;
static char *id[SNDRV_CARDS]    = SNDRV_DEFAULT_STR;
static int  enable[SNDRV_CARDS] = SNDRV_DEFAULT_ENABLE_PNP;

static struct snd_line6_tp_ux1 *chip[SNDRV_CARDS] = {NULL};

static struct usb_device_id snd_line6_tp_ux1_id_table [] =
{
	{ USB_DEVICE (LINE6_VENDOR_ID, LINE6_TP_UX1_PID) },
	/* { USB_DEVICE (LINE6_VENDOR_ID, LINE6_TP_UX2_PID) }, */
	{ }
};

static struct usb_driver snd_line6_tp_ux1_driver = {
#if LINUX_VERSION_CODE < KERNEL_VERSION (2,6,16)
	.owner      = THIS_MODULE,
#endif
	.name       = "snd-line6-tp-ux1",
	.id_table   = snd_line6_tp_ux1_id_table,
	.probe      = snd_line6_tp_ux1_probe,
	.disconnect = snd_line6_tp_ux1_disconnect
};

static snd_pcm_hardware_t snd_line6_tp_ux1_playback_hw = {
	.info             = SNDRV_PCM_INFO_MMAP |
	                    SNDRV_PCM_INFO_INTERLEAVED |
	                    SNDRV_PCM_INFO_BLOCK_TRANSFER |
	                    SNDRV_PCM_INFO_MMAP_VALID,
	.formats          = SNDRV_PCM_FMTBIT_S16_LE |
	                    SNDRV_PCM_FMTBIT_S24_3LE,
	.rates            = SNDRV_PCM_RATE_48000,
	.rate_min         = 48000,
	.rate_max         = 48000,
	.channels_min     = 2,
	.channels_max     = 2,
	.buffer_bytes_max = LINE6_TP_UX1_48000_24_PACKET_SIZE_OUT * 1024,
	.period_bytes_min = LINE6_TP_UX1_48000_16_PACKET_SIZE_OUT,
	.period_bytes_max = LINE6_TP_UX1_48000_24_PACKET_SIZE_OUT,
	.periods_min      = 2,	/* double buffering */
	.periods_max      = 1024
};

static snd_device_ops_t snd_line6_tp_ux1_ops =
{
        .dev_free = snd_line6_tp_ux1_dev_free
};

static snd_pcm_ops_t snd_line6_tp_ux1_playback_ops = {
	.open      = snd_line6_tp_ux1_playback_open,
	.close     = snd_line6_tp_ux1_playback_close,
	.ioctl     = snd_pcm_lib_ioctl,
	.hw_params = snd_line6_tp_ux1_pcm_hw_params,
	.hw_free   = snd_line6_tp_ux1_pcm_hw_free,
	.prepare   = snd_line6_tp_ux1_pcm_prepare,
	.trigger   = snd_line6_tp_ux1_pcm_trigger,
	.pointer   = snd_line6_tp_ux1_pcm_pointer,
};

/* TODO: capture ops */

/* module related stuff */

module_param_array (index, int, NULL, 0444);
MODULE_PARM_DESC (index, "Index value for the Line6 TonePort UX1 adapter.");
module_param_array (id, charp, NULL, 0444);
MODULE_PARM_DESC (id, "ID string for the Line6 TonePort UX1 adapter.");
module_param_array (enable, bool, NULL, 0444);
MODULE_PARM_DESC (enable, "Enable Line6 TonePort UX1 adapter.");

MODULE_AUTHOR ("Stefano D'Angelo <daste@oneonline.it>");
MODULE_DESCRIPTION ("Line6 TonePort UX1 USB driver for ALSA");
MODULE_LICENSE ("GPL");
MODULE_SUPPORTED_DEVICE ("Line6 TonePort UX1 USB");
MODULE_DEVICE_TABLE (usb, snd_line6_tp_ux1_id_table);

/* functions */

/*
 * driver's entry-point
 */
static int snd_line6_tp_ux1_driver_init ()
{
	return usb_register (&snd_line6_tp_ux1_driver);
}

/*
 * driver's exit-point
 */
static void snd_line6_tp_ux1_driver_exit ()
{
	usb_deregister (&snd_line6_tp_ux1_driver);
}

/*
 * probes the sound card
 *
 * checks whether the device is already registered or not and eventually inits
 * it using the first avaible slot.
 *
 * it doesn't seem to happen that this function is executed multpile times for
 * a single card, but we check the same
 */
static int snd_line6_tp_ux1_probe (struct usb_interface *intf,
                                   const struct usb_device_id *id)
{
	struct usb_device *dev = interface_to_usbdev (intf);
	int i, j;

	j = -1;
	for (i = 0; i < SNDRV_CARDS; i++) {
		if (chip[i]) {
			/* couldn't do the following check before */
			if (dev == chip[i]->dev) {
				/* yes, already registered */
				return 0;
			}
		} else {
			/* oh, we've got a slot */
			if (j == -1)
				j = i;
		}
	}

	if (j == -1) {
		snd_printk (KERN_ERR "no available USB audio device\n");
		return -ENODEV;
	}

	return snd_line6_tp_ux1_create (dev, j);
}

/*
 * inits the soundcard and the drivers' handles
 */
static int snd_line6_tp_ux1_create (struct usb_device *dev, int idx)
{
	snd_card_t* card;
	int i;

	chip[idx] = kmalloc (sizeof (struct snd_line6_tp_ux1), GFP_KERNEL);

	/* create a card instance */
	if (!(chip[idx]->card = snd_card_new (index[idx], id[idx], THIS_MODULE,
	    0))) {
		snd_printk (KERN_ERR "cannot create card instance %d\n", idx);
		kfree (chip[idx]);
		chip[idx] = NULL;
		return -ENOMEM;
	}

	card = chip[idx]->card;
	card->private_data = chip[idx];

	/* set the driver ID and name strings */
	strlcpy (card->driver, "Line6-TP-UX1", sizeof (card->driver));
	strlcpy (card->shortname, "Line6 TonePort UX1 USB",
	         sizeof (card->shortname));
	i = strlcpy (card->longname, "Line6 TonePort UX1 USB at ",
	             sizeof (card->longname));
	if (i < sizeof (card->longname)) {
		usb_make_path (dev, card->longname + i,
		               sizeof (card->longname) - i);
        }
	if (dev->speed == USB_SPEED_FULL) {
		strlcat (card->longname, ", full speed",
		         sizeof (card->longname));
	} else {
		strlcat (card->longname, ", unknown speed",
		         sizeof (card->longname));
	}

	/* init USB messages */
	if ((i = snd_line6_tp_ux1_init_msgs (dev))) {
		snd_printk (KERN_ERR "failed to send init messages to the "
		            "sound card\n");
		snd_card_free (card);
		kfree (chip[idx]);
		chip[idx] = NULL;
		return i;
	}

	/* create device and pcm instances */
	if ((i = snd_device_new (card, SNDRV_DEV_LOWLEVEL, chip[idx],
	                         &snd_line6_tp_ux1_ops))) {
		snd_printk (KERN_ERR "could not create a device handler for "
		            "the card\n");
		snd_card_free (card);
		kfree (chip[idx]);
		chip[idx] = NULL;
		return i;
        }

        if ((i = snd_line6_tp_ux1_new_pcm (chip[idx]))) {
		snd_printk (KERN_ERR "could not create a pcm stream for the "
		            "card\n");
		snd_card_free (card);
		kfree (chip[idx]);
		chip[idx] = NULL;
		return i;
	}

	/* register the card instance */
	if ((i = snd_card_register (card))) {
		snd_printk (KERN_ERR "could not register the card's "
		            "instance!\n");
		snd_card_free (card);
		kfree (chip[idx]);
		chip[idx] = NULL;
		return i;
	}

	/* set some other data */
	chip[idx]->index = idx;
	chip[idx]->dev = dev;
	chip[idx]->altsetting = 0;
	chip[idx]->pending_playback_urbs = NULL;
	chip[idx]->last_pending_playback_urb = NULL;

	return 0;
}

/*
 * sends vendor specific init messages to the card
 */
static int snd_line6_tp_ux1_init_msgs (struct usb_device* dev)
{
	unsigned char msg1[8] = LINE6_TP_UX1_MSG_1;
	unsigned char msg2[8] = LINE6_TP_UX1_MSG_2;
	unsigned char msg3[8] = LINE6_TP_UX1_MSG_3;
	unsigned char msg4[8] = LINE6_TP_UX1_MSG_4;
	int i;

	if ((i = snd_line6_tp_ux1_submit_control_transfer (dev, msg1)))
		return i;

	if ((i = snd_line6_tp_ux1_submit_control_transfer (dev, msg2)))
		return i;

	if ((i = snd_line6_tp_ux1_submit_control_transfer (dev, msg3)))
		return i;

	return snd_line6_tp_ux1_submit_control_transfer (dev, msg4);
}

/*
 * creates a pcm stream for the device
 *
 * TODO: capture
 */
static int snd_line6_tp_ux1_new_pcm (struct snd_line6_tp_ux1 *chip)
{
	snd_pcm_t *pcm;
	int err;

	if ((err = snd_pcm_new (chip->card, "Line6 TonePort UX1", 0, 1, 0,
	                        &pcm)) < 0)
		return err;

	pcm->private_data = chip;
	strcpy (pcm->name, "Line6 TonePort UX1");
	chip->pcm = pcm;

	snd_pcm_set_ops (pcm, SNDRV_PCM_STREAM_PLAYBACK,
	                 &snd_line6_tp_ux1_playback_ops);

        return 0;
}

/*
 * handles the card's disconnection
 */
static void snd_line6_tp_ux1_disconnect (struct usb_interface *intf)
{
	int i;

	/* find the card */
	for (i = 0; i < SNDRV_CARDS; i++) {
		if (chip[i]) {
			/* couldn't do this check before again */
			if (chip[i]->dev == interface_to_usbdev(intf))
				break;
		}
	}

	if (i != SNDRV_CARDS)
		snd_line6_tp_ux1_free (chip[i]);
}

/*
 * fake component destructor
 */
static int snd_line6_tp_ux1_dev_free (snd_device_t *device)
{
        return 0;
}

/*
 * chip-specific destructor
 */
static int snd_line6_tp_ux1_free (struct snd_line6_tp_ux1 *chip_ptr)
{
	int i;

	if (!(i = snd_card_free (chip_ptr->card))) {
		chip[chip_ptr->index] = NULL;
		kfree (chip_ptr);
	}

	return i;
}

/*
 * submits an USB control transfer to the card with packet as setup_packet
 */
static int snd_line6_tp_ux1_submit_control_transfer (struct usb_device* dev,
                                                     unsigned char* packet)
{
	struct urb* urb;
	struct completion done;
	int i;

	urb = usb_alloc_urb (0, GFP_KERNEL);
	init_completion (&done);
	usb_fill_control_urb (urb, dev, usb_sndctrlpipe (dev, 0), packet, NULL,
	                      0, snd_line6_tp_ux1_complete_control_transfer,
	                      &done);
	i = usb_submit_urb (urb, GFP_KERNEL);
	wait_for_completion (&done);

	return i;
}

/*
 * control transfers' completition callback
 *
 * TODO: error handling
 */
static void snd_line6_tp_ux1_complete_control_transfer (struct urb* urb,
                                                        struct pt_regs* regs)
{
	usb_free_urb (urb);

	complete (urb->context);
}

/*
 * playback transfers' completition callback
 */
static void snd_line6_tp_ux1_complete_playback_transfer (struct urb *urb,
                                                         struct pt_regs *regs)
{
	struct urb_list **pend_urbs = &(chip[*((int *)(urb->context))]->
	                                                pending_playback_urbs);
	struct urb_list *tmp;

	if (chip[*((int*)(urb->context))]->pending_playback_urbs) {
		tmp = *pend_urbs;
		if (!((*pend_urbs) = (*pend_urbs)->next))
			chip[*((int*)(urb->context))]->last_pending_playback_urb = NULL;
		printk ("comp %d %d\n", urb, tmp->urb == urb);
		kfree (tmp);
	}

	kfree (urb->transfer_buffer);
	usb_free_urb (urb);
}

/*
 * completition callback for unlinking in hw_free callback
 */
static void snd_line6_tp_ux1_complete_playback_unlink (struct urb* urb,
                                                       struct pt_regs* regs)
{
	printk ("comp2 %d\n", urb);

	kfree (urb->transfer_buffer);
	usb_free_urb (urb);

	complete (urb->context);
}

/*
 * sets the hw_params for a playback stream
 */
static int snd_line6_tp_ux1_playback_open (snd_pcm_substream_t *substream)
{
	substream->runtime->hw = snd_line6_tp_ux1_playback_hw;

	return 0;
}

/*
 * resets the device to the "normal" (non-transfer) mode
 */
static int snd_line6_tp_ux1_playback_close (snd_pcm_substream_t *substream)
{
	return 0;
}

/*
 * hw_params callback
 *
 * TODO: capture
 */
static int snd_line6_tp_ux1_pcm_hw_params (snd_pcm_substream_t *substream,
                                           snd_pcm_hw_params_t *hw_params)
{
	struct snd_line6_tp_ux1 *chip = snd_pcm_substream_chip (substream);
	unsigned char msg[] = LINE6_TP_UX1_MSG_3;
	int err, err2;

	chip->playback_pos = 0;

	if (chip->altsetting)
		return 0;

	if (params_format (hw_params) == SNDRV_PCM_FMTBIT_S16_LE)
		chip->altsetting = LINE6_TP_UX1_48000_16_ALTSETTING;
	else
		chip->altsetting = LINE6_TP_UX1_48000_24_ALTSETTING;


	if ((err = usb_set_interface (chip->dev, 0, chip->altsetting)) < 0) {
		chip->altsetting = 0;
		return err;
	}

	if ((err = snd_line6_tp_ux1_submit_control_transfer (chip->dev, msg)) <
	    0) {
		chip->altsetting = 0;
		if ((err2 = usb_set_interface (chip->dev, 0, 0)) < 0)
			return err2;

		return err;
	}

	return 0;
}

/*
 * hw_free callback
 *
 * TODO: unset playback/capture/both modes and relative parameters
 */
static int snd_line6_tp_ux1_pcm_hw_free (snd_pcm_substream_t *substream)
{
	struct snd_line6_tp_ux1 *chip = snd_pcm_substream_chip (substream);
	struct urb_list *list, *tmp = NULL;
	struct completion done;
	int err;

	while (chip->pending_playback_urbs);

/*	printk ("%d\n", chip->pending_playback_urbs);
	if ((list = chip->pending_playback_urbs)) {
		do {
/*			printk ("-------\ntmp: %d\n", tmp);
			printk ("list: %d\n", list);
			printk ("next: %d\n", list->next);
			printk ("urb: %d\n", list->urb);
/*			if (tmp)
				kfree (tmp); */

			/* resources are freed in completition callback */
/*			init_completion (&done);
			list->urb->context = &done;
			list->urb->complete = snd_line6_tp_ux1_complete_playback_unlink;
			tmp = list;
			printk("a\n");
			if (usb_unlink_urb (list->urb) == -EINPROGRESS) {
				wait_for_completion (&done);
				printk("b\n");
			}
			printk ("c\n");
		} while ((list = list->next));
	} */

	if ((err = usb_set_interface (chip->dev, 0 ,0)) < 0)
		return err;

	chip->altsetting = 0;

	return 0;
}

/*
 * prepare callback
 *
 * TODO: write it
 */
static int snd_line6_tp_ux1_pcm_prepare (snd_pcm_substream_t *substream)
{
	/* struct snd_line6_tp_ux1 *chip = snd_pcm_substream_chip (substream);
	snd_pcm_runtime_t *runtime = substream->runtime; */

	/* set up the hardware with the current configuration (sample format,
	   sample rate, etc.) */

	return 0;
}

/*
 * trigger callback
 *
 * TODO: write it
 */
static int snd_line6_tp_ux1_pcm_trigger (snd_pcm_substream_t *substream, int cmd)
{
/*	switch (cmd) {
	case SNDRV_PCM_TRIGGER_START:
		printk ("trigger start\n");
		break;
	case SNDRV_PCM_TRIGGER_STOP:
		printk ("trigger stop\n");
		break;
	default:
		return -EINVAL;
	} */

	return 0;
}

/*
 * pointer callback
 *
 * returns the position in frames of the buffer actually sent/received
 *
 * TODO: capture
 */
static snd_pcm_uframes_t snd_line6_tp_ux1_pcm_pointer (
                                               snd_pcm_substream_t* substream)
{
	struct snd_line6_tp_ux1 *chip = snd_pcm_substream_chip (substream);

	return chip->playback_pos;
}

/*
 * does the playback
 *
 * TODO: handle different formats, etc.
 */
static int snd_line6_tp_ux1_playback_copy (snd_pcm_substream_t *substream,
                                           int channel, snd_pcm_uframes_t pos,
                                           void *src, snd_pcm_uframes_t count)
{
	struct snd_line6_tp_ux1 *chip = snd_pcm_substream_chip (substream);
	struct urb* urb;
	u8* data = src;
	u8* buf;
	int val;
	int i = 0;

	urb = usb_alloc_urb (2, GFP_ATOMIC);

	if (!chip->pending_playback_urbs) {
		chip->last_pending_playback_urb = chip->pending_playback_urbs =
		                kmalloc (sizeof (struct urb_list), GFP_KERNEL);
		chip->pending_playback_urbs->urb = urb;
		chip->pending_playback_urbs->next = NULL;
	} else {
		chip->last_pending_playback_urb->next =
		                kmalloc (sizeof (struct urb_list), GFP_KERNEL);
		chip->last_pending_playback_urb = chip->last_pending_playback_urb->next;
		chip->last_pending_playback_urb->urb = urb;
		chip->last_pending_playback_urb->next = NULL;
	}

	urb->dev = chip->dev;
	urb->pipe = usb_sndisocpipe (urb->dev, 1);
	urb->complete = snd_line6_tp_ux1_complete_playback_transfer;
	urb->context = &chip->index;
	buf = urb->transfer_buffer = kmalloc (
		        LINE6_TP_UX1_48000_24_PACKET_SIZE_OUT * 2, GFP_ATOMIC);
	urb->transfer_buffer_length = LINE6_TP_UX1_48000_24_PACKET_SIZE_OUT *
	                              2;
	urb->transfer_flags = URB_ISO_ASAP;
	urb->interval = 1;
	urb->number_of_packets = 2;
	urb->iso_frame_desc[0].offset = 0;
	urb->iso_frame_desc[0].length = urb->iso_frame_desc[1].offset =
	urb->iso_frame_desc[1].length = LINE6_TP_UX1_48000_24_PACKET_SIZE_OUT;

	while (i < LINE6_TP_UX1_48000_24_PACKET_SIZE_OUT * 2) {
		val = snd_line6_tp_ux1_volumize_24 (data[i + 2], data[i + 1],
		                                    data[i],
		                                    chip->playback_lvol);
		buf[i++] = val & 0x000000ff;
		buf[i++] = (val & 0x0000ff00) >> 8;
		buf[i++] = (val & 0x00ff0000) >> 16;
		val = snd_line6_tp_ux1_volumize_24 (data[i + 2], data[i + 1],
		                                    data[i],
		                                    chip->playback_rvol);
		buf[i++] = val & 0x000000ff;
		buf[i++] = (val & 0x0000ff00) >> 8;
		buf[i++] = (val & 0x00ff0000) >> 16;
		chip->playback_pos++;
	}

	usb_submit_urb (urb, GFP_ATOMIC);

	return count;
}

/* entry and exit-points of this driver */

module_init (snd_line6_tp_ux1_driver_init);
module_exit (snd_line6_tp_ux1_driver_exit);







------=_Part_28904_15671405.1147946152846
Content-Type: text/x-chdr; name=snd_line6_tp_ux1.h; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Attachment-Id: f_enck16n1
Content-Disposition: attachment; filename="snd_line6_tp_ux1.h"

/*
 *   Line6 TonePort UX1 (and maybe TonePort UX2) USB driver for ALSA
 *
 *
 *   Copyright (c) 2006 by Stefano D'Angelo <daste@oneonline.it>
 *
 *   Some code borrowed from
 *          USB Audio Driver for ALSA by Takashi Iwai <tiwai@suse.de>
 *          "Writing an ALSA Driver" by Takashi Iwai <tiwai@suse.de>
 *          "Linux USB Driver Basics" at http://www.linuxtecharticles.com
 *   and maybe, consequently, also from audio.c by
 *	    Alan Cox <alan@lxorguk.ukuu.org.uk>
 *	    Thomas Sailer <sailer@ife.ee.ethz.ch>
 *
 *   This program is free software; you can redistribute it and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation; either version 2 of the License, or
 *   (at your option) any later version.
 *
 *   This program is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details.
 *
 *   You should have received a copy of the GNU General Public License
 *   along with this program; if not, write to the Free Software
 *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
 *
 */

#ifndef __LINE6_TP_UX1_H_
#define __LINE6_TP_UX1_H_

#define LINE6_VENDOR_ID 0x0e41
#define LINE6_TP_UX1_PID 0x4141

/* obscure control messages */
#define LINE6_TP_UX1_MSG_1 {0x40, 0x67, 0x01, 0x02, 0x02, 0x00, 0x00, 0x00}
#define LINE6_TP_UX1_MSG_2 {0x00, 0x03, 0x01, 0x00, 0x00, 0x00, 0x00, 0x00}
#define LINE6_TP_UX1_MSG_3 {0x40, 0x67, 0x01, 0x08, 0x00, 0x00, 0x00, 0x00}
#define LINE6_TP_UX1_MSG_4 {0x40, 0x67, 0x01, 0x03, 0x00, 0x00, 0x00, 0x00}

/* internal volume representation */
#define LINE6_TP_UX1_VOL_MIN 0
#define LINE6_TP_UX1_VOL_MAX 100

/* 48 kHz, 16-bits */
#define LINE6_TP_UX1_48000_16_ALTSETTING        1
#define LINE6_TP_UX1_48000_16_PACKET_SIZE_OUT 192
#define LINE6_TP_UX1_48000_16_PACKET_SIZE_IN  200

/* 44.1 kHz, 16-bits, not yet implemented */
#define LINE6_TP_UX1_44100_16_ALTSETTING        2
#define LINE6_TP_UX1_44100_16_PACKET_SIZE_OUT 180
#define LINE6_TP_UX1_44100_16_PACKET_SIZE_IN  188

/* 48 kHz, 24-bits */
#define LINE6_TP_UX1_48000_24_ALTSETTING        3
#define LINE6_TP_UX1_48000_24_PACKET_SIZE_OUT 288
#define LINE6_TP_UX1_48000_24_PACKET_SIZE_IN  300

/* 44.1 kHz, 24-bits, not yet implemented */
#define LINE6_TP_UX1_44100_24_ALTSETTING        4
#define LINE6_TP_UX1_44100_24_PACKET_SIZE_OUT 270
#define LINE6_TP_UX1_44100_24_PACKET_SIZE_IN  282

/* urb list struct */
struct urb_list {
	struct urb *urb;
	struct urb_list *next;
};

/* chip struct */
struct snd_line6_tp_ux1 {
	int index;			/* device index */

	struct usb_device *dev;
	snd_card_t *card;
	snd_pcm_t *pcm;

	int altsetting;			/* current altsetting */

	unsigned int playback_pos;	/* buffer position in frames */

	struct urb_list *pending_playback_urbs;
	struct urb_list *last_pending_playback_urb;
};

/* function prototypes */
static int snd_line6_tp_ux1_driver_init ();
static void snd_line6_tp_ux1_driver_exit ();

static int snd_line6_tp_ux1_probe (struct usb_interface *intf,
                                   const struct usb_device_id *id);
static int snd_line6_tp_ux1_create (struct usb_device *dev, int idx);
static int snd_line6_tp_ux1_init_msgs (struct usb_device* dev);
static int snd_line6_tp_ux1_new_pcm (struct snd_line6_tp_ux1 *chip);
static void snd_line6_tp_ux1_disconnect (struct usb_interface *intf);
static int snd_line6_tp_ux1_free (struct snd_line6_tp_ux1 *chip_ptr);
static int snd_line6_tp_ux1_dev_free (snd_device_t *device);

static int snd_line6_tp_ux1_submit_control_transfer (struct usb_device* dev,
                                                     unsigned char* packet);
static void snd_line6_tp_ux1_complete_control_transfer (struct urb* urb,
                                                        struct pt_regs* regs);
static void snd_line6_tp_ux1_complete_playback_transfer (struct urb* urb,
                                                         struct pt_regs* regs);
static void snd_line6_tp_ux1_complete_playback_unlink (struct urb* urb,
                                                       struct pt_regs* regs);

static int snd_line6_tp_ux1_playback_open (snd_pcm_substream_t *substream);
static int snd_line6_tp_ux1_playback_close (snd_pcm_substream_t *substream);
static int snd_line6_tp_ux1_pcm_hw_params (snd_pcm_substream_t *substream,
                                           snd_pcm_hw_params_t *hw_params);
static int snd_line6_tp_ux1_pcm_hw_free (snd_pcm_substream_t *substream);
static int snd_line6_tp_ux1_pcm_prepare (snd_pcm_substream_t *substream);
static int snd_line6_tp_ux1_pcm_trigger (snd_pcm_substream_t *substream,
                                         int cmd);
static snd_pcm_uframes_t snd_line6_tp_ux1_pcm_pointer (
                                               snd_pcm_substream_t* substream);

#endif  /* __LINE6_TP_UX1_H_ */







------=_Part_28904_15671405.1147946152846--


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
