From: Peter-Jan Deweirdt <deweirdt@gmail.com>
Subject: Cirrus Logic CS4207
Date: Fri, 17 Apr 2009 10:33:47 +0200
Message-ID: <625B7AA8-CE98-4B12-A664-27A8B6599E7B@gmail.com>
Mime-Version: 1.0 (Apple Message framework v930.3)
Content-Type: multipart/mixed; boundary=Apple-Mail-12--342977177
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f166.google.com (mail-ew0-f166.google.com
	[209.85.219.166])
	by alsa0.perex.cz (Postfix) with ESMTP id D50371037F1
	for <alsa-devel@alsa-project.org>;
	Fri, 17 Apr 2009 10:33:50 +0200 (CEST)
Received: by ewy10 with SMTP id 10so815537ewy.32
	for <alsa-devel@alsa-project.org>; Fri, 17 Apr 2009 01:33:50 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--Apple-Mail-12--342977177
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit

Hi,

We are in the progress of developming a new platform and we are using  
the audio chip CS4207 from Cirrus Logic (very new). I've noticed that  
the audio is not working as it should.
I'm using the moblin menlow kernel and I'm able to see 1 playback  
channel and 1 capture channel (which is not correct according to the  
chip).

I have retreived from our vendor a patch for the kernel (2.6.27.7) but  
since the moblin kernel is based on the 2.6.29 I cannot use it, even  
not verify if it's working.

Would it be possible to look to the patch and maybe even integrate it  
into a new build?
Or would it be possible to guide me trough so that the audio is  
working properly?


--Apple-Mail-12--342977177
Content-Disposition: attachment;
	filename=cs4207-linux.2.6.27.7-hda.patch
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="cs4207-linux.2.6.27.7-hda.patch"
Content-Transfer-Encoding: quoted-printable

