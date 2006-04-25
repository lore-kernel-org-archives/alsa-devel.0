From: Matthias Koenig <list@phasorlab.de>
Subject: Re: [PATCH] Support for ESI Miditerminal 4140
Date: Tue, 25 Apr 2006 11:49:11 +0200
Message-ID: <87wtde56js.fsf@zebra.localdomain>
References: <87wtdeevlh.fsf@zebra.localdomain> <s5hbquq266i.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

Thank you for review!

Takashi Iwai <tiwai@suse.de> writes:
> At Mon, 24 Apr 2006 19:23:22 +0200,
> Matthias Koenig wrote:
[...]
>> +config SND_MTS64
>> +	tristate "ESI Miditerminal 4140 driver"
>> +	depends on SND && PARPORT
>> +	select SND_RAWMIDI
>> +	help
>> +	  Say 'Y' or 'M' to include support for Miditerminal 4140.
>
> A bit more explanative, please.

Ok

>> +static char* id[SNDRV_CARDS]   = SNDRV_DEFAULT_STR;
>
> Please use a normal C-style, char *id[].

Ok

>> +	snd_rawmidi_substream_t* midi_input_substream[MTS64_NUM_INPUT_PORTS];
>
> We removed xxx_t typedefs.  Use struct instead.

Ok. Sorry, this has been already on my plan, I don't know why forgot 
about it.

[...]
>> +	mts->smpte_switch = 0;
>> +	mts->time[0] = 0;
>> +	mts->time[1] = 0;
>> +	mts->time[2] = 0;
>> +	mts->time[3] = 0;
>> +	mts->fps = 0;
>
> You can omit zero-initializations above.

Ok

[...]
> Space after 'for' and spaces between '=' are preferred.
> Keep the coding style found in linux/Documentation/CodingStyle.

Ok

>> +static int mts64_device_init(struct parport* p)
>> +{
>> +	int i;
>> +
>> +	mts64_write_command(p, MTS64_CMD_RESET);
>> +
>> +	for(i=0; i < 64; ++i) {
>> +		mdelay(100);
>
> Such a long delay in local_irq_disable()?
>
>> +	/* FIXME: Busy wait really necessary? */
>> +	mdelay(50);
>
> Ditto.  A too long delay in irq_disable context.

Yes, these long delays have caused me some bellyache.
I got the information about the device from reverse engineering the Windows
driver and the delay times are exactly taken from there (actually there is a
function which repeatedly calls KeStallExecutionProcessor with an argument 
of 50us until the given time is elapsed).
I will try to find a better solution. Maybe some additional state variable
which will be triggered by a timer. Also most of the delays are happening
in process context, so it might be possible to sleep. At least it will be
possible for the open/close callbacks.
I'll rework those sections.

[...]
>> +	} else if(mts->open_count < 0) {
>> +		mts->open_count = 0;
>> +	}
>
> Should omit braces for a single line after 'if'.

Ok

>> +
>> +	/* FIXME: Busy wait really necessary? */
>> +	mdelay(500);
>
> A too long delay in irq_disable.

s.a.

[...]
>> +static unsigned char mts64_map_midi_input(unsigned char c)
>> +{
>> +	unsigned char map[] = { 0, 1, 4, 2, 3 };
>
> Should be static char array.

Ok

[...]
>> +static int mts64_probe(struct parport* p)
>> +{
>> +	unsigned char c;
>> +
>> +	mts64_smpte_stop(p);
>> +
>> +	mts64_write_command(p, MTS64_CMD_PROBE);
>> +
>> +	/* FIXME */
>> +	mdelay(50);
>
> Possible to replace with msleep()?

This might be an option. 

[...]
>> +	if(c != MTS64_CMD_PROBE) return 0;
>> +	else return 1;
>
> Break lines.

Ok

>> +static void mts64_smpte_start(struct parport* p,
>> +			      unsigned char hours, unsigned char minutes,
>> +			      unsigned char seconds, unsigned char frames,
>> +			      unsigned char idx)
>> +{
>> +	unsigned char fps[5] = { MTS64_CMD_SMPTE_FPS_24, 
>> +				 MTS64_CMD_SMPTE_FPS_25,
>> +				 MTS64_CMD_SMPTE_FPS_2997, 
>> +				 MTS64_CMD_SMPTE_FPS_30D,
>> +				 MTS64_CMD_SMPTE_FPS_30    };
>
> Use a static array.

Ok

[...]
>> +	/* check current midiport */
>> +	if(mts->current_midi_output_port != midiport) {
>> +		mts64_write_command(p, midiport);
>> +	}
>
> Remove braces around a single if line.

OK


[...]
>> +/* SMPTE Switch */
>> +static int snd_mts64_ctl_smpte_switch_info(snd_kcontrol_t *kctl,
>> +					   snd_ctl_elem_info_t* uinfo)
>
> Use struct snd_kcontrol and struct snd_ctl_elem_info.
> (For checking the obsolete typedefs, comment out the inclusion of
> "typedefs.h" in adriver.h.)

Ok, removed all typedefs
>
>> +
>> +static snd_kcontrol_new_t mts64_ctl_smpte_switch __devinitdata = {
>
> Use struct snd_kcontrol_new.

Ok
>
>> +	.iface = SNDRV_CTL_ELEM_IFACE_RAWMIDI,
>> +	.name  = "SMPTE Playback Switch",
>> +	.index = 0,
>> +	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
>> +	.private_value = 0,
>> +	.info = snd_mts64_ctl_smpte_switch_info,
>> +	.get  = snd_mts64_ctl_smpte_switch_get,
>> +	.put  = snd_mts64_ctl_smpte_switch_put
>> +};
>> +/* FPS */
>> +static int snd_mts64_ctl_smpte_fps_info(snd_kcontrol_t* kctl,
>> +					snd_ctl_elem_info_t* uinfo)
>> +{
>> +	char* texts[5] = { "24",
>> +			   "25",
>> +			   "29.97",
>> +			   "30D",
>> +			   "30"    };
>
> Use a static array.

OK
>
>> +static void mts64_interrupt(int irq, void* private, struct pt_regs* r)
>> +{
>> +	struct mts64* mts = ((struct snd_card*)private)->private_data;
>> +	unsigned long flags;
>> +	unsigned short ret;
>> +	unsigned char status, data;
>> +	snd_rawmidi_substream_t* substream;
>> +
>> +	spin_lock_irqsave(mts->lock, flags);
>
> You need to irqsave/restore in the interrupt handler.

I'm not sure if I understand your point here.
This is what I already do. Do you mean "you _don't_ need to 
irqsave/restore ..."?

thanks,
Matthias


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
