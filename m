From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: alsactl init - implementation and more..
Date: Wed, 13 Aug 2008 16:04:47 +0200 (CEST)
Message-ID: <Pine.LNX.4.61.0808131510350.21669@tm8103-a.perex-int.cz>
References: <Pine.LNX.4.61.0808131205130.21669@tm8103-a.perex-int.cz>
	<s5h3al99ixf.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 5E21D24489
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Aug 2008 16:04:54 +0200 (CEST)
In-Reply-To: <s5h3al99ixf.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 13 Aug 2008, Takashi Iwai wrote:

> At Wed, 13 Aug 2008 12:59:32 +0200 (CEST),
> Jaroslav Kysela wrote:
> > 
> > Hi,
> > 
> > 	some developers probably already noted, I commited to alsactl 
> > utility (alsa-utils package) initial implementation of soundcard 
> > initialization stuff aka 'alsactl init'.
> 
> Yeah, looks good.

Thanks.

> > 	The basic idea was to "reuse" nice udev configuration style and 
> > modify it to ALSA purposes. I hope that I ended up with a syntax which is 
> > easy understandable and configuration can be created with minimal effort.
> > Please, look to 'man 7 alsactl_init' for more details and to 
> > alsa-utils/alsactl/init directory for example files.
> 
> The card-specific configs shouldn't be read from 00main, but read from
> its file, i.e. 50hda.  That is, the config files are to be simply
> added / removed without modifying the existing file.

I'm not sure if it's useful for our purposes. The 00main also contains
some "global" configuration (like SYSFS_DEVICE setup and more variables 
can be added in future) and my initial (not saying that it's optimal) 
configuration assumes that first file lookup is a driver name.

If you like to add extra configuration files in a directory, I would 
enhance 'INCLUDE' executer code to check, if the source path is directory 
and then include all files from it. But for the standard "database" 
purposes, I don't see a reason to check every file and skip contents of 
large files just after parsing first lines with false condition.

Note that the difference between udev and 'alsactl init' is that udev do 
not know which event will come from kernel - in this case is necessary to 
trace whole database, but 'alsactl init' is designed for 'one shot' run 
like a supporting tool for udev and/or /etc/init.d startup script.

> One missing feature is to store the values in dB unit.  That would be
> more robust and commonly used over different hardwares than raw
> values, even if they have different resolutions.  Also, enum value
> strings are missing.

Yes, for initial implementation I ommited to add some these extra 
features. Anyway, if hardware and driver are correctly identified, these 
helpers are not much useful. But for "universal" initialization they make 
sense. I'll add them.

> Another would-be-nice feature is one command to do both init and
> restore.  First initialize the hardware, then restore (overwrite) the
> setting from the asound.state if already eixsts.  This is what udev
> needs to call.

I'm not sure. The restore action will always overwrite all 'init' values 
(at least when control identifier list is not changed in the driver). 
Probably, I would prefer a buildin procedure like 'if restore fails then 
do init'. What about 'alsactl boot' action name?

> > 	Note that the runtime evaluation of commands can be modified using 
> > environment variables like udev does. Just try 'alsactl -E CMD=help init' 
> > or 'CMD=help alsactl init'.
> > 	Hardware can be detected using sysfs. For older kernel, I'm 
> > plannig to add some compatibility layer to read at least 
> > ATTR{subsystem_vendor} and ATTR{subsystem_device} information from procfs 
> > (codec files).
> 
> In the case of HD-audio, there could be still a bit pain.  Some
> hardwares cannot be detected via PCI SSID but only via codec SSID
> (PKU) or codec revision ID which aren't exposed via sysfs.  But, I
> guess this is a rare case and the mixer settings are likely same among
> these devices with the same PCI SSID.

What about this patch to allow CARDINFO{components} matching:

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 529bd5f..4f32911 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -588,7 +588,7 @@ int __devinit snd_hda_codec_new(struct hda_bus *bus, unsigned int codec_addr,
 				struct hda_codec **codecp)
 {
 	struct hda_codec *codec;
-	char component[13];
+	char component[31];
 	int err;
 
 	if (snd_BUG_ON(!bus))
@@ -693,7 +693,7 @@ int __devinit snd_hda_codec_new(struct hda_bus *bus, unsigned int codec_addr,
 	snd_hda_create_hwdep(codec);
 #endif
 
-	sprintf(component, "HDA:%08x", codec->vendor_id);
+	sprintf(component, "HDA:%08x,%08x,%08x", codec->vendor_id, codec->subsystem_id, codec->revision_id);
 	snd_component_add(codec->bus->card, component);
 
 	if (codecp)

The only limitation is that components variable in snd_ctl_card_info has 
only 80 chars. Only first two codecs can be identified.

				Thanks for your review,
						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