diff=20--git=20a/sound/pci/Kconfig=20b/sound/pci/Kconfig=0D=0Aindex=20=
31f52d3..f26a1bd=20100644=0D=0A---=20a/sound/pci/Kconfig=0D=0A+++=20=
b/sound/pci/Kconfig=0D=0A@@=20-581,6=20+581,14=20@@=20config=20=
SND_HDA_CODEC_SI3054=0D=0A=20=09=20=20Say=20Y=20here=20to=20include=20=
Silicon=20Labs=203054=20HD-modem=20codec=0D=0A=20=09=20=20(and=20=
compatibles)=20support=20in=20snd-hda-intel=20driver.=0D=0A=20=0D=0A=
+config=20SND_HDA_CODEC_CIRRUS=0D=0A+=09bool=20"Build=20Cirrus=20Logic=20=
HD-audio=20codec=20support"=0D=0A+=09depends=20on=20SND_HDA_INTEL=0D=0A+=09=
default=20y=0D=0A+=09help=0D=0A+=09=20=20Say=20Y=20here=20to=20include=20=
Cirrus=20Logic=204207=20HD-audio=20codec=0D=0A+=09=20=20(and=20=
compatibles)=20support=20in=20snd-hda-intel=20driver.=0D=0A+=0D=0A=20=
config=20SND_HDA_GENERIC=0D=0A=20=09bool=20"Enable=20generic=20HD-audio=20=
codec=20parser"=0D=0A=20=09depends=20on=20SND_HDA_INTEL=0D=0Adiff=20=
--git=20a/sound/pci/hda/Makefile=20b/sound/pci/hda/Makefile=0D=0Aindex=20=
ab0c726..bdd7bf3=20100644=0D=0A---=20a/sound/pci/hda/Makefile=0D=0A+++=20=
b/sound/pci/hda/Makefile=0D=0A@@=20-14,5=20+14,6=20@@=20=
snd-hda-intel-$(CONFIG_SND_HDA_CODEC_SI3054)=20+=3D=20patch_si3054.o=0D=0A=
=20snd-hda-intel-$(CONFIG_SND_HDA_CODEC_ATIHDMI)=20+=3D=20=
patch_atihdmi.o=0D=0A=20snd-hda-intel-$(CONFIG_SND_HDA_CODEC_CONEXANT)=20=
+=3D=20patch_conexant.o=0D=0A=20=
snd-hda-intel-$(CONFIG_SND_HDA_CODEC_VIA)=20+=3D=20patch_via.o=0D=0A=
+snd-hda-intel-$(CONFIG_SND_HDA_CODEC_CIRRUS)=20+=3D=20patch_cirrus.o=0D=0A=
=20=0D=0A=20obj-$(CONFIG_SND_HDA_INTEL)=20+=3D=20snd-hda-intel.o=0D=0A=
diff=20--git=20a/sound/pci/hda/hda_codec.c=20b/sound/pci/hda/hda_codec.c=0D=
=0Aindex=20d2e1093..dc88293=20100644=0D=0A---=20=
a/sound/pci/hda/hda_codec.c=0D=0A+++=20b/sound/pci/hda/hda_codec.c=0D=0A=
@@=20-66,6=20+66,7=20@@=20static=20struct=20hda_vendor_id=20=
hda_vendor_ids[]=20=3D=20{=0D=0A=20=09{=200x1854,=20"LG"=20},=0D=0A=20=09=
{=200x434d,=20"C-Media"=20},=0D=0A=20=09{=200x8384,=20"SigmaTel"=20},=0D=0A=
+=09{=200x1013,=20"Cirrus=20Logic"=20},=0D=0A=20=09{}=20/*=20terminator=20=
*/=0D=0A=20};=0D=0A=20=0D=0A@@=20-94,6=20+95,9=20@@=20static=20const=20=
struct=20hda_codec_preset=20*hda_preset_tables[]=20=3D=20{=0D=0A=20=
#ifdef=20CONFIG_SND_HDA_CODEC_VIA=0D=0A=20=09snd_hda_preset_via,=0D=0A=20=
#endif=0D=0A+#ifdef=20CONFIG_SND_HDA_CODEC_CIRRUS=0D=0A+=09=
snd_hda_preset_cirrus,=0D=0A+#endif=0D=0A=20=09NULL=0D=0A=20};=0D=0A=20=0D=
=0Adiff=20--git=20a/sound/pci/hda/hda_patch.h=20=
b/sound/pci/hda/hda_patch.h=0D=0Aindex=202fdf235..3b786e6=20100644=0D=0A=
---=20a/sound/pci/hda/hda_patch.h=0D=0A+++=20b/sound/pci/hda/hda_patch.h=0D=
=0A@@=20-18,3=20+18,5=20@@=20extern=20struct=20hda_codec_preset=20=
snd_hda_preset_atihdmi[];=0D=0A=20extern=20struct=20hda_codec_preset=20=
snd_hda_preset_conexant[];=0D=0A=20/*=20VIA=20codecs=20*/=0D=0A=20extern=20=
struct=20hda_codec_preset=20snd_hda_preset_via[];=0D=0A+/*=20Cirrus=20=
Logic=20codecs=20*/=0D=0A+extern=20struct=20hda_codec_preset=20=
snd_hda_preset_cirrus[];=0D=0Adiff=20--git=20=
a/sound/pci/hda/patch_cirrus.c=20b/sound/pci/hda/patch_cirrus.c=0D=0Anew=20=
file=20mode=20100644=0D=0Aindex=200000000..fe920f9=0D=0A---=20/dev/null=0D=
=0A+++=20b/sound/pci/hda/patch_cirrus.c=0D=0A@@=20-0,0=20+1,668=20@@=0D=0A=
+/*=0D=0A+=20*=20Universal=20Interface=20for=20Intel=20High=20Definition=20=
Audio=20Codec=0D=0A+=20*=0D=0A+=20*=20HD=20audio=20interface=20patch=20=
for=20Cirrus=20Logic=20HD-audio=20codecs=0D=0A+=20*=0D=0A+=20*=20=
Copyright=20(c)=202008=20Cirrus=20Logic=20Inc.=0D=0A+=20*=0D=0A+=20*=0D=0A=
+=20*=20=20This=20driver=20is=20free=20software;=20you=20can=20=
redistribute=20it=20and/or=20modify=0D=0A+=20*=20=20it=20under=20the=20=
terms=20of=20the=20GNU=20General=20Public=20License=20as=20published=20=
by=0D=0A+=20*=20=20the=20Free=20Software=20Foundation;=20either=20=
version=202=20of=20the=20License,=20or=0D=0A+=20*=20=20(at=20your=20=
option)=20any=20later=20version.=0D=0A+=20*=0D=0A+=20*=20=20This=20=
driver=20is=20distributed=20in=20the=20hope=20that=20it=20will=20be=20=
useful,=0D=0A+=20*=20=20but=20WITHOUT=20ANY=20WARRANTY;=20without=20even=20=
the=20implied=20warranty=20of=0D=0A+=20*=20=20MERCHANTABILITY=20or=20=
FITNESS=20FOR=20A=20PARTICULAR=20PURPOSE.=20=20See=20the=0D=0A+=20*=20=20=
GNU=20General=20Public=20License=20for=20more=20details.=0D=0A+=20*=0D=0A=
+=20*=20=20You=20should=20have=20received=20a=20copy=20of=20the=20GNU=20=
General=20Public=20License=0D=0A+=20*=20=20along=20with=20this=20=
program;=20if=20not,=20write=20to=20the=20Free=20Software=0D=0A+=20*=20=20=
Foundation,=20Inc.,=2059=20Temple=20Place,=20Suite=20330,=20Boston,=20MA=20=
=2002111-1307=20USA=0D=0A+=20*/=0D=0A+=0D=0A+#include=20<linux/init.h>=0D=
=0A+#include=20<linux/delay.h>=0D=0A+#include=20<linux/slab.h>=0D=0A=
+#include=20<sound/core.h>=0D=0A+#include=20"hda_codec.h"=0D=0A+#include=20=
"hda_local.h"=0D=0A+#include=20"hda_patch.h"=0D=0A+=0D=0A+/*=20Vendor=20=
Processing=20Widget=20*/=0D=0A+#define=20CS4207_VENDOR_NID=090x11=0D=0A+=0D=
=0A+/*=20Index=20registers=20*/=0D=0A+#define=20IDX_SPDIF_STAT=09=09=
0x0000=0D=0A+#define=20IDX_SPDIF_CTL=09=090x0001=0D=0A+#define=20=
IDX_ADC_CFG=09=090x0002=0D=0A+#define=20IDX_DAC_CFG=09=090x0003=0D=0A=
+#define=20IDX_BEEP_CFG=09=090x0004=0D=0A+/*=200x0008=20-=20test=20reg=20=
key=20*/=0D=0A+/*=200x0009=20-=200x0014=20->=2012=20test=20regs=20*/=0D=0A=
+/*=200x0015=20-=20visibility=20reg=20*/=0D=0A+=0D=0A+/*=20Unsolicitated=20=
Events=20*/=0D=0A+#define=20CS4207_HP_EVENT=09=090x01=20/*=20NID=200x09=20=
*/=0D=0A+#define=20CS4207_LINEOUT_EVENT=090x02=20/*=20NID=200x0A=20*/=0D=0A=
+#define=20CS4207_LINEIN_EVENT=090x04=20/*=20NID=200x0C=20*/=0D=0A=
+#define=20CS4207_MIC_EVENT=090x08=20/*=20NID=200x0D=20*/=0D=0A+#define=20=
CS4207_SPDIFIN_EVENT=090x10=20/*=20NID=200x0F=20*/=0D=0A+=0D=0A+#define=20=
SPDIF_OUT1=200=20/*=20NID=200x08=20->=200x10=20*/=0D=0A+#define=20=
SPDIF_OUT2=201=20/*=20NID=200x14=20->=200x15=20*/=0D=0A+=0D=0A+struct=20=
cs4207_spec=20{=0D=0A+=09struct=20hda_multi_out=20multiout;=0D=0A+=09=
struct=20hda_pcm=20pcm_rec[2];=0D=0A+=09=0D=0A+=09hda_nid_t=20*adc_nids;=0D=
=0A+=09int=20num_adcs;=0D=0A+=09hda_nid_t=20*dac_nids;=0D=0A+=09int=20=
num_dacs;=0D=0A+=0D=0A+=09hda_nid_t=20dig_in_nid;=0D=0A+=09int=20=
hp_present;=0D=0A+=09/*=20capture=20sources=20*/=0D=0A+=09unsigned=20int=20=
num_mux_defs;=0D=0A+=09const=20struct=20hda_input_mux=20*input_mux;=0D=0A=
+=09int=20cur_mux[2];=0D=0A+};=0D=0A+=0D=0A+static=20struct=20hda_verb=20=
cs4207_basic_init[]=20=3D=20{=0D=0A+=09/*=20ADC1=20-=20Line=20In=20=
(0x0C)=20*/=0D=0A+=09{0x05,=20AC_VERB_SET_CONNECT_SEL,=200},=0D=0A+=09/*=20=
ADC2=20-=20Mic=20In=20(0x0D)=20*/=0D=0A+=09{0x06,=20=
AC_VERB_SET_CONNECT_SEL,=200},=0D=0A+=09/*=20Disable=20AUTOINC=20*/=0D=0A=
+=09{0x11,=20AC_VERB_SET_PROC_STATE,=201},=0D=0A+=09{0x11,=20=
AC_VERB_SET_COEF_INDEX,=20IDX_DAC_CFG},=0D=0A+=09{0x11,=20=
AC_VERB_SET_PROC_COEF,=200x146A},=0D=0A+=0D=0A+=09/*=20enable=20=
unsolicited=20event=20*/=0D=0A+=09{0x09,=20=
AC_VERB_SET_UNSOLICITED_ENABLE,=20AC_USRSP_EN=20|=20CS4207_HP_EVENT},=0D=0A=
+=0D=0A+=09/*=20Disable=20SPDIF2=20*/=0D=0A+=09{0x14,=20=
AC_VERB_SET_DIGI_CONVERT_1,=200},=0D=0A+=09=0D=0A+=09{}=20/*=20=
terminator=20*/=0D=0A+};=0D=0A+=0D=0A+static=20hda_nid_t=20=
cs4207_dac_nids[]=20=3D=20{=200x02,=200x03,=200x04=20};=0D=0A+static=20=
hda_nid_t=20cs4207_adc_nids[]=20=3D=20{=200x05,=200x06=20};=0D=0A+static=20=
hda_nid_t=20cs4207_dig_out_nids[]=20=3D=20{=200x08,=200x14=20};=0D=0A=
+static=20int=20cs4207_default_spdif_out=20=3D=20SPDIF_OUT1;=0D=0A+=0D=0A=
+/*=0D=0A+=20=20=20=20Coefficient=20get/set=20functions=20-=20Vendor=20=
widget=20(0x11)=20=0D=0A+*/=0D=0A+int=20cs4207_coef_get(struct=20=
hda_codec*=20codec,=20hda_nid_t=20nid,=20u16=20index)=0D=0A+{=0D=0A+=20=20=
=20=20/*=20set=20coeff=20index=20*/=0D=0A+=20=20=20=20=
snd_hda_codec_write(codec,=20nid,=200,=20=20AC_VERB_SET_COEF_INDEX,=20=0D=
=0A+=09=09=09=20=20=20=20(index=20&=200x1f));=0D=0A+=20=20=20=20/*=20=
read=20coeff=20*/=0D=0A+=20=20=20=20return=20=20=
snd_hda_codec_read(codec,=20nid,=200,=20AC_VERB_GET_PROC_COEF,=200)=20&=20=
0xffff;=0D=0A+}=0D=0A+=0D=0A+void=20cs4207_coef_set(struct=20hda_codec*=20=
codec,=20hda_nid_t=20nid,=20u16=20index,=20u16=20coeff)=0D=0A+{=0D=0A+=20=
=20=20=20/*=20set=20coeff=20index=20*/=0D=0A+=20=20=20=20=
snd_hda_codec_write(codec,=20nid,=200,=20AC_VERB_SET_COEF_INDEX,=20=0D=0A=
+=09=09=09=20=20=20=20(index=20&=200x1f));=0D=0A+=20=20=20=20/*=20write=20=
coeff=20*/=0D=0A+=20=20=20=20snd_hda_codec_write(codec,=20nid,=200,=20=
AC_VERB_SET_PROC_COEF,=20coeff);=0D=0A+}=0D=0A+=0D=0A+=0D=0A+/*=0D=0A+=20=
*=20Input=20selection=0D=0A+=20*/=0D=0A+static=20struct=20hda_input_mux=20=
cs4207_analog_capture_source=20=3D=20{=20=0D=0A+=20=20=20=20=20=20=20=20=
.num_items=20=3D=202,=20=0D=0A+=20=20=20=20=20=20=20=20.items=20=3D=20{=20=
=0D=0A+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20{=20"Analog=20=
In",=200=20},=20=20/*=20ADC1-0x0C,=20ADC2-0x0D=20*/=0D=0A+=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20{=20"Digital=20Mic",=201=20},=20/*=20=
ADC1-0x12,=20ADC2-0x0E=20*/=0D=0A+=20=20=20=20=20=20=20=20},=20=0D=0A+};=0D=
=0A+=0D=0A+static=20int=20cs4207_mux_enum_info(struct=20snd_kcontrol=20=
*kcontrol,=20=0D=0A+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20struct=20snd_ctl_elem_info=20*uinfo)=20=0D=
=0A+{=20=0D=0A+=20=20=20=20=20=20=20=20struct=20hda_codec=20*codec=20=3D=20=
snd_kcontrol_chip(kcontrol);=20=0D=0A+=20=20=20=20=20=20=20=20struct=20=
cs4207_spec=20*spec=20=3D=20codec->spec;=20=0D=0A+=20=20=20=20=20=20=20=20=
return=20snd_hda_input_mux_info(spec->input_mux,=20uinfo);=20=0D=0A+}=20=0D=
=0A+=20=0D=0A+static=20int=20cs4207_mux_enum_get(struct=20snd_kcontrol=20=
*kcontrol,=20=0D=0A+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20struct=20snd_ctl_elem_value=20*ucontrol)=20=
=0D=0A+{=20=0D=0A+=20=20=20=20=20=20=20=20struct=20hda_codec=20*codec=20=
=3D=20snd_kcontrol_chip(kcontrol);=20=0D=0A+=20=20=20=20=20=20=20=20=
struct=20cs4207_spec=20*spec=20=3D=20codec->spec;=20=0D=0A+=20=20=20=20=20=
=20=20=20unsigned=20int=20adc_idx=20=3D=20snd_ctl_get_ioffidx(kcontrol,=20=
&ucontrol->id);=20=0D=0A+=20=0D=0A+=20=20=20=20=20=20=20=20=
ucontrol->value.enumerated.item[0]=20=3D=20spec->cur_mux[adc_idx];=20=0D=0A=
+=20=20=20=20=20=20=20=20return=200;=20=0D=0A+}=20=0D=0A+=20=0D=0A=
+static=20int=20cs4207_mux_enum_put(struct=20snd_kcontrol=20*kcontrol,=20=
=0D=0A+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20struct=20snd_ctl_elem_value=20*ucontrol)=20=0D=0A+{=0D=0A=
+=20=20=20=20=20=20=20=20struct=20hda_codec=20*codec=20=3D=20=
snd_kcontrol_chip(kcontrol);=20=0D=0A+=20=20=20=20=20=20=20=20struct=20=
cs4207_spec=20*spec=20=3D=20codec->spec;=20=0D=0A+=20=20=20=20=20=20=20=20=
unsigned=20int=20adc_idx=20=3D=20snd_ctl_get_ioffidx(kcontrol,=20=
&ucontrol->id);=20=0D=0A+=0D=0A+=20=20=20=20=20=20=20=20return=20=
snd_hda_input_mux_put(codec,=20spec->input_mux,=20ucontrol,=20=0D=0A+=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
spec->adc_nids[adc_idx],=20&spec->cur_mux[adc_idx]);=20=0D=0A+}=0D=0A+=0D=
=0A+=0D=0A+/*=0D=0A+=20=20=20=20Enumerated=20kcontrol.=0D=0A+=20=20=20=20=
Cirrus=20vendor=20processing=20widget=20(0x11)=20coefficients=20=
manipulation=0D=0A+*/=0D=0A+struct=20cs4207_enum=20{=0D=0A+=20=20=20=20=20=
=20=20=20unsigned=20short=20nid;=0D=0A+=20=20=20=20=20=20=20=20unsigned=20=
short=20index;=0D=0A+=20=20=20=20=20=20=20=20unsigned=20char=20shift;=0D=0A=
+=20=20=20=20=20=20=20=20unsigned=20int=20mask;=0D=0A+=20=20=20=20=20=20=20=
=20const=20char=20**texts;=0D=0A+};=0D=0A+=0D=0A+int=20=
cs4207_index_enum_info(struct=20snd_kcontrol=20*kcontrol,=20=0D=0A+=20=20=
=20=20=20=20=20=20struct=20snd_ctl_elem_info=20*uinfo)=20=0D=0A+{=20=0D=0A=
+=20=20=20=20=20=20=20=20struct=20cs4207_enum=20*e=20=3D=20(struct=20=
cs4207_enum=20*)kcontrol->private_value;=20=0D=0A+=20=0D=0A+=20=20=20=20=20=
=20=20=20uinfo->type=20=3D=20SNDRV_CTL_ELEM_TYPE_ENUMERATED;=20=0D=0A+=20=
=20=20=20=20=20=20=20uinfo->count=20=3D=201;=20=0D=0A+=20=20=20=20=20=20=20=
=20uinfo->value.enumerated.items=20=3D=20e->mask;=20=0D=0A+=20=0D=0A+=20=20=
=20=20=20=20=20=20if=20(uinfo->value.enumerated.item=20>=20e->mask=20-=20=
1)=20=0D=0A+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
uinfo->value.enumerated.item=20=3D=20e->mask=20-=201;=20=0D=0A+=20=20=20=20=
=20=20=20=20strcpy(uinfo->value.enumerated.name,=20=0D=0A+=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=
e->texts[uinfo->value.enumerated.item]);=20=0D=0A+=20=20=20=20=20=20=20=20=
return=200;=20=0D=0A+}=20=0D=0A+=0D=0A+int=20=
cs4207_index_enum_get(struct=20snd_kcontrol=20*kcontrol,=20=0D=0A+=20=20=20=
=20=20=20=20=20struct=20snd_ctl_elem_value=20*ucontrol)=20=0D=0A+{=20=0D=0A=
+=20=20=20=20=20=20=20=20struct=20hda_codec=20*codec=20=3D=20=
snd_kcontrol_chip(kcontrol);=20=0D=0A+=20=20=20=20=20=20=20=20struct=20=
cs4207_enum=20*e=20=3D=20(struct=20cs4207_enum=20=
*)kcontrol->private_value;=20=0D=0A+=20=20=20=20=20=20=20=20unsigned=20=
short=20val,=20bitmask;=20=0D=0A+=0D=0A+=20=20=20=20=20=20=20=20for=20=
(bitmask=20=3D=201;=20bitmask=20<=20e->mask;=20bitmask=20<<=3D=201)=20;=0D=
=0A+=0D=0A+=20=20=20=20=20=20=20=20val=20=3D=20cs4207_coef_get(codec,=20=
e->nid,=20e->index);=0D=0A+=20=20=20=20=20=20=20=20=
ucontrol->value.enumerated.item[0]=20=3D=20(val=20>>=20e->shift)=20&=20=
(bitmask=20-=201);=20=0D=0A+=20=0D=0A+=20=20=20=20=20=20=20=20return=20=
0;=20=0D=0A+}=20=0D=0A+=0D=0A+int=20cs4207_index_enum_put(struct=20=
snd_kcontrol=20*kcontrol,=20=0D=0A+=20=20=20=20=20=20=20=20struct=20=
snd_ctl_elem_value=20*ucontrol)=20=0D=0A+{=20=0D=0A+=20=20=20=20=20=20=20=
=20struct=20hda_codec=20*codec=20=3D=20snd_kcontrol_chip(kcontrol);=20=0D=
=0A+=20=20=20=20=20=20=20=20struct=20cs4207_enum=20*e=20=3D=20(struct=20=
cs4207_enum=20*)kcontrol->private_value;=20=0D=0A+=20=20=20=20=20=20=20=20=
unsigned=20short=20val,=20coeff;=20=0D=0A+=20=20=20=20=20=20=20=20=
unsigned=20short=20mask,=20bitmask;=20=0D=0A+=0D=0A+=20=20=20=20=20=20=20=
=20for=20(bitmask=20=3D=201;=20bitmask=20<=20e->mask;=20bitmask=20<<=3D=20=
1);=0D=0A+=0D=0A+=20=20=20=20=20=20=20=20if=20=
(ucontrol->value.enumerated.item[0]=20>=20e->mask=20-=201)=20=0D=0A+=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20return=20-EINVAL;=20=0D=0A+=20=20=
=20=20=20=20=20=20val=20=3D=20ucontrol->value.enumerated.item[0]=20<<=20=
e->shift;=0D=0A+=20=20=20=20=20=20=20=20mask=20=3D=20(bitmask=20-=201)=20=
<<=20e->shift;=0D=0A+=0D=0A+=09coeff=20=3D=20cs4207_coef_get(codec,=20=
e->nid,=20e->index);=0D=0A+=09coeff=20&=3D=20~mask;=0D=0A+=09coeff=20|=3D=20=
(val=20&=20mask);=0D=0A+=09cs4207_coef_set(codec,=20e->nid,=20e->index,=20=
coeff);=0D=0A+=0D=0A+=20=20=20=20=20=20=20=20return=200;=0D=0A+}=20=0D=0A=
+=0D=0A+=0D=0A+#define=20CS4207_ENUM_SINGLE(xnid,=20xindex,=20xshift,=20=
xmask,=20xtexts)=20\=0D=0A+{=20=20=20=20=20=20=20.nid=20=3D=20xnid,=20=
.index=20=3D=20xindex,=20.shift=20=3D=20xshift,=20=20\=0D=0A+=20=20=20=20=
=20=20=20=20.mask=20=3D=20xmask,=20.texts=20=3D=20xtexts=20}=0D=0A+=0D=0A=
+#define=20CS4207_ENUM(xname,=20xenum)=20\=0D=0A+{=20=20=20=20=20=20=20=
.iface=20=3D=20SNDRV_CTL_ELEM_IFACE_MIXER,=20.name=20=3D=20xname,\=0D=0A=
+=20=20=20=20=20=20=20=20.info=20=3D=20cs4207_index_enum_info,=20\=0D=0A=
+=20=20=20=20=20=20=20=20.get=20=3D=20cs4207_index_enum_get,=20\=0D=0A+=09=
.put=20=3D=20cs4207_index_enum_put,=20\=0D=0A+=20=20=20=20=20=20=20=20=
.private_value=20=3D=20(unsigned=20long)&xenum=20\=0D=0A+}=0D=0A+=0D=0A=
+static=20const=20char=20*cs4207_dac_szcmode[]=20=3D=20=0D=0A+=09=
{"Immediate",=20"Zero=20Cross",=20"Soft=20Ramp",=20"Soft=20Ramp=20on=20=
Zero=20Cross"};=0D=0A+static=20const=20char=20*cs4207_adc_szcmode[]=20=3D=20=
=0D=0A+=09{"Immediate",=20"Digital=20Immediate,=20Analog=20Zero=20=
Cross",=20=0D=0A+=09"Digital=20and=20Analog=20Soft=20Ramp",=20"Digital=20=
Soft=20Ramp,=20Analog=20Zero=20Cross"};=0D=0A+static=20const=20char=20=
*cs4207_adc_pgamode[]=20=3D=20=0D=0A+=09{"Differential",=20=
"Single-ended"};=0D=0A+=0D=0A+static=20const=20struct=20cs4207_enum=20=
cs4207_e[]=20=3D=20{=0D=0A+/*0*/=09CS4207_ENUM_SINGLE(CS4207_VENDOR_NID,=20=
IDX_DAC_CFG,=200,=204,=20cs4207_dac_szcmode),=20=0D=0A+=09=
CS4207_ENUM_SINGLE(CS4207_VENDOR_NID,=20IDX_DAC_CFG,=202,=204,=20=
cs4207_dac_szcmode),=20=0D=0A+=09CS4207_ENUM_SINGLE(CS4207_VENDOR_NID,=20=
IDX_DAC_CFG,=204,=204,=20cs4207_dac_szcmode),=20=0D=0A+=09=
CS4207_ENUM_SINGLE(CS4207_VENDOR_NID,=20IDX_ADC_CFG,=200,=204,=20=
cs4207_adc_szcmode),=20=0D=0A+/*4*/=09=
CS4207_ENUM_SINGLE(CS4207_VENDOR_NID,=20IDX_ADC_CFG,=202,=204,=20=
cs4207_adc_szcmode),=20=0D=0A+=09CS4207_ENUM_SINGLE(CS4207_VENDOR_NID,=20=
IDX_ADC_CFG,=205,=202,=20cs4207_adc_pgamode),=20=0D=0A+=09=
CS4207_ENUM_SINGLE(CS4207_VENDOR_NID,=20IDX_ADC_CFG,=206,=202,=20=
cs4207_adc_pgamode),=20=0D=0A+};=0D=0A+=0D=0A+=0D=0A+static=20struct=20=
snd_kcontrol_new=20cs4207_mixer[]=20=3D=20{=20=0D=0A+=20=20=20=20=20=20=20=
=20/*=20Output=20controls=20*/=20=0D=0A+=20=20=20=20=20=20=20=20=
HDA_CODEC_VOLUME("Headphone=20Playback=20Volume",=200x02,=200x0,=20=
HDA_OUTPUT),=20=0D=0A+=20=20=20=20=20=20=20=20HDA_CODEC_MUTE("Headphone=20=
Playback=20Switch",=200x02,=200x0,=20HDA_OUTPUT),=20=0D=0A+=20=20=20=20=20=
=20=20=20HDA_CODEC_VOLUME("Line-Out=20Playback=20Volume",=200x03,=200x0,=20=
HDA_OUTPUT),=20=0D=0A+=20=20=20=20=20=20=20=20HDA_CODEC_MUTE("Line-Out=20=
Playback=20Switch",=200x03,=200x0,=20HDA_OUTPUT),=20=0D=0A+=20=20=20=20=20=
=20=20=20HDA_CODEC_VOLUME("Speakers=20Playback=20Volume",=200x04,=200x0,=20=
HDA_OUTPUT),=20=0D=0A+=20=20=20=20=20=20=20=20HDA_CODEC_MUTE("Speakers=20=
Playback=20Switch",=200x04,=200x0,=20HDA_OUTPUT),=20=0D=0A+=0D=0A+=09/*=20=
Input=20Controls=20*/=0D=0A+=20=20=20=20=20=20=20=20=
HDA_CODEC_VOLUME("Mic=20Capture=20Volume",=200x06,=200,=20HDA_INPUT),=20=0D=
=0A+=20=20=20=20=20=20=20=20HDA_CODEC_MUTE("Mic=20Capture=20Switch",=20=
0x06,=200,=20HDA_INPUT),=20=0D=0A+=20=20=20=20=20=20=20=20=
HDA_CODEC_VOLUME("Line=20Capture=20Volume",=200x05,=200,=20HDA_INPUT),=20=
=0D=0A+=20=20=20=20=20=20=20=20HDA_CODEC_MUTE("Line=20Capture=20Switch",=20=
0x05,=200,=20HDA_INPUT),=20=0D=0A+=0D=0A+=09/*=20Input=20Gain=20-=20=
0,+10,=20+20=20dB=20*/=0D=0A+=09/*=20=20=20=20Mute=20is=20ignored=20*/=0D=
=0A+=20=20=20=20=20=20=20=20HDA_CODEC_VOLUME("Mic=20Input=20Capture=20=
Volume",=200x0D,=200,=20HDA_INPUT),=20=0D=0A+=20=20=20=20=20=20=20=20=
HDA_CODEC_VOLUME("Line=20Input=20Capture=20Volume",=200x0C,=200,=20=
HDA_INPUT),=20=0D=0A+=20=20=20=20=20=20=20=20HDA_CODEC_VOLUME("Digital=20=
Input=201=20Capture=20Volume",=200x0E,=200,=20HDA_INPUT),=20=0D=0A+=09/*=0D=
=0A+=09=20=20=20=20Sets=20the=20soft=20ramp=20and=0D=0A+=09=20=20=20=20=
zero=20crossing=20detection=20modes=20by=20which=20volume=0D=0A+=09=20=20=
=20=20and=20muting=20changes=20will=20be=20implemented=0D=0A+=09*/=0D=0A=
+=09CS4207_ENUM("Headphone=20SZCMode=20Playback=20Switch",=20=
cs4207_e[0]),=0D=0A+=09CS4207_ENUM("Line-Out=20SZCMode=20Playback=20=
Switch",=20cs4207_e[1]),=0D=0A+=09CS4207_ENUM("Speakers=20SZCMode=20=
Playback=20Switch",=20cs4207_e[2]),=0D=0A+=09/*=09=0D=0A+=09=20=20=20=20=
Sets=20the=20mode=20by=20which=0D=0A+=09=20=20=20=20analog=20PGA=20and=20=
digital=20volume,=20and=20muting=0D=0A+=09=20=20=20=20changes=20will=20=
be=20implemented.=0D=0A+=09*/=0D=0A+=09CS4207_ENUM("Mic=20SZCMode=20=
Capture=20Switch",=20cs4207_e[3]),=0D=0A+=09CS4207_ENUM("Line-In=20=
SZCMode=20Capture=20Switch",=20cs4207_e[4]),=0D=0A+=09/*=0D=0A+=09=20=20=20=
=20Sets=20the=20topology=20for=20the=20Line=20In,=20Mic=20In=20PGA=0D=0A=
+=09*/=0D=0A+=09CS4207_ENUM("Mic=20PGA=20Mode=20Capture=20Switch",=20=
cs4207_e[5]),=0D=0A+=09CS4207_ENUM("Line-In=20PGA=20Mode=20Capture=20=
Switch",=20cs4207_e[6]),=0D=0A+=0D=0A+=20=20=20=20=20=20=20=20{=20}=20/*=20=
end=20*/=20=0D=0A+};=20=0D=0A+=0D=0A+=0D=0A+/*=20SPDIF_TX2=20-=20=
disabled/DMIC2=20enabled=20-=20add=20DMIC2=20widgets=20*/=0D=0A+static=20=
struct=20snd_kcontrol_new=20cs4207_mixer_dmic2[]=20=3D=20{=20=0D=0A+=20=20=
=20=20=20=20=20=20HDA_CODEC_VOLUME("Digital=20Input=202=20Capture=20=
Volume",=200x12,=200,=20HDA_INPUT),=20=0D=0A+=20=20=20=20=20=20=20=20{=20=
=0D=0A+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20.iface=20=3D=20=
SNDRV_CTL_ELEM_IFACE_MIXER,=20=0D=0A+=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20.name=20=3D=20"Capture=20Source",=20=0D=0A+=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20.count=20=3D=202,=0D=0A+=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20.info=20=3D=20cs4207_mux_enum_info,=20=0D=0A+=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20.get=20=3D=20=
cs4207_mux_enum_get,=20=0D=0A+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20.put=20=3D=20cs4207_mux_enum_put,=20=0D=0A+=20=20=20=20=20=20=20=20},=20=
{}=0D=0A+};=0D=0A+=0D=0A+/*=20SPDIF_TX2=20-=20enabled/DMIC2=20disabled=20=
*/=0D=0A+static=20struct=20snd_kcontrol_new=20cs4207_mixer_nodmic2[]=20=3D=
=20{=20=0D=0A+=20=20=20=20=20=20=20=20{=20=0D=0A+=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20.iface=20=3D=20SNDRV_CTL_ELEM_IFACE_MIXER,=20=0D=0A=
+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20.name=20=3D=20"Capture=20=
Source",=20=0D=0A+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20.count=20=
=3D=201,=20=20=0D=0A+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
.info=20=3D=20cs4207_mux_enum_info,=20=0D=0A+=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20.get=20=3D=20cs4207_mux_enum_get,=20=0D=0A+=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20.put=20=3D=20cs4207_mux_enum_put,=20=0D=
=0A+=20=20=20=20=20=20=20=20},{}=20=0D=0A+};=0D=0A+=0D=0A+/*=0D=0A+=20*=20=
Controls=0D=0A+=20*/=0D=0A+static=20int=20cs4207_build_controls(struct=20=
hda_codec=20*codec)=0D=0A+{=0D=0A+=09struct=20cs4207_spec=20*spec=20=3D=20=
codec->spec;=0D=0A+=09int=20err;=0D=0A+=0D=0A+=20=20=20=20=20=20=20=20=
err=20=3D=20snd_hda_add_new_ctls(codec,=20cs4207_mixer);=20=0D=0A+=20=20=20=
=20=20=20=20=20if=20(err=20<=200)=20=0D=0A+=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20return=20err;=20=0D=0A+=0D=0A+=09/*=20Add=20DMIC2=20=
widgets=20*/=0D=0A+=09if=20(cs4207_default_spdif_out=20=3D=3D=20=
SPDIF_OUT1)=20{=0D=0A+=20=20=20=20=09=20=20=20=20err=20=3D=20=
snd_hda_add_new_ctls(codec,=20cs4207_mixer_dmic2);=20=0D=0A+=20=20=20=20=09=
=20=20=20=20if=20(err=20<=200)=20=0D=0A+=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20return=20err;=20=0D=0A+=09}=20else=20=20{=20/*=20=
SPDIF_OUT2=20*/=0D=0A+=20=20=20=20=09=20=20=20=20err=20=3D=20=
snd_hda_add_new_ctls(codec,=20cs4207_mixer_nodmic2);=20=0D=0A+=20=20=20=20=
=09=20=20=20=20if=20(err=20<=200)=20=0D=0A+=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20return=20err;=20=0D=0A+=0D=0A+=09}=0D=0A+=0D=0A+=20=20=20=
=20=20=20=20=20if=20(spec->multiout.dig_out_nid)=20{=0D=0A+=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20err=20=3D=20=
snd_hda_create_spdif_out_ctls(codec,=0D=0A+=09=09=09=09=09=09=
spec->multiout.dig_out_nid);=0D=0A+=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20if=20(err=20<=200)=0D=0A+=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20return=20err;=20=0D=0A+=0D=0A+=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20err=20=3D=20=
snd_hda_create_spdif_share_sw(codec,=0D=0A+=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20&spec->multiout);=0D=0A=
+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20if=20(err=20<=200)=0D=0A=
+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
return=20err;=0D=0A+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
spec->multiout.share_spdif=20=3D=201;=0D=0A+=0D=0A+=20=20=20=20=20=20=20=20=
}=0D=0A+=20=20=20=20=20=20=20=20if=20(spec->dig_in_nid)=20{=0D=0A+=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20err=20=3D=20=
snd_hda_create_spdif_in_ctls(codec,=20spec->dig_in_nid);=20=0D=0A+=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20if=20(err=20<=200)=20=0D=0A+=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20return=20=
err;=20=0D=0A+=20=20=20=20=20=20=20=20}=0D=0A+=0D=0A+=09return=200;=0D=0A=
+}=0D=0A+=0D=0A+=0D=0A+/*=20=0D=0A+=20*=20Analog=20playback=20callbacks=20=
=0D=0A+=20*/=20=0D=0A+static=20int=20cs4207_playback_pcm_open(struct=20=
hda_pcm_stream=20*hinfo,=20=0D=0A+=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
struct=20hda_codec=20*codec,=20=0D=0A+=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
struct=20snd_pcm_substream=20*substream)=20=0D=0A+{=20=0D=0A+=20=20=20=20=
=20=20=20=20struct=20cs4207_spec=20*spec=20=3D=20codec->spec;=20=0D=0A+=20=
=20=20=20=20=20=20=20return=20snd_hda_multi_out_analog_open(codec,=20=
&spec->multiout,=20substream,=20=0D=0A+=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20hinfo);=20=0D=0A+}=20=0D=0A+=20=0D=0A+static=20=
int=20cs4207_playback_pcm_prepare(struct=20hda_pcm_stream=20*hinfo,=20=0D=
=0A+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20struct=20hda_codec=20=
*codec,=20=0D=0A+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20unsigned=20=
int=20stream_tag,=20=0D=0A+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
unsigned=20int=20format,=20=0D=0A+=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20struct=20snd_pcm_substream=20*substream)=20=0D=0A+{=20=0D=0A+=20=20=
=20=20=20=20=20=20struct=20cs4207_spec=20*spec=20=3D=20codec->spec;=20=0D=
=0A+=20=20=20=20=20=20=20=20return=20=
snd_hda_multi_out_analog_prepare(codec,=20&spec->multiout,=20stream_tag,=20=
=0D=0A+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20format,=20substream);=20=0D=0A+}=20=0D=0A+=20=0D=0A+static=20int=20=
cs4207_playback_pcm_cleanup(struct=20hda_pcm_stream=20*hinfo,=20=0D=0A+=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20struct=20hda_codec=20*codec,=20=0D=
=0A+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20struct=20=
snd_pcm_substream=20*substream)=20=0D=0A+{=20=0D=0A+=20=20=20=20=20=20=20=
=20struct=20cs4207_spec=20*spec=20=3D=20codec->spec;=20=0D=0A+=20=20=20=20=
=20=20=20=20return=20snd_hda_multi_out_analog_cleanup(codec,=20=
&spec->multiout);=20=0D=0A+}=20=0D=0A+=0D=0A+/*=20=0D=0A+=20*=20Analog=20=
capture=20=0D=0A+=20*/=20=0D=0A+static=20int=20=
cs4207_capture_pcm_prepare(struct=20hda_pcm_stream=20*hinfo,=20=0D=0A+=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20struct=20hda_codec=20*codec,=20=0D=0A=
+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20unsigned=20int=20stream_tag,=20=
=0D=0A+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20unsigned=20int=20format,=20=
=0D=0A+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20struct=20=
snd_pcm_substream=20*substream)=20=0D=0A+{=20=0D=0A+=20=20=20=20=20=20=20=
=20struct=20cs4207_spec=20*spec=20=3D=20codec->spec;=20=0D=0A+=20=0D=0A+=20=
=20=20=20=20=20=20=20snd_hda_codec_setup_stream(codec,=20=
spec->adc_nids[substream->number],=20=0D=0A+=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
stream_tag,=200,=20format);=20=0D=0A+=20=20=20=20=20=20=20=20return=200;=20=
=0D=0A+}=20=0D=0A+=20=0D=0A+static=20int=20=
cs4207_capture_pcm_cleanup(struct=20hda_pcm_stream=20*hinfo,=20=0D=0A+=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20struct=20hda_codec=20*codec,=20=0D=0A=
+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20struct=20snd_pcm_substream=20=
*substream)=20=0D=0A+{=20=0D=0A+=20=20=20=20=20=20=20=20struct=20=
cs4207_spec=20*spec=20=3D=20codec->spec;=20=0D=0A+=20=0D=0A+=20=20=20=20=20=
=20=20=20snd_hda_codec_cleanup_stream(codec,=20=
spec->adc_nids[substream->number]);=20=0D=0A+=20=20=20=20=20=20=20=20=
return=200;=20=0D=0A+}=20=0D=0A+=0D=0A+=0D=0A+=0D=0A+/*=0D=0A+=20*=20=
Digital=20playback=0D=0A+=20*/=0D=0A+static=20int=20=
cs4207_dig_playback_pcm_open(struct=20hda_pcm_stream=20*hinfo,=0D=0A+=09=09=
=09=09=20=20=20=20=20struct=20hda_codec=20*codec,=0D=0A+=09=09=09=09=20=20=
=20=20=20struct=20snd_pcm_substream=20*substream)=0D=0A+{=0D=0A+=09=
struct=20cs4207_spec=20*spec=20=3D=20codec->spec;=0D=0A+=09return=20=
snd_hda_multi_out_dig_open(codec,=20&spec->multiout);=0D=0A+}=0D=0A+=0D=0A=
+static=20int=20cs4207_dig_playback_pcm_close(struct=20hda_pcm_stream=20=
*hinfo,=0D=0A+=09=09=09=09=20=20=20=20=20=20struct=20hda_codec=20*codec,=0D=
=0A+=09=09=09=09=20=20=20=20=20=20struct=20snd_pcm_substream=20=
*substream)=0D=0A+{=0D=0A+=09struct=20cs4207_spec=20*spec=20=3D=20=
codec->spec;=0D=0A+=09return=20snd_hda_multi_out_dig_close(codec,=20=
&spec->multiout);=0D=0A+}=0D=0A+=0D=0A+static=20int=20=
cs4207_dig_playback_pcm_prepare(struct=20hda_pcm_stream=20*hinfo,=0D=0A+=09=
=09=09=09=09=20=20=20=20struct=20hda_codec=20*codec,=0D=0A+=09=09=09=09=09=
=20=20=20=20unsigned=20int=20stream_tag,=0D=0A+=09=09=09=09=09=20=20=20=20=
unsigned=20int=20format,=0D=0A+=09=09=09=09=09=20=20=20=20struct=20=
snd_pcm_substream=20*substream)=0D=0A+{=0D=0A+=09struct=20cs4207_spec=20=
*spec=20=3D=20codec->spec;=0D=0A+=09return=20=
snd_hda_multi_out_dig_prepare(codec,=20&spec->multiout,=20stream_tag,=0D=0A=
+=09=09=09=09=09=20=20=20=20=20format,=20substream);=0D=0A+}=0D=0A+=0D=0A=
+static=20struct=20hda_pcm_stream=20cs4207_pcm_analog_playback=20=3D=20{=20=
=0D=0A+=20=20=20=20=20=20=20=20.substreams=20=3D=201,=20=0D=0A+=20=20=20=20=
=20=20=20=20.channels_min=20=3D=202,=20=0D=0A+=20=20=20=20=20=20=20=20=
.channels_max=20=3D=206,=20=0D=0A+=20=20=20=20=20=20=20=20.nid=20=3D=20=
0x03,=20/*=20NID=20to=20query=20formats=20and=20rates=20*/=20=0D=0A+=20=20=
=20=20=20=20=20=20.ops=20=3D=20{=20=0D=0A+=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20.open=20=3D=20cs4207_playback_pcm_open,=20=0D=0A+=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20.prepare=20=3D=20=
cs4207_playback_pcm_prepare,=20=0D=0A+=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20.cleanup=20=3D=20cs4207_playback_pcm_cleanup=20=0D=0A+=20=20=20=
=20=20=20=20=20},=20=0D=0A+};=20=0D=0A+=20=0D=0A+static=20struct=20=
hda_pcm_stream=20cs4207_pcm_analog_capture=20=3D=20{=20=0D=0A+=20=20=20=20=
=20=20=20=20.substreams=20=3D=202,=20=0D=0A+=20=20=20=20=20=20=20=20=
.channels_min=20=3D=202,=20=0D=0A+=20=20=20=20=20=20=20=20.channels_max=20=
=3D=204,=20=0D=0A+=20=20=20=20=20=20=20=20.nid=20=3D=200x05,=20/*=20NID=20=
to=20query=20formats=20and=20rates=20*/=20=0D=0A+=20=20=20=20=20=20=20=20=
.ops=20=3D=20{=20=0D=0A+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
.prepare=20=3D=20cs4207_capture_pcm_prepare,=20=0D=0A+=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20.cleanup=20=3D=20cs4207_capture_pcm_cleanup=20=
=0D=0A+=20=20=20=20=20=20=20=20},=20=0D=0A+};=20=0D=0A+=0D=0A+=0D=0A=
+static=20struct=20hda_pcm_stream=20cs4207_pcm_digital_playback=20=3D=20=
{=0D=0A+=09.substreams=20=3D=201,=0D=0A+=09.channels_min=20=3D=202,=0D=0A=
+=09.channels_max=20=3D=206,=0D=0A+=09.nid=20=3D=200x3,=20/*=20NID=20to=20=
query=20formats=20and=20rates=20and=20setup=20streams=20*/=0D=0A+=09.ops=20=
=3D=20{=0D=0A+=09=09.open=20=3D=20cs4207_dig_playback_pcm_open,=0D=0A+=09=
=09.close=20=3D=20cs4207_dig_playback_pcm_close,=0D=0A+=09=09.prepare=20=
=3D=20cs4207_dig_playback_pcm_prepare=0D=0A+=09},=0D=0A+};=0D=0A+=0D=0A=
+static=20struct=20hda_pcm_stream=20cs4207_pcm_digital_capture=20=3D=20{=20=
=0D=0A+=20=20=20=20=20=20=20=20.substreams=20=3D=201,=20=0D=0A+=20=20=20=20=
=20=20=20=20.channels_min=20=3D=202,=20=0D=0A+=20=20=20=20=20=20=20=20=
.channels_max=20=3D=202,=20=0D=0A+=09.nid=20=3D=200x05=20/*=20?=20*/=0D=0A=
+};=20=0D=0A+=0D=0A+=0D=0A+static=20int=20cs4207_build_pcms(struct=20=
hda_codec=20*codec)=0D=0A+{=0D=0A+=09struct=20cs4207_spec=20*spec=20=3D=20=
codec->spec;=0D=0A+=09struct=20hda_pcm=20*info=20=3D=20spec->pcm_rec;=0D=0A=
+=0D=0A+=09codec->num_pcms=20=3D=201;=0D=0A+=09codec->pcm_info=20=3D=20=
info;=0D=0A+=0D=0A+=20=20=20=20=20=20=20=20info->name=20=3D=20"CS4207=20=
Analog";=0D=0A+=20=20=20=20=20=20=20=20=
info->stream[SNDRV_PCM_STREAM_PLAYBACK]=20=3D=20=
cs4207_pcm_analog_playback;=0D=0A+=20=20=20=20=20=20=20=20=
info->stream[SNDRV_PCM_STREAM_CAPTURE]=20=3D=20=
cs4207_pcm_analog_capture;=0D=0A+=20=20=20=20=20=20=20=20=
info->stream[SNDRV_PCM_STREAM_CAPTURE].nid=20=3D=20spec->adc_nids[0];=20=0D=
=0A+=20=20=20=20=20=20=20=20=
info->stream[SNDRV_PCM_STREAM_CAPTURE].substreams=20=3D=20=
spec->num_adcs;=20=0D=0A+=0D=0A+=20=20=20=20=20=20=20=20if=20=
(spec->multiout.dig_out_nid=20||=20spec->dig_in_nid)=20{=0D=0A+=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20codec->num_pcms++;=0D=0A+=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20info++;=0D=0A+=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20info->name=20=3D=20"CS4207=20Digital";=0D=0A+=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20info->pcm_type=20=3D=20=
HDA_PCM_TYPE_SPDIF;=0D=0A+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
if=20(spec->multiout.dig_out_nid)=20{=0D=0A+=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
info->stream[SNDRV_PCM_STREAM_PLAYBACK]=20=3D=20=
cs4207_pcm_digital_playback;=0D=0A+=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=
info->stream[SNDRV_PCM_STREAM_PLAYBACK].nid=20=3D=20=
spec->multiout.dig_out_nid;=0D=0A+=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20}=0D=0A+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20if=20=
(spec->dig_in_nid)=20{=0D=0A+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20info->stream[SNDRV_PCM_STREAM_CAPTURE]=20=3D=20=
cs4207_pcm_digital_capture;=0D=0A+=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=
info->stream[SNDRV_PCM_STREAM_CAPTURE].nid=20=3D=20spec->dig_in_nid;=0D=0A=
+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20}=0D=0A+=20=20=20=20=20=20=
=20=20}=0D=0A+=0D=0A+=09return=200;=0D=0A+}=0D=0A+=0D=0A+/*=20mute=20=
internal=20speaker=20if=20HP=20is=20plugged=20*/=20=0D=0A+static=20void=20=
cs4207_automute(struct=20hda_codec=20*codec)=0D=0A+{=0D=0A+=20=20=20=20=20=
=20=20=20struct=20cs4207_spec=20*spec=20=3D=20codec->spec;=0D=0A+=20=20=20=
=20=20=20=20=20unsigned=20int=20bits;=0D=0A+=0D=0A+=20=20=20=20=20=20=20=20=
spec->hp_present=20=3D=20snd_hda_codec_read(codec,=200x09,=200,=0D=0A+=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20AC_VERB_GET_PIN_SENSE,=200)=20&=200x80000000;=0D=0A=
+=0D=0A+=20=20=20=20=20=20=20=20bits=20=3D=20(spec->hp_present)=20?=20=
HDA_AMP_MUTE=20:=200;=0D=0A+=09/*=20Mute=20Speakers=20(DAC3)=20*/=0D=0A+=20=
=20=20=20=20=20=20=20snd_hda_codec_amp_stereo(codec,=200x04,=20=
HDA_OUTPUT,=200,=0D=0A+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20HDA_AMP_MUTE,=20bits);=0D=
=0A+}=0D=0A+=0D=0A+/*=20Unsolicited=20events=20for=20jack=20sensing=20-=20=
remove=20?*/=0D=0A+static=20void=20cs4207_unsol_event(struct=20hda_codec=20=
*codec,=0D=0A+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20unsigned=20int=20res)=0D=0A=
+{=0D=0A+=20=20=20=20=20=20=20=20res=20>>=3D=2026;=0D=0A+=20=20=20=20=20=20=
=20=20switch=20(res)=20{=0D=0A+=20=20=20=20=09=20=20=20=20case=20=
CS4207_HP_EVENT:=0D=0A+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
cs4207_automute(codec);=0D=0A+=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20=
=20break;=0D=0A+=09=20=20=20=20/*=20Do=20something=20on=20these=20events=20=
?=20*/=0D=0A+=20=20=20=20=09=20=20=20=20case=20CS4207_LINEIN_EVENT:=0D=0A=
+=09=20=20=20=20case=20CS4207_SPDIFIN_EVENT:=0D=0A+=09=20=20=20=20case=20=
CS4207_MIC_EVENT:=0D=0A+=09=20=20=20=20case=20CS4207_LINEOUT_EVENT:=0D=0A=
+=09=09break;=0D=0A+=20=20=20=20=20=20=20=20}=0D=0A+}=0D=0A+=0D=0A=
+static=20int=20cs4207_init(struct=20hda_codec=20*codec)=0D=0A+{=0D=0A+=09=
u16=20coeff;=0D=0A+=09snd_hda_sequence_write(codec,=20=
cs4207_basic_init);=0D=0A+=09=0D=0A+=09/*=20SPDIF*/=0D=0A+=09coeff=20=3D=20=
=200;=0D=0A+=09coeff=20|=3D=200x0002;=20/*=20SRC_MUTE=20soft-mute=20on=20=
SPDIF=20(if=20no=20lock)=20*/=0D=0A+=09coeff=20|=3D=200x0008;=20/*=20=
Replace=20with=20mute=20on=20error=20*/=0D=0A+=09/*=20=0D=0A+=09=20=20=20=
=20RX=20to=20TX1=20or=20TX2=20Loopthru=20/=20SPDIF2=20.=0D=0A+=09=20=20=20=
=20SPDIF_OUT2=20is=20shared=20with=20GPIO1=20and=20DMIC_SDA2.=0D=0A+=09=20=
=20=20=20Multiout=20uses=20single=20digital=20output=0D=0A+=09*/=0D=0A+=09=
if=20(cs4207_default_spdif_out=20=3D=3D=20SPDIF_OUT2)=0D=0A+=09=20=20=20=20=
coeff=20|=3D=200x4000;=0D=0A+=0D=0A+=09cs4207_coef_set(codec,=20=
CS4207_VENDOR_NID,=20IDX_SPDIF_CTL,=20coeff);=0D=0A+=0D=0A+=09/*=20ADC=20=
*/=0D=0A+=09coeff=20=3D=200;=0D=0A+=09coeff=20|=3D=200x000a;=20/*=20=
ADC1/2=20-=20Digital=20and=20Analog=20Soft=20Ramp=20*/=0D=0A+=09coeff=20=
|=3D=200x0500;=20/*=20DMIC2=20enable=202=20channels,=20disable=20GPIO1=20=
*/=0D=0A+=09coeff=20|=3D=200x1800;=20/*=20DMIC1=20enable=202=20channels,=20=
disable=20GPIO0=20=0D=0A+=09=09=09=20=20=20=20No=20effect=20if=20=
SPDIF_OUT2=20is=20slected=20in=20=0D=0A+=09=09=09=20=20=20=20=
IDX_SPDIF_CTL.=0D=0A+=09=09=09*/=0D=0A+=0D=0A+=09cs4207_coef_set(codec,=20=
CS4207_VENDOR_NID,=20IDX_ADC_CFG,=20coeff);=0D=0A+=0D=0A+=09/*=20DAC=20=
*/=0D=0A+=09coeff=20=3D=20=200;=0D=0A+=09coeff=20|=3D=200x002a;=20/*=20=
DAC1/2/3=20SZCMode=20Soft=20Ramp=20*/=0D=0A+=09coeff=20|=3D=200x0040;=20=
/*=20Mute=20DACs=20on=20FIFO=20error=20*/=0D=0A+=09coeff=20|=3D=20=
0x1000;=20/*=20Enable=20DACs=20High=20Pass=20Filter=20*/=0D=0A+=09coeff=20=
|=3D=200x0400;=20/*=20Disable=20Cefficient=20Auto=20increment=20*/=0D=0A=
+=09cs4207_coef_set(codec,=20CS4207_VENDOR_NID,=20IDX_DAC_CFG,=20coeff);=0D=
=0A+=09=0D=0A+=09/*=20Beep=20*/=0D=0A+=09coeff=20=3D=200x0007;=20/*=20=
Enable=20Beep=20thru=20DAC1/2/3=20*/=0D=0A+=09cs4207_coef_set(codec,=20=
CS4207_VENDOR_NID,=20IDX_BEEP_CFG,=20coeff);=0D=0A+=0D=0A+=09if=20=
(codec->patch_ops.unsol_event)=20{=0D=0A+=09=20=20=20=20=
cs4207_automute(codec);=0D=0A+=09}=0D=0A+=0D=0A+=09return=200;=0D=0A+}=0D=
=0A+=0D=0A+static=20void=20cs4207_free(struct=20hda_codec=20*codec)=0D=0A=
+{=0D=0A+=09if=20(codec->spec)=0D=0A+=09=20=20=20=20kfree(codec->spec);=0D=
=0A+}=0D=0A+=0D=0A+static=20struct=20hda_codec_ops=20cs4207_patch_ops=20=
=3D=20{=0D=0A+=09.build_controls=20=3D=20cs4207_build_controls,=0D=0A+=09=
.build_pcms=20=3D=20cs4207_build_pcms,=0D=0A+=09.init=20=3D=20=
cs4207_init,=0D=0A+=09.free=20=3D=20cs4207_free,=0D=0A+=09.unsol_event=20=
=3D=20cs4207_unsol_event,=0D=0A+};=0D=0A+=0D=0A+static=20int=20=
patch_cs4207(struct=20hda_codec=20*codec)=0D=0A+{=0D=0A+=09struct=20=
cs4207_spec=20*spec;=0D=0A+=0D=0A+=09spec=20=3D=20kzalloc(sizeof(*spec),=20=
GFP_KERNEL);=0D=0A+=09if=20(spec=20=3D=3D=20NULL)=0D=0A+=09=09return=20=
-ENOMEM;=0D=0A+=0D=0A+=09codec->spec=20=3D=20spec;=0D=0A+=0D=0A+=09=
spec->multiout.dac_nids=20=3D=20cs4207_dac_nids;=0D=0A+=09=
spec->multiout.num_dacs=20=3D=20=20ARRAY_SIZE(cs4207_dac_nids);=09=20=20=
/*=203=20*/=0D=0A+=09spec->multiout.max_channels=20=3D=20=
spec->multiout.num_dacs=20*=202;=0D=0A+=09/*=20NID=20for=20copying=20=
analog=20to=20digital=20*/=0D=0A+=09spec->multiout.dig_out_nid=20=3D=20=
cs4207_dig_out_nids[cs4207_default_spdif_out];=20=0D=0A+=09=
spec->dig_in_nid=20=3D=200x7;=20/*=20SPDIF=20in*/=0D=0A+=09=
spec->adc_nids=20=3D=20cs4207_adc_nids;=0D=0A+=09spec->num_adcs=20=3D=20=
ARRAY_SIZE(cs4207_adc_nids);=0D=0A+=09spec->dac_nids=20=3D=20=
cs4207_dac_nids;=0D=0A+=09spec->num_dacs=20=3D=20=
ARRAY_SIZE(cs4207_dac_nids);=0D=0A+=09spec->input_mux=20=3D=20=
&cs4207_analog_capture_source;=0D=0A+=09codec->patch_ops=20=3D=20=
cs4207_patch_ops;=0D=0A+=0D=0A+=09return=200;=0D=0A+}=0D=0A+=0D=0A+/*=0D=0A=
+=20*=20patch=20entries=0D=0A+=20*/=0D=0A+struct=20hda_codec_preset=20=
snd_hda_preset_cirrus[]=20=3D=20{=0D=0A+=09{=20.id=20=3D=200x10134207,=20=
.name=20=3D=20"CS4207",=20.patch=20=3D=20patch_cs4207=20},=0D=0A+=09{}=20=
/*=20terminator=20*/=0D=0A+};=0D=0A=

--Apple-Mail-12--342977177
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed;
	delsp=yes
Content-Transfer-Encoding: 7bit



This is what I'm seeing when using the current kernel from moblin  
(2.6.29.rc7-40.1)

 >>> chunk from dmesg
[    5.166641] Advanced Linux Sound Architecture Driver Version 1.0.18a.
[    5.171792] HDA Intel 0000:00:1b.0: setting latency timer to 64
[    5.216898] ALSA device list:
[    5.216916]   #0: HDA Intel MID at 0xd0010000 irq 22
[    5.217024] nf_conntrack version 0.5.0 (3947 buckets, 15788 max)
<<<end chunk of dmesg

[root@localhost ~]# cat /proc/asound/cards
  0 [MID            ]: HDA-Intel - HDA Intel MID
                       HDA Intel MID at 0xd0010000 irq 22

[root@localhost ~]# ls -al /dev/snd/
total 0
drwxr-xr-x  2 root root     160 Mar 24 20:00 .
drwxr-xr-x 15 root root    3360 Mar 24 20:00 ..
crw-rw----  1 root audio 116, 7 Mar 24 20:00 controlC0
crw-rw----  1 root audio 116, 6 Mar 24 20:00 hwC0D0
crw-rw----  1 root audio 116, 5 Mar 24 20:00 pcmC0D0c
crw-rw----  1 root audio 116, 4 Mar 24 20:00 pcmC0D0p
crw-rw----  1 root audio 116, 3 Mar 24 20:00 seq
crw-rw----  1 root audio 116, 2 Mar 24 20:00 timer
[root@localhost ~]#


[root@localhost ~]# aplay -l
**** List of PLAYBACK Hardware Devices ****
card 0: MID [HDA Intel MID], device 0: HDA Generic [HDA Generic]
   Subdevices: 1/1
   Subdevice #0: subdevice #0
[root@localhost ~]#

[root@localhost ~]# aplay -L
front:CARD=MID,DEV=0
     HDA Intel MID, HDA Generic
     Front speakers
surround40:CARD=MID,DEV=0
     HDA Intel MID, HDA Generic
     4.0 Surround output to Front and Rear speakers
surround41:CARD=MID,DEV=0
     HDA Intel MID, HDA Generic
     4.1 Surround output to Front, Rear and Subwoofer speakers
surround50:CARD=MID,DEV=0
     HDA Intel MID, HDA Generic
     5.0 Surround output to Front, Center and Rear speakers
surround51:CARD=MID,DEV=0
     HDA Intel MID, HDA Generic
     5.1 Surround output to Front, Center, Rear and Subwoofer speakers
surround71:CARD=MID,DEV=0
     HDA Intel MID, HDA Generic
     7.1 Surround output to Front, Center, Side, Rear and Woofer  
speakers
null
     Discard all samples (playback) or generate zero samples (capture)
pulse
     PulseAudio Sound Server
default
     Default
[root@localhost ~]#

[root@localhost ~]# alsamixer
ALSA lib pulse.c:272:(pulse_connect) PulseAudio: Unable to connect:  
Connection refused


alsamixer: function snd_ctl_open failed for default: Connection refused


--Apple-Mail-12--342977177
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Apple-Mail-12--342977177--
