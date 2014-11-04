From: Tobias Hoffmann <th55@gmx.de>
Subject: Re: [PATCH 4/4 v4] ALSA: usb-audio: Scarlett mixer
 interface for 6i6, 18i6, 18i8 and 18i20
Date: Tue, 04 Nov 2014 14:16:13 +0100
Message-ID: <5458D19D.7050206@gmx.de>
References: <s5hd29ac9qn.wl-tiwai@suse.de>
 <1415055496-11151-1-git-send-email-chris.j.arges@canonical.com>
 <1415055496-11151-5-git-send-email-chris.j.arges@canonical.com>
 <s5hppd39sm8.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
 by alsa0.perex.cz (Postfix) with ESMTP id 0B9762605E3
 for <alsa-devel@alsa-project.org>; Tue,  4 Nov 2014 14:16:33 +0100 (CET)
In-Reply-To: <s5hppd39sm8.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, robin@gareus.org, clemens@ladisch.de, david.henningsson@canonical.com, Chris J Arges <chris.j.arges@canonical.com>
List-Id: alsa-devel@alsa-project.org

> +#define TXT_OFF	"Off"
> +#define TXT_PCM(num) "PCM " #num
> +#define TXT_ANALOG(num) "Analog " #num
> +#define TXT_SPDIF(num) "SPDIF " #num
> +#define TXT_ADAT(num) "ADAT " #num
> +#define TXT_MIX(letter) "MIX " #letter

My reasoning for using:
   static const char txtOff[] = "Off",
           txtPcm1[] = "PCM 1", txtPcm2[] = "PCM 2",
           txtPcm3[] = "PCM 3", txtPcm4[] = "PCM 4",  [...]
instead of repeating the strings for each device (or using macros that 
expand to the same strings) was that the final .o / .ko would contain 
the string data only once.

But maybe (as Clemens suggested) the strings *for .opt_master and 
.opt_matrix* should just be created dynamically in 
scarlett_ctl_enum_info, instead of using snd_ctl_enum_info.
I want to point out that scarlett_device_info already contains the 
necessary information to do this:

	.matrix_out = 6,
...
	.pcm_start = 0,  // pcm(1) .. pcm(analog_start-pcm_start)=pcm(12)
	.analog_start = 12, // analog(1) .. analog(4)
	.spdif_start = 16, // spdif(1) .. spdif(2)
	.adat_start = 18,  // adat(1) .. adat(0)  [i.e. no adat]
	.mix_start = 18, // mix('A') .. mix('F')=mix('A' + matrix_out)



and Off(-1). Only elem->private_data has to be of type 
scarlett_mixer_elem_enum_info for the usual enums (impedance, pad, ...), 
but of type scarlett_device_info for the master and mixer enums...

Some more comments inline:

