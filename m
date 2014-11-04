From: Chris J Arges <chris.j.arges@canonical.com>
Subject: Re: [PATCH 4/4 v4] ALSA: usb-audio: Scarlett mixer
 interface for 6i6, 18i6, 18i8 and 18i20
Date: Tue, 04 Nov 2014 14:18:43 -0600
Message-ID: <545934A3.4010600@canonical.com>
References: <s5hd29ac9qn.wl-tiwai@suse.de>
 <1415055496-11151-1-git-send-email-chris.j.arges@canonical.com>
 <1415055496-11151-5-git-send-email-chris.j.arges@canonical.com>
 <54593304.8080701@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id EB808260627
 for <alsa-devel@alsa-project.org>; Tue,  4 Nov 2014 21:18:47 +0100 (CET)
In-Reply-To: <54593304.8080701@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>, alsa-devel@alsa-project.org
Cc: tiwai@suse.de, th55@gmx.de, robin@gareus.org, clemens@ladisch.de
List-Id: alsa-devel@alsa-project.org



On 11/04/2014 02:11 PM, David Henningsson wrote:
> 
> 
> On 2014-11-03 23:58, Chris J Arges wrote:
>> This code contains the Scarlett mixer interface code that was originally
>> written by Tobias Hoffman and Robin Gareus. Because the device doesn't
>> properly implement UAC2 this code adds a mixer quirk for the device.
> 
> Thanks a lot for taking over - it surely has been done with better speed
> than I would have.
> 
>> + *   Code cleanup:
>> + *   David Henningsson <david.henningsson at canonical.com>
> 
> Thanks for the credit, not sure I deserve it though, all I did was to
> squash the patches and fix the checkpatch errors :-)
> 
: )

>> +static int scarlett_ctl_save_put(struct snd_kcontrol *kctl,
>> +                 struct snd_ctl_elem_value *ucontrol)
>> +{
>> +    struct usb_mixer_elem_info *elem = kctl->private_data;
>> +    struct snd_usb_audio *chip = elem->mixer->chip;
>> +    char buf[] = { 0x00, 0xa5 };
>> +    int err;
>> +
>> +    if (ucontrol->value.enumerated.item[0] > 0) {
>> +        err = snd_usb_ctl_msg(chip->dev,
>> +            usb_sndctrlpipe(chip->dev, 0), UAC2_CS_MEM,
>> +            USB_RECIP_INTERFACE | USB_TYPE_CLASS |
>> +            USB_DIR_OUT, 0x005a, snd_usb_ctrl_intf(chip) |
>> +            (0x3c << 8), buf, 2);
>> +        if (err < 0)
>> +            return err;
>> +
>> +        usb_audio_info(elem->mixer->chip,
>> +             "scarlett: saved settings to hardware.\n");
>> +    }
>> +    return 0;
>> +}
> 
> To elaborate on Takashi's concern about this control, imagine e g what
> alsactl restore/store being run on startup/shutdown. On shutdown,
> alsactl store would read "0", and on startup, alsactl restore would
> write "0", with the result that the hw would not store the values set.
> 
> Would it be possible to have an autosave instead? E g, whenever a value
> is changed, it saves that value to the hardware. That's how other
> hardware works and what userspace expects.
> If you want to avoid a lot of autosaves, e g if the autosave takes a lot
> of time before the hw responds, maybe you could do the autosave in a 10
> ms delayed_work, or similar.
> 

David,
Hey, as Tobias mentioned this is a HW saving (to the mixer's NVRAM)
function used for using the mixer disconnected from a computer. We
wouldn't want to continually write the NVRAM on every control update as
I'm unsure of how many write-cycles the device is capable of.

So without it you can still plug the mixer into the computer and alsa
will restore any saved settings automatically. I'm planning on dropping
the HW Save in v5 until we can figure out a proper control mechanism for
this.

--chris
