From: Raymond <rayau@netvigator.com>
Subject: Re: au88x0 - Replace spdif frequency control by IEC958 control
Date: Tue, 01 Mar 2005 21:27:18 +0800
Message-ID: <42246DB6.5040608@netvigator.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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
Cc: openvortex-dev@nongnu.org
List-Id: alsa-devel@alsa-project.org

 >> The parameter 'spdif_mode' in the routine
 >> vortex_spdif_init(vortex,spdif_sr,spdif_mode) in au88x0_core.c seems
 >> to control AC3 passthrough.
 >>
 >> However the two memory mapped I/O VORTEX_SPDIF_CFG0 and
 >> VORTEX_SPDIF_CFG1 seem to be write-only, return zero when read.

 >Then we need to cache the values.

Define snd_aes_iec958_t spdif_out in struct snd_vortex in au88x0.h

>> 1) Which bit in the IEC958 control is related to AC3 passthrough ?
>
> Every bits hardware can provide :)
>
> The most important one for AC3 is the non-audio bit.

1) Is is possible to find out more information from the specification of 
the spdif chips used ?

cs8412 and cs8402a
http://www.dearhoney.idv.tw/SoundCard/Vortex2/montegoiiplus.htm

Diamond MX300 and MX25
http://www.dearhoney.idv.tw/MUSEUM/soundcard-12.php

Aureal sound cards - SQ2500 (Coaxial) and SuperQuad PCI (optical)
http://www.dearhoney.idv.tw/MUSEUM/soundcard-07.php


static int snd_vortex_spdif_default_put(snd_kcontrol_t * kcontrol,
snd_ctl_elem_value_t * ucontrol)
  {
  	vortex_t *vortex = snd_kcontrol_chip(kcontrol);
	vortex->spdif_out.status[0]=ucontrol->value.iec958.status[0];
	vortex->spdif_out.status[1]=ucontrol->value.iec958.status[1];
	vortex->spdif_out.status[2]=ucontrol->value.iec958.status[2];
	vortex->spdif_out.status[3]=ucontrol->value.iec958.status[3];
	switch(vortex->spdif_out.status[3] & IEC958_AES3_CON_FS){
	case IEC958_AES3_CON_FS_32000: vortex->spdif_sr = 32000; break;
	case IEC958_AES3_CON_FS_44100: vortex->spdif_sr = 44100; break;
	case IEC958_AES3_CON_FS_48000: vortex->spdif_sr = 48000; break;
	};
	vortex_program_spdif(vortex);
	return 0;
}

>
> > As vortex_spdif_init() only handle changing SPDIF sample rate.
> >
> > 2) Do the driver need to initialise vortex->spdif_sr to 48000 or just
> > let alsactl restore the value from /etc/asound.state ?
>
> The driver must initialize the value by itself at first.

-	vortex_spdif_init(vortex, 48000, 1);
+	vortex->spdif_out.status[0]=0;
+	vortex->spdif_out.status[1]=0;
+	vortex->spdif_out.status[2]=0;
+	vortex->spdif_out.status[3]=IEC958_AES3_CON_FS_48000;
+	vortex->spdif_sr=48000;
+	vortex_setup_spdif_out(vortex);


>
> > 3) Is it correct to return the following value in
> > snd_vortex_spdif_mask_get() ?
> > ucontrol->value.iec958.status[3] = IEC958_AES3_CON_FS;
>
> Yes.

static int snd_vortex_spdif_mask_get(snd_kcontrol_t * kcontrol,
snd_ctl_elem_value_t * ucontrol)
{
	ucontrol->value.iec958.status[0] = 0xfd;
	ucontrol->value.iec958.status[1] = 0xff;
	ucontrol->value.iec958.status[2] = 0xff;
	ucontrol->value.iec958.status[3] = IEC958_AES3_CON_FS;
	return 0;
}


2) Do the code "ucontrol->value.iec958.status[0] = 0xfd;" in
snd_vortex_spdif_mask_get() indicate that it support consumer mode only ?
or the driver need to return error when 
(ucontrol->value.iec958.status[0] & IEC958_AES0_PROFESSIONAL ) is true 
in snd_vortex_spdif_default_put() ?