On 04/11/14 11:18, Takashi Iwai wrote:
> The new patch looks almost good. A remaining concern is:
>> +static const struct scarlett_mixer_elem_enum_info opt_save = {
>> +	.start = 0,
>> +	.len = 2,
>> +	.names = (const char * const[]){
>> +		"---", "Save"
> This isn't quite intuitive.  And I think this is an abuse of ctl
> enum (see below).
It's a hack to expose the "Save to hardware" functionality without 
requiring a special mixer application. Robin's original patch already 
contained this (ab)use.


> Also...
>
>> +static int scarlett_ctl_enum_get(struct snd_kcontrol *kctl,
>> +				 struct snd_ctl_elem_value *ucontrol)
>> +{
>> +	struct usb_mixer_elem_info *elem = kctl->private_data;
>> +	struct scarlett_mixer_elem_enum_info *opt = elem->private_data;
>> +	int err, val;
>> +
>> +	err = snd_usb_get_cur_mix_value(elem, 0, 0,&val);
>> +	if (err<  0)
>> +		return err;
>> +
>> +	if ((opt->start == -1)&&  (val>  opt->len)) /*>= 0x20 */
>> +		val = 0;
>> +	else
>> +		val = clamp(val - opt->start, 0, opt->len-1);
> Is the if condition above really correct?  It's not obvious to me what
> this really checks.

(opt->start == -1) is used in enums that control the routing, to 
represent the "Off"-value.
But the device uses number_of_master_enum_values+1 (even for the matrix 
enum) as "Off".
That would make "Off" the last enum value in Mixer applications, which 
is undesired (and, for the matrix enums, this still results in a gap 
between last_matrix_enum_index and Off=last_mixer_enum_index).

scarlett_ctl_enum_put did contain the inverse logic (before cleanup):

> #if 0 // TODO?
>         if (val == -1) {
>                 val = elem->enum->len + 1; /* only true for master, 
> not for mixer [also master must be used] */
>                 // ... or? > 0x20,  18i8: 0x22
>         } else
> #endif
>         val = val + elem->opt->start;

It is commented out, because the device also recognized val = -1 + -1; 
as "Off", without the need to somehow expose the device-specific 
enum->len of .opt_master to all the .opt_matrix controls.
It's a bit dirty, but it works...


> Now back to "save to hw" ctl:
>
>> +static int scarlett_ctl_save_get(struct snd_kcontrol *kctl,
>> +				 struct snd_ctl_elem_value *ucontrol)
>> +{
>> +	ucontrol->value.enumerated.item[0] = 0;
>> +	return 0;
>> +}
> So, here is the problem.  You want to use this ctl to trigger
> something.  This is no correct behavior for an enum ctl.
> If the put callback succeeds, the value should be stored.
> (Of course, then it won't work as you expected.)
>
> What actually this control does?  Why it can't be done always
> (transparently)?

What it does is it store the current settings in non-volatile memory for 
standalone operation (i.e. USB not connected). It's the device 
configuration after power-on.

Loading this driver then reinitalizes the device to basically zero 
values (userspace "acontrol restore" will finally set the device to what 
the user expects).
The zeroing is unfortunately necessary, because the device does not 
support reading back certain mixer values after power-on (only garbage 
is returned). After initialization, only cval->cache_val is ever 
returned by snd_usb_get_cur_mix_value.


>> +static int scarlett_ctl_save_put(struct snd_kcontrol *kctl,
>> +				 struct snd_ctl_elem_value *ucontrol)
>> +{
>> +	struct usb_mixer_elem_info *elem = kctl->private_data;
>> +	struct snd_usb_audio *chip = elem->mixer->chip;
>> +	char buf[] = { 0x00, 0xa5 };
>> +	int err;
>> +
>> +	if (ucontrol->value.enumerated.item[0]>  0) {
>> +		err = snd_usb_ctl_msg(chip->dev,
>> +			usb_sndctrlpipe(chip->dev, 0), UAC2_CS_MEM,
>> +			USB_RECIP_INTERFACE | USB_TYPE_CLASS |
>> +			USB_DIR_OUT, 0x005a, snd_usb_ctrl_intf(chip) |
>> +			(0x3c<<  8), buf, 2);
>> +		if (err<  0)
>> +			return err;
>> +
>> +		usb_audio_info(elem->mixer->chip,
>> +			 "scarlett: saved settings to hardware.\n");
> Using *_info() here is rather annoying, it may spew too many random
> messages.
OTOH, saving the settings to hardware should be a rare operation (the 
non-volatile memory might also be  designed to withstand only a limited 
amount of read-write cycles).

@Chris:
The original get_ctl_value (after cleanup: snd_usb_get_cur_mix_value) 
contained this:
>         // quirk: write 2bytes, but read 1byte
>         if ( (elem->index == 0x01)||  //  input impedance and input 
> pad switch
>              ((elem->index == 0x0a)&&(elem->wValue < 0x0200))|| // bus 
> mutes
>              (elem->index == 0x32)||(elem->index == 0x33) ) { // mux
>                 val_len = 1;
>         }
Is it removed(AFAICT) intentionally in your patches?
The windows mixer software did read-back some values (but only after 
they had been written once, IIRC), and had this asymmetry that certain 
registers used 2-byte writes but 1-byte reads...
I'm quite unsure about just reading 2 bytes, i.e. whether the device 
would actually return the correct values.
OTOH, we should only hit the cache because of the zero-initialization(?).

   Tobias
