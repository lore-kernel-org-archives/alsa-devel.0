From: Joachim Falk <joachim.falk@gmx.de>
Subject: Re: Some Patches for emu10k1
Date: Wed, 16 Jun 2004 00:18:06 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40CF759E.7050102@jfalk.easynet.de>
References: <200406080807.i58878cb012056@www4.pobox.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200406080807.i58878cb012056@www4.pobox.sk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Peter Zubaj <pzad@pobox.sk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Peter Zubaj wrote:
|Joachim Falk wrote:
|>The following is a question I asked on IRC channel
|
| AFAIK there is no other documentation. (best is driver source)
How inconvenient.
|>I am especcially interested what this emu10k1 registers do.

| They are mostly used in midi synth, some of them are exported as mixer
| controls.
That I allready did assume, nice to know for good. But I selected this
registeres especially because I assumed they where the ones responsible
for PCM send routing and some could be used to control the amplitude
which witch the channel is transmited to the FX Channels.

Ok after some more driver research and expirimentation I can say
that all following registers are per channel (There are 64 of them in
the EMU10K1).

#define FXRT			0x0b		/* Effects send routing register			*/
						/* NOTE: It is illegal to assign the same routing to	*/
						/* two effects sends.					*/
#define FXRT_CHANNELA		0x000f0000	/* Effects send bus number for
channel's effects send A	*/
#define FXRT_CHANNELB		0x00f00000	/* Effects send bus number for
channel's effects send B	*/
#define FXRT_CHANNELC		0x0f000000	/* Effects send bus number for
channel's effects send C	*/
#define FXRT_CHANNELD		0xf0000000	/* Effects send bus number for
channel's effects send D	*/

With FXRT one can select 4 destination FX buses for the channel data to
be send to. But they must all be different ones or the FX bus which
appears more than once in FXRT won't receive any data.

Control is 'EMU10K1 PCM Send Routing' it has 12 Values
#00: FX Target A, if the corresponding PCM stream is a mono
#01: FX Target B, if the corresponding PCM stream is a mono
#02: FX Target C, if the corresponding PCM stream is a mono
#03: FX Target D, if the corresponding PCM stream is a mono
#04: FX Target A for left, if the corresponding PCM stream is stereo
#05: FX Target B for left, if the corresponding PCM stream is stereo
#06: FX Target C for left, if the corresponding PCM stream is stereo
#07: FX Target D for left, if the corresponding PCM stream is stereo
#08: FX Target A for right, if the corresponding PCM stream is stereo
#09: FX Target B for right, if the corresponding PCM stream is stereo
#10: FX Target C for right, if the corresponding PCM stream is stereo
#11: FX Target D for right, if the corresponding PCM stream is stereo

amixer sset 'EMU10K1 PCM Send Routing',0 \
#0,#1,#2,#3,#4,#5,#6,#7,#8,#9,#10,#11,#12

#define VTFT			0x03		/* Volume target and filter cutoff target register	*/
#define VTFT_VOLUMETARGET_MASK	0xffff0000	/* Volume target of
specified channel			*/
#define VTFT_VOLUMETARGET	0x10100003

Than there is the VTFT register which acts as a master volum slider for
this channel.

Control is 'EMU10K1 PCM Volume' it has 3 Values
#0: Volume, if the corresponding PCM stream is a mono stream
#1: Volume left, if the corresponding PCM stream is a stereo stream
#2: Volume right, if the corresponding PCM stream is a stereo stream

amixer sset 'EMU10K1 PCM',0 #0,#1,#2

#define PTRX			0x01		/* Pitch target and send A/B amounts register		*/
#define PTRX_FXSENDAMOUNT_A_MASK 0x0000ff00	/* Linear level of channel
output sent to FX send bus A	*/
#define PTRX_FXSENDAMOUNT_A	0x08080001
#define PTRX_FXSENDAMOUNT_B_MASK 0x000000ff	/* Linear level of channel
output sent to FX send bus B	*/
#define PTRX_FXSENDAMOUNT_B	0x08000001

