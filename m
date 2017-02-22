From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [bug report] ALSA: usb-audio: Tascam US-16x08 DSP
	mixer quirk
Date: Wed, 22 Feb 2017 21:46:49 +0300
Message-ID: <20170222184649.GA589@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by alsa0.perex.cz (Postfix) with ESMTP id 4FAB7266E3A
 for <alsa-devel@alsa-project.org>; Wed, 22 Feb 2017 19:47:31 +0100 (CET)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: Detlef Urban <onkel@paraair.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello Detlef Urban,

This is a semi-automatic email about new static checker warnings.

The patch d2bb390a2081: "ALSA: usb-audio: Tascam US-16x08 DSP mixer 
quirk" from Feb 20, 2017, leads to the following Smatch complaint:

sound/usb/mixer_us16x08.c:716 snd_us16x08_meter_get()
	 warn: variable dereferenced before check 'elem' (see line 711)

sound/usb/mixer_us16x08.c
   710		struct usb_mixer_elem_info *elem = kcontrol->private_data;
   711		struct snd_usb_audio *chip = elem->head.mixer->chip;
                                             ^^^^^^^^^^^^^^^^^^^^^^
Dereference.

   712		struct snd_us16x08_meter_store *store = elem->private_data;
   713		u8 meter_urb[64];
   714		char tmp[max(sizeof(mix_init_msg1), sizeof(mix_init_msg2))];
   715	
   716		if (elem) {
                    ^^^^
Check.

   717			store = (struct snd_us16x08_meter_store *) elem->private_data;
   718			chip = elem->head.mixer->chip;

regards,
dan carpenter
