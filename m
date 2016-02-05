From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: ALSA: hda - hdmi: Do not expose eld data when eld
	is invalid
Date: Fri, 5 Feb 2016 09:05:15 +0300
Message-ID: <20160205060515.GA18705@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by alsa0.perex.cz (Postfix) with ESMTP id E7BEA2605C6
 for <alsa-devel@alsa-project.org>; Fri,  5 Feb 2016 07:05:23 +0100 (CET)
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
To: david.henningsson@canonical.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello David Henningsson,

The patch 68e03de98507: "ALSA: hda - hdmi: Do not expose eld data
when eld is invalid" from Feb 19, 2013, leads to the following static
checker warning:

	sound/pci/hda/patch_hdmi.c:460 hdmi_eld_ctl_get()
	error: __memcpy() 'eld->eld_buffer' too small (256 vs 512)

sound/pci/hda/patch_hdmi.c
   437  static int hdmi_eld_ctl_get(struct snd_kcontrol *kcontrol,
   438                          struct snd_ctl_elem_value *ucontrol)
   439  {
   440          struct hda_codec *codec = snd_kcontrol_chip(kcontrol);
   441          struct hdmi_spec *spec = codec->spec;
   442          struct hdmi_spec_per_pin *per_pin;
   443          struct hdmi_eld *eld;
   444          int pin_idx;
   445  
   446          pin_idx = kcontrol->private_value;
   447          per_pin = get_pin(spec, pin_idx);
   448          eld = &per_pin->sink_eld;
   449  
   450          mutex_lock(&per_pin->lock);
   451          if (eld->eld_size > ARRAY_SIZE(ucontrol->value.bytes.data)) {

In the original code we always copied ELD_MAX_SIZE (256) bytes.  Now it
looks like we can copy up to 512 bytes which seems like an information
leak.  I don't know where eld->eld_size is set so I can't say if this is
a real issue or not.  Perhaps it's always a valid value.

   452                  mutex_unlock(&per_pin->lock);
   453                  snd_BUG();
   454                  return -EINVAL;
   455          }
   456  
   457          memset(ucontrol->value.bytes.data, 0,
   458                 ARRAY_SIZE(ucontrol->value.bytes.data));
   459          if (eld->eld_valid)
   460                  memcpy(ucontrol->value.bytes.data, eld->eld_buffer,
   461                         eld->eld_size);
   462          mutex_unlock(&per_pin->lock);
   463  
   464          return 0;
   465  }

regards,
dan carpenter
