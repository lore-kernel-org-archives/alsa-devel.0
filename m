From: Manuel Jander <manuel.jander@gmail.com>
Subject: Re: Volume per voices [Feature Request]
Date: Mon, 29 Aug 2005 23:04:50 +0200
Message-ID: <1125349490.6887.13.camel@localhost.localdomain>
References: <s5hll3slj32.wl%tiwai@suse.de>
	 <Pine.HPX.4.33n.0507271709230.25935-100000@studcom.urz.uni-halle.de>
	 <42E889DD.2070808@netvigator.com>
	 <Pine.LNX.4.61.0507281032400.8458@tm8103.perex-int.cz>
	 <42ECFE46.9070201@netvigator.com> <s5h7jf69fkp.wl%tiwai@suse.de>
	 <431272DE.1090901@netvigator.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <431272DE.1090901@netvigator.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa-devel list <alsa-devel@lists.sourceforge.net>
Cc: Raymond <rayau@netvigator.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On Mon, 2005-08-29 at 10:28 +0800, Raymond wrote:
> Takashi Iwai wrote:
> > At Mon, 01 Aug 2005 00:37:26 +0800,
> > Raymond wrote:
> > 
> >>Jaroslav Kysela wrote:
> >>
> >>>On Thu, 28 Jul 2005, Raymond wrote:
> Can this kind of volume control with iface = SNDRV_CTL_ELEM_IFACE_PCM
> used by mixer application (e.g. alsamixer) or only the application which
> open the PCM substream ?

I guess not, because its PCM specific, and only valid on a PCM device
open context. Trying to find out which app is opening which PCM device
is just nonsense.

> Distortion occur when the combined gain of audio data, hardware mixer ,
> equalizer and 3D effect > 6dB ( limit by the 18-bits DAC in AC97 codec)

The maximum gain possible for a entire audio pipe should obvisouly not
exceeded.

> Can negative number can be used in the kcontrol with type
> SNDRV_CTL_ELEM_TYPE_INTEGER ? (i.e. uinfo->value.integer.min < 0 )

AFAIK, yes.

> What is the maximum value can be assigned to uinfo->value.integer.max ?

> In the ALSA au88x0 driver, the hardware mixer provide default gain of
> 6dB ( 16-bits auido data to 18-bits DAC in AC97 codec ) for the
> left/right channels of au8820 and the rear channels of au8810/au8830 (to 
> SDAC of quad codec),
> 
> For the front channels of au8810/au8830, zero gain in hardware mixer and
> this 6dB gain is most likely controlled by the equalizer or 3D effect.
> 
> Is there any faster method to find the substream of the subdevice in
> snd_vortex_adb_pcm_vol_put ?
> 
> struct snd_vortex {
> 
> ...
> 	snd_kcontrol_t *ctl_pcm_vol[NR_ADB];
> 	int mixin[NR_ADB][4];		/* MIXIN */
>          int pcm_vol[NR_ADB][4];         /* PCM VOLUME */
> ...
> 
> }
> 
> static int snd_vortex_adb_pcm_vol_info(snd_kcontrol_t *kcontrol,
> snd_ctl_elem_info_t * uinfo)
> {
> 	vortex_t *vortex = snd_kcontrol_chip(kcontrol);
> 	uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
> 	uinfo->count = (VORTEX_IS_QUAD(vortex) ? 4 : 2);
> 	uinfo->value.integer.min = 0;
> 	uinfo->value.integer.max = 255;
> 	return 0;
> }
> 
> static int snd_vortex_adb_pcm_change_vol(vortex_t *vortex,int mixin,int
> mix,int volume)
> {
> 	if ( volume >= 128 )
> 		vortex_mix_setinputvolumebyte(vortex, mix, mixin, volume-128);    // GAIN
> GAIN
> 	else
> 		vortex_mix_setinputvolumebyte(vortex, mix, mixin, volume+128);    // ATTEN
> ATTEN
> 	return 0;
> }

I would suggest using the correct signed or unsigned type instead of
doing explicit type conversions.

> static int snd_vortex_adb_pcm_vol_get(snd_kcontrol_t * kcontrol,
> snd_ctl_elem_value_t * ucontrol)
> {
> 	int i,subdevice;
> 	vortex_t *vortex = snd_kcontrol_chip(kcontrol);
> 	subdevice = kcontrol->id.subdevice;
> 	for (i=0; i<(VORTEX_IS_QUAD(vortex) ? 4 : 2 ); i++)
> 		ucontrol->value.integer.value[i] = vortex->pcm_vol[subdevice][i];	
> 	return 0;
> }