>
> > 4) Is it correct to return the following value in
> > snd_vortex_spdif_default_get() ?
> > ucontrol->value.iec958.status[1] =IEC958_AES1_CON_ORIGINAL |
> > IEC958_AES1_CON_DIGDIGCONV_ID;
>
> If the values are not variable, you don't need to return them.


static int snd_vortex_spdif_default_get(snd_kcontrol_t * kcontrol,
snd_ctl_elem_value_t * ucontrol)
  {
  	vortex_t *vortex = snd_kcontrol_chip(kcontrol);
	ucontrol->value.iec958.status[0] = vortex->spdif_out.status[0];
	ucontrol->value.iec958.status[1] = vortex->spdif_out.status[1];
	ucontrol->value.iec958.status[2] = vortex->spdif_out.status[2];
	ucontrol->value.iec958.status[3] = vortex->spdif_out.status[3];
}

static void vortex_setup_spdif_out(vortex_t * vortex)
{
	int i;
	u32 spdif_sr;

	/* CAsp4Spdif::InitializeSpdifHardware(void) */
	hwwrite(vortex->mmio, VORTEX_SPDIF_FLAGS,
		hwread(vortex->mmio, VORTEX_SPDIF_FLAGS) & 0xfff3fffd);
	//for (i=0x291D4; i<0x29200; i+=4)
	for (i = 0; i < 11; i++)
		hwwrite(vortex->mmio, VORTEX_SPDIF_CFG1 + (i << 2), 0);
	//hwwrite(vortex->mmio, 0x29190, hwread(vortex->mmio, 0x29190) | 0xc0000);
	hwwrite(vortex->mmio, VORTEX_CODEC_EN,
		hwread(vortex->mmio, VORTEX_CODEC_EN) | EN_SPDIF);

	vortex->spdif_out.status[0] &= (~IEC958_AES0_PRO_FS);
	vortex->spdif_out.status[0] &= (~IEC958_AES0_PROFESSIONAL);
	vortex->spdif_out.status[3] &= (~IEC958_AES3_CON_FS);

/* 	FIXME - AC3 passthrough */
	if ( vortex->spdif_out.status[0] & IEC958_AES0_NONAUDIO ) {
		vortex->spdif_sr=48000;
		vortex->spdif_out.status[3] |= IEC958_AES3_CON_FS_48000;
	};
	
	switch (vortex->spdif_sr) {
	case 32000:
		vortex->spdif_out.status[0] &= (~IEC958_AES0_NONAUDIO);
		vortex->spdif_out.status[3] |= IEC958_AES3_CON_FS_32000;
		spdif_sr=0x7D8D;
		break;
	case 44100:
		vortex->spdif_out.status[0] &= (~IEC958_AES0_NONAUDIO);
		vortex->spdif_out.status[3] |= IEC958_AES3_CON_FS_44100;
		spdif_sr=0xACCC;
		break;
	case 48000:
		vortex->spdif_out.status[3] |= IEC958_AES3_CON_FS_48000;
		spdif_sr=0xBB8E;
		break;

	}
	hwwrite(vortex->mmio, VORTEX_SPDIF_CFG0, vortex->spdif_out.status[1]
*256 +vortex->spdif_out.status[0]);
	hwwrite(vortex->mmio, VORTEX_SPDIF_CFG1, vortex->spdif_out.status[3]
*256 +vortex->spdif_out.status[2]);
	hwwrite(vortex->mmio, VORTEX_SPDIF_SMPRATE, spdif_sr);
}


http://lists.gnu.org/archive/html/openvortex-dev/2003-11/msg00008.html

3) Do we need to change the ADB routing when using AC3 passthrough ?

>
> > 5) What additional kcontrol and routine are needed for SPDIF IN ?
>
> For the SPDIF input status bits, no "standard" control is defined
> yet.  You can create a control like "IEC958 Capture Status" returning
> the current IEC958 status bits of the capture stream.
> Also, "IEC958 Capture Switch" can be implemented (if possible).  This
> switch is turned on automatically in iec958 PCM definition in the
> alsa-lib config file.

http://www.turtlebeach.com/site/kb_ftp/5764040.asp

External Sync
Enable Quad Audio

4) Is "External Sync" related to clock in IEC958 control ?

5) How can STAC9721 stereo codec provide quad audio ? ( Is it through
SPDIF-I2S link ? )






-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
