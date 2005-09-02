From: Raymond <rayau@netvigator.com>
Subject: Re: problems with snd_au8830 module under mandriva 2005
Date: Fri, 02 Sep 2005 11:51:45 +0800
Message-ID: <4317CC51.3040709@netvigator.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
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
To: Erik <assie2@zonnet.nl>
Cc: Alien <alien999999999@users.sourceforge.net>, Igor Kovalenko <garrison@mail.ru>, openvortex-dev@nongnu.org, alsa-devel@lists.sourceforge.net, Manuel Jander <manuel.jander@gmail.com>
List-Id: alsa-devel@alsa-project.org

I am not sure Alien's au8810 patch is as same as Igor Kovalenko 's
au8820 patch. They seem to have their own patches.

The EQ part in diff11.diff seem to be not tested since EQ is not present
in au8820.

You should cc your reply to openvortex-dev@nongnu.org and
alsa-devel@lists.sourceforge.net so that the others can keep track of
your problem.

There are 3 bug reports for AMD64 in ALSA BTS.
1047 - au8810
1138 - au8820
1025 - au8830

Need feedback from testers with au8810/au8820/au8830 and 32bits/64bits
machines to debug this patch.

1) EQ, SPDIF of au8810/au8830 are not present in au8820,
2) WT of au8820/au8830 are not present in au8810,
3) SoftModem of au8810 are not present in au8820.
4) 3D of au8830 is not present in au8810/au8820.

Please correct me if I am wrong, I think au8810 do not have any 3D
effect hardware.

The essential part of the AMD64 patch is

void __iomem *mmio
#define    hwread(x,y) readl((x)+(y))
#define    hwwrite(x,y,z) writel((z),(x)+(y))

read/write 32bits data from/to memory-mapped I/O with 32bits address on
32bits machines and 64bits address on 64bits machines.

There are other 32bits and 64bits incompatibilites in different part of
the driver.

1) DMA, SRC, Hardware Mixer, Equalizer, Capturing
2) MPU401, Gameport, SPDIF
3) 3D, XTALK, WT

Please clearly describe your volume bar problem.

The error is the parameters in functions declared in au88x0_xtalk.c not
matched with those in au88x0_xtalk.h.

It's diffcult to say the change of XTALK part in diff1.diff is right or
wrong.

Any hint on how to debug the XTALK canceller ?

How about implement a kcontrol to change xt_mode by alsamixer ?

WARNING : Select narrow mode seem to produce a VERY HIGH pitch.

static int
snd_vortex_xtalk_info(snd_kcontrol_t * kcontrol, snd_ctl_elem_info_t *
uinfo)
{	
	static char *texts[] = {"Default", "Headphone", "Wide", "Narrow",
"Diamond"};
	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
	uinfo->count = 1;
	uinfo->value.enumerated.items = 5;
	if (uinfo->value.enumerated.item >= uinfo->value.enumerated.items)
		uinfo->value.enumerated.item = uinfo->value.enumerated.items - 1;
	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
	return 0;
}

static int
snd_vortex_xtalk_get(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t *
ucontrol)
{
	vortex_t *vortex = snd_kcontrol_chip(kcontrol);
	ucontrol->value.enumerated.item[0]=vortex->xt_mode;
	return 0;
}

static int
snd_vortex_xtalk_put(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t *
ucontrol)
{
	int changed;
	vortex_t *vortex = snd_kcontrol_chip(kcontrol);
	if ( vortex->xt_mode == ucontrol->value.enumerated.item[0] )
		changed=0;
	else
		changed=1;
	Vort3DRend_Initialize(vortex, ucontrol->value.enumerated.item[0] );
	return changed;
}

static snd_kcontrol_new_t snd_vortex_xtalk_kcontrol __devinitdata = {
	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
	.name = "XTALK Playback",
	.access = SNDRV_CTL_ELEM_ACCESS_READWRITE,
	.info = snd_vortex_xtalk_info,
	.get = snd_vortex_xtalk_get,
	.put = snd_vortex_xtalk_put,

};


Please post the output

lspci -vvn

cat /proc/asound/au8830/codec97#0/ac97#0-0+regs

using the patch manager at openvortex

http://savannah.nongnu.org/patch/download.php?item_id=3948



> this is what i get when compiling the kernel
> but maybe i have to delete the kernel source tree
> because i can remember that i had allready patched the alsa part before
> a long time ago
> it was in june i posted the error and not long after that alien from
> nongnu list contacted me and told me about a patch/.diff
> i have a working alsa driver with that diff but the only problem still
> is that the volume bar is acting strange so i think i have allready done
> this patch
> but i was glad i could compile it under 64 bit kernel
>
> do you know if this is the same patch if not i will clean all sources
> and compile the kernel again.
>
> Erik
>
>
>
> CC [M]  sound/pci/au88x0/au8830.o
> In file included from sound/pci/au88x0/au8830.c:17:
> sound/pci/au88x0/au88x0_xtalk.c:645: error: conflicting types for
> 'vortex_XtalkHw_SetSampleRate'
> sound/pci/au88x0/au88x0_xtalk.h:51: error: previous declaration of
> 'vortex_XtalkHw_SetSampleRate' was here
> sound/pci/au88x0/au88x0_xtalk.c:645: error: conflicting types for
> 'vortex_XtalkHw_SetSampleRate'
> sound/pci/au88x0/au88x0_xtalk.h:51: error: previous declaration of
> 'vortex_XtalkHw_SetSampleRate' was here
> sound/pci/au88x0/au88x0_xtalk.h:51: warning:
> 'vortex_XtalkHw_SetSampleRate' declared `static' but never defined
> sound/pci/au88x0/au88x0_xtalk.c:645: warning:
> 'vortex_XtalkHw_SetSampleRate' defined but not used
> make[3]: *** [sound/pci/au88x0/au8830.o] Error 1
> make[2]: *** [sound/pci/au88x0] Error 2
> make[1]: *** [sound/pci] Error 2
> make: *** [sound] Error 2
>
>




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