#define PSST			0x06		/* Send C amount and loop start address register	*/
#define PSST_FXSENDAMOUNT_C_MASK 0xff000000	/* Linear level of channel
output sent to FX send bus C	*/

#define PSST_FXSENDAMOUNT_C	0x08180006

#define DSL			0x07		/* Send D amount and loop start address register	*/
#define DSL_FXSENDAMOUNT_D_MASK	0xff000000	/* Linear level of channel
output sent to FX send bus D	*/

#define DSL_FXSENDAMOUNT_D	0x08180007

Than there is the PTRX, PSST and DSL register which acts as a volume
slider for the individual FX targets.

Control is 'EMU10K1 PCM Send Volume' it has 12 Values
#00: FX Target A Volume, if the corresponding PCM stream is a mono
#01: FX Target B Volume, if the corresponding PCM stream is a mono
#02: FX Target C Volume, if the corresponding PCM stream is a mono
#03: FX Target D Volume, if the corresponding PCM stream is a mono
#04: FX Target A Volume left, if the corresponding PCM stream is stereo
#05: FX Target B Volume left, if the corresponding PCM stream is stereo
#06: FX Target C Volume left, if the corresponding PCM stream is stereo
#07: FX Target D Volume left, if the corresponding PCM stream is stereo
#08: FX Target A Volume right, if the corresponding PCM stream is stereo
#09: FX Target B Volume right, if the corresponding PCM stream is stereo
#10: FX Target C Volume right, if the corresponding PCM stream is stereo
#11: FX Target D Volume right, if the corresponding PCM stream is stereo

amixer sset 'EMU10K1 PCM Send',0 \
#0,#1,#2,#3,#4,#5,#6,#7,#8,#9,#10,#11,#12


|>I assume they are per emu10k1 channel (there are 64 of them ?).
|>I think I have understood that for each PCM output stream one of this
|>channels is used (For mono 1 for stereo 2). This channels can also be
|>used for wavetable synthesis.
|
| Not exactly (as I read on alsa-devel mailing list).
Do you have maybe a reference for this E-Mail message to
make searching in the archive of alsa-devel easier ?

| for mono PCM stream 2 channels are used
| for stereo PCM stream 3 channels are used
| but from user point of view it doesn't metter.
Hmm, yes A PCM stream is defined as such
struct _snd_emu10k1_pcm {
	emu10k1_t *emu;
	snd_emu10k1_pcm_type_t type;
	snd_pcm_substream_t *substream;
	emu10k1_voice_t *voices[2]; <-- This are the channles
	emu10k1_voice_t *extra;     <-- This are the channles
	unsigned short running;
	unsigned short first_ptr;
	snd_util_memblk_t *memblk;
	unsigned int start_addr;
	unsigned int ccca_start_addr;
	unsigned int capture_ipr;	/* interrupt acknowledge mask */
	unsigned int capture_inte;	/* interrupt enable mask */
	unsigned int capture_ba_reg;	/* buffer address register */
	unsigned int capture_bs_reg;	/* buffer size register */
	unsigned int capture_idx_reg;	/* buffer index register */
	unsigned int capture_cr_val;	/* control value */
	unsigned int capture_cr_val2;	/* control value2 (for audigy)*/
	unsigned int capture_bs_val;	/* buffer size value */
	unsigned int capture_bufsize;	/* buffer size in bytes */
};
I assume a second (for mono) or third (for stereo) channel is needed for
smooth switching of channels. If the data of an pcm chunk runs out on
one channel another is maybe preloaded with the next pcm chunk and can
promptly be activated.
Not sure here as I haven't looked at this part of the code just yet.
Corrections please !

|
|
|>And than this magic send routing decides in which FX buses the
|>processed
|>stream will be targeted. Maximal 4 FX buses chan be selected per
|>channel
|>? Send bus A,B,C, and D. Is this sendbus the same for each channel
|>or can it be configured for each channel seperatly. Is it fixed
|>or can for
|>all channels globally be configured what FX bus sendbus A,B,C and
|>D is ?
|
|
| Maybe this helps you:
| http://www.mail-archive.com/alsa-devel@lists.sourceforge.net/msg11671.html
No unfortunately not. I allready found that one message, before asking
here, too.