As the resource manager is written now, there is no other way to do
this. Any attempt to speed up would make the whole thing more complex,
and in opinion is not required. iterating 32 or 64 times in a short loop
on current PC is not a significant worload.

> static int snd_vortex_adb_pcm_vol_put(snd_kcontrol_t * kcontrol,
> snd_ctl_elem_value_t * ucontrol)
> {
> 	int i,j,changed,subdevice;
> 	vortex_t *vortex = snd_kcontrol_chip(kcontrol);
> 	subdevice=kcontrol->id.subdevice;
> 	changed = 0;
> 	if ( ( kcontrol->vd[0].access & SNDRV_CTL_ELEM_ACCESS_INACTIVE ) == 0 ) {
> 		for (i=0; i<NR_ADB; i++) {
> 			if ( vortex->dma_adb[i].substream != NULL ) {
> 				if ( vortex->dma_adb[i].substream->number == subdevice ) {
> 					for (j=0; j<(VORTEX_IS_QUAD(vortex) ? 4 : 2 ); j++) {
> 						if ( vortex->pcm_vol[subdevice][j] !=
> ucontrol->value.integer.value[j] )
> 							changed=1;
> 						vortex->pcm_vol[subdevice][j] = ucontrol->value.integer.value[j];
> 					};
> 					switch(vortex->dma_adb[i].nr_ch) {
> 					case 1:
> 						for (j=0; j<(VORTEX_IS_QUAD(vortex) ? 4 : 2 ); j++) {
> 							snd_vortex_adb_pcm_change_vol(vortex,
> vortex->mixin[subdevice][0], vortex->mixplayb[j],
> vortex->pcm_vol[subdevice][j]);
> 						};
> 						break;
> 					case 2:
> 						for (j=0; j<2; j++) {
> 							snd_vortex_adb_pcm_change_vol(vortex,
> vortex->mixin[subdevice][j], vortex->mixplayb[j],
> vortex->pcm_vol[subdevice][j]);
> 							if (VORTEX_IS_QUAD(vortex))
> 								snd_vortex_adb_pcm_change_vol(vortex,
> vortex->mixin[subdevice][j], vortex->mixplayb[j+2],
> vortex->pcm_vol[subdevice][j+2]);
> 						};
> 						break;
> 					case 4:
> 						for (j=0; j<4; j++) {
> 							snd_vortex_adb_pcm_change_vol(vortex,
> vortex->mixin[subdevice][j], vortex->mixplayb[j],
> vortex->pcm_vol[subdevice][j]);
> 						};
> 						break;
> 					};
> 					return changed;
> 				};
> 			};
> 		};
> 	};
> 	return changed;
> }

I have not much time right now, but the switch statement looked to me
somewhat redundant (?).

> static snd_kcontrol_new_t snd_vortex_adb_pcm_vol = {
> 	.iface =	SNDRV_CTL_ELEM_IFACE_PCM,
> 	.name =		"ADB PCM Volume",
> 	.access = 	SNDRV_CTL_ELEM_ACCESS_READWRITE |
> SNDRV_CTL_ELEM_ACCESS_INACTIVE,
> 	.info =		snd_vortex_adb_pcm_vol_info,
> 	.get =		snd_vortex_adb_pcm_vol_get,
> 	.put =		snd_vortex_adb_pcm_vol_put,
> };
> 
> 
> Do we need to make the front and rear channels of au8810/au8830 with
> equal default gain and equal volume range ? e.g. Adding mixer between
> equalizer and AC97 and a switch to allow each substream to bypass
> equalizer, the other way is to set equalizer in bypass mode for all
> substreams.

There is no need to waste any more mixers (there are a very precious
resource and its easy to run out of them). The EQ has a global gain
control, which should used instead.

> 
> au8810/au8830
>                                     (6db)
> Front channels          +----------MIXER-------------+
>                          |                            |
>                          |(0dB)     (6dB)       (0dB) |
>     DMA -> FIFO -> SRC -> MIXER -> Equalizer -> MIXER -> AC97
>                 |           |
>                 |           +--------------------------> SPDIF
>                 |
> Rear channels  +--SRC -----------> MIXER -------------> SDAC
>                                     (6dB)

SPDIF should not pass through SRC's. It should go strait from the FIFO
if possible. Only if the samplerate is something odd and the audio
format is stereo, maybe a SRC should be connected in between.

Nice work you are doing. Thank you very much for keeping this going ;)

Best Regards
Manuel




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