| Can be configured via
| EMU10K1 PCM Volume
| EMU10K1 PCM Send Routing
| EMU10K1 PCM Send Volume
| controls.
|
|
|>But some FX buses seam to be connected to outputs even if there is no
|>code in the dsp. Is that hardcoded in hardware or configurable and if
|>yes where ?
|
|
| This is maybe hardware feature or ld10k1 bug. If you connect FX bus
| 0,1 to AC97 PCM output I think it will stop to do this.
This seams to be a hardware feature of the EMU10K1 I think because if
you clear the dsp code than FX bus channels 0,1 and 8,9 will be
forwarded to Output channels 0,1 and 8,9. This I can say for sure.
The others (2-7 and 10-15) I can not be sure because I have no speakers
on these channels or they are not connected to output on my card. But I
assume that to be the case too. As soon as you start driving an output
within your DSP code the forwarding seams to vanish. I think this can
not be a alsa driver feature because you can verify that the DSP really
is empty by catting /proc/asound/Live/fx8010_acode. So the alsa driver
has no possibility to magically insert some of its one forwardings if
none are programmed by the user.

|
| Peter Zubaj
| ____________________________________
| http://www.pobox.sk/ - najvacsi slovensky freemail
By the way, I try to fix myself a master slider for the Live.
But before I can do this I have to understand the EMU10k1 driver and
the alsa-libs a little bit more.

P.S.:
The amixer and alsamixer are horrible broken in regard to multivalue
controlls (>2).

Than there is the snafu that the Whole EMU10K1 controlls are inactive

static snd_kcontrol_new_t snd_emu10k1_send_routing_control =
{
	.access =	SNDRV_CTL_ELEM_ACCESS_READWRITE | SNDRV_CTL_ELEM_ACCESS_INACTIVE,
~        .iface =        SNDRV_CTL_ELEM_IFACE_MIXER,
~        .name =         "EMU10K1 PCM Send Routing",
	.count =	32,
~        .info =         snd_emu10k1_send_routing_info,
~        .get =          snd_emu10k1_send_routing_get,
~        .put =          snd_emu10k1_send_routing_put
};

static snd_kcontrol_new_t snd_emu10k1_send_volume_control =
{
	.access =	SNDRV_CTL_ELEM_ACCESS_READWRITE | SNDRV_CTL_ELEM_ACCESS_INACTIVE,
~        .iface =        SNDRV_CTL_ELEM_IFACE_MIXER,
~        .name =         "EMU10K1 PCM Send Volume",
	.count =	32,
~        .info =         snd_emu10k1_send_volume_info,
~        .get =          snd_emu10k1_send_volume_get,
~        .put =          snd_emu10k1_send_volume_put
};


static snd_kcontrol_new_t snd_emu10k1_attn_control =
{
	.access =	SNDRV_CTL_ELEM_ACCESS_READWRITE | SNDRV_CTL_ELEM_ACCESS_INACTIVE,
~        .iface =        SNDRV_CTL_ELEM_IFACE_MIXER,
~        .name =         "EMU10K1 PCM Volume",
	.count =	32,
~        .info =         snd_emu10k1_attn_info,
~        .get =          snd_emu10k1_attn_get,
~        .put =          snd_emu10k1_attn_put
};

But amixer and alsamixer displays the first ones (index 0) anyway
it seams.
Or does something in the emu10k1 driver code enable the
control with index 0 ?

MfG
Joachim Falk
- --
You can always tell a really good idea by the enemies it makes.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFAz3WeKwZcgs55jUMRAtQAAKCL/dYs79ljfpCwwtAnONxzWRJWkQCfVP4u
IWi3RQZ0g7jW8aZwqa9ZB1Y=
=TXJe
-----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by The 2004 JavaOne(SM) Conference
Learn from the experts at JavaOne(SM), Sun's Worldwide Java Developer
Conference, June 28 - July 1 at the Moscone Center in San Francisco, CA
REGISTER AND SAVE! http://java.sun.com/javaone/sf Priority Code NWMGYKND
