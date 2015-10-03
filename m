From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [PATCH 1/7] ALSA: firewire-tascam: add skeleton
 for TASCAM FireWire series
Date: Sat, 3 Oct 2015 12:33:33 +0200
Message-ID: <20151003123333.3c29000d@kant>
References: <1443704537-3345-2-git-send-email-o-takashi@sakamocchi.jp>
 <201510012147.nfdOjouA%fengguang.wu@intel.com>
 <s5hd1wxdyr7.wl-tiwai@suse.de> <560ED14A.2060404@ladisch.de>
 <560F3EB0.7020508@sakamocchi.jp> <s5hzj00cp2m.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from einhorn.in-berlin.de (einhorn.in-berlin.de [192.109.42.8])
 by alsa0.perex.cz (Postfix) with ESMTP id 91955260688
 for <alsa-devel@alsa-project.org>; Sat,  3 Oct 2015 12:33:40 +0200 (CEST)
In-Reply-To: <s5hzj00cp2m.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: alsa-devel@alsa-project.org, Clemens Ladisch <clemens@ladisch.de>, kbuild test robot <lkp@intel.com>, ffado-devel@lists.sf.net, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org

On Oct 03 Takashi Iwai wrote:
> On Sat, 03 Oct 2015 04:34:24 +0200,
> Takashi Sakamoto wrote:
> > 
> > Hi,
> > 
> > On Oct 13 2015 03:47, Clemens Ladisch wrote:
> > > Takashi Iwai wrote:
> > >> kbuild test robot wrote:
> > >>>>> sound/firewire/tascam/tascam.c:23:16: sparse: cast to restricted __be32
> > >>>
> > >>>   > 23		data = be32_to_cpu(fw_dev->config_rom[28]);
> > >>
> > >> The code itself looks correct.  data is CPU endian.
> > >> The problem looks rather like that fw_dev->config_rom[] is u32.
> > >>
> > >> Stefan, can it be changed to __be32 instead?
> > > 
> > > config_rom[] is CPU endian, too.
> > > 
> > > Strings should be read with fw_csr_string().
> > 
> > The function is designed for IEEE 1212 compliant config ROM. On the
> > other hand, config ROMs of these models are not fully compliant. See:
> > 
> > http://sourceforge.net/p/linux1394/mailman/message/33899800/
> > 
> > Currently, this driver supports just two models. These two models have
> > similar structure in their config ROM, fortunately. Thus, it's
> > reasonable for the driver to get information in hard-coded position of
> > config ROM.

You mention in the changelog that you support the models FW-1884 and
FW-1802, but that there is a third model which you cannot support yet due
to lack of information.  ---  Considering this limited number of models,
and if you are confident that there are no firmware revisions with
different config ROM offsets, then I agree that using hard-coded offsets
is a good way to retrieve the model-dependent information.

> > About using 'be32_to_cpu()', the 'config_rom' member actually has 'const
> > u32 *', while in the member caracters in the textual leaf are aligned in
> > big-endian. I selected the simplest way to pick it up.
> > 
> > If it's preferrable to suppress the sparse warnings, I don't mind to
> > replace these codes with the other ways.
> 
> Maybe introducing a macro would make things clearer.  It's better than
> open-coding at each place, in anyway.

I think it can all be made a lot simpler.  Quoting the patch 1/7:

+static const struct ieee1394_device_id snd_tscm_id_table[] = {
+	/* FW-1082 */
+	{
+		.match_flags = IEEE1394_MATCH_VENDOR_ID |
+			       IEEE1394_MATCH_SPECIFIER_ID |
+			       IEEE1394_MATCH_VERSION,
+		.vendor_id = 0x00022e,
+		.specifier_id = 0x00022e,
+		.version = 0x800003,
+	},
+	/* FW-1884 */
+	{
+		.match_flags = IEEE1394_MATCH_VENDOR_ID |
+			       IEEE1394_MATCH_SPECIFIER_ID |
+			       IEEE1394_MATCH_VERSION,
+		.vendor_id = 0x00022e,
+		.specifier_id = 0x00022e,
+		.version = 0x800000,
+	},
+	/* FW-1804 mey be supported if IDs are clear. */
+	/* FE-08 requires reverse-engineering because it just has faders. */
+	{}
+};

Since the driver is only matching devices with vendor ID 0x00022e, there is
IMO no need to verify the vendor name string in the Configuration ROM.

Do I understand correctly that the model name string needs to be checked
because we don't know yet whether the model FW-1804 contains an own "version"
or duplicates the "version" of FW-1802 or FW-1884?

In other words, if we knew that FW-1804 had a unique "version", then the
function check_name() would not be needed at all.

+static int check_name(struct snd_tscm *tscm)
+{
+	struct fw_device *fw_dev = fw_parent_device(tscm->unit);
+	char vendor[8];
+	char model[8];
+	__u32 data;
+
+	/* Retrieve model name. */
+	data = be32_to_cpu(fw_dev->config_rom[28]);
+	memcpy(model, &data, 4);
+	data = be32_to_cpu(fw_dev->config_rom[29]);
+	memcpy(model + 4, &data, 4);
+	model[7] = '\0';

The config_rom accesses need to be protected by an array bounds check.

The endian conversion actually needs to be the other way around:

	__be32 data;

	/*
	 * Retrieve model name from a bus_dependent_info leaf at
	 * the fixed ROM offsets [25...29], which is formed like a
	 * textual descriptor leaf in minimal ASCII format.
	 */
	data = cpu_to_be32(fw_dev->config_rom[28]);
	memcpy(model, &data, 4);
	data = cpu_to_be32(fw_dev->config_rom[29]);
	memcpy(model + 4, &data, 4);
	model[7] = '\0';

A mathematically equivalent way to code this can be seen in
drivers/firewire/core-device.c::textual_leaf_to_string():  This works
for arbitrary ROM offsets and with arbitrary string lengths.

+	/* Retrieve vendor name. */
+	data = be32_to_cpu(fw_dev->config_rom[23]);
+	memcpy(vendor, &data, 4);
+	data = be32_to_cpu(fw_dev->config_rom[24]);
+	memcpy(vendor + 4, &data, 4);
+	vendor[7] = '\0';

As I said, I think this is not needed since the driver does not deal
with devices from other vendors in the first place.

+	strcpy(tscm->card->driver, "FW-TASCAM");
+	strcpy(tscm->card->shortname, model);
+	strcpy(tscm->card->mixername, model);
+	snprintf(tscm->card->longname, sizeof(tscm->card->longname),
+		 "%s %s, GUID %08x%08x at %s, S%d", vendor, model,
+		 cpu_to_be32(fw_dev->config_rom[3]),
+		 cpu_to_be32(fw_dev->config_rom[4]),
+		 dev_name(&tscm->unit->device), 100 << fw_dev->max_speed);

The GUID needs to be printed without endian conversion:

	"GUID %08x%08x", fw_dev->config_rom[3], fw_dev->config_rom[4]

+	return 0;
+}

The function always returns 0 == no error, therefore it currently
fulfills no other purpose than to fill in card->{short,mixer,long}name.
It definitely does not actually check anything like the function name
suggests.  How about something like this:

/*
 * Retrieve model name from a bus_dependent_info leaf at the fixed ROM
 * offsets [25...29], which is formed like a textual descriptor leaf in
 * minimal ASCII format.
 */
static int check_model_name(struct snd_tscm *tscm)
{
	struct fw_device *fw_dev = fw_parent_device(tscm->unit);
	u32 rom28, rom29;
	const char *model;

	if (fw_dev->config_rom_length < 30) {
		dev_err(tscm->unit->device,
			"unknown Configuration ROM, too short\n"); 
		return -ENODEV;
	}

	rom28 = fw_dev->config_rom[28];
	rom29 = fw_dev->config_rom[29];

	if (rom28 == 0x46572d31 && rom29 == 0x30383200) {
		model = "FW-1082";
	} else if (rom28 == 0x46572d31 && rom29 == 0x38383400) {
		model = "FW-1884";
	} else {
		dev_err(tscm->unit->device,
			"unknown model %04x %04x\n", rom28, rom29);
		return -ENODEV;
	}

	strcpy(tscm->card->driver, "FW-TASCAM");
	strcpy(tscm->card->shortname, model);
	strcpy(tscm->card->mixername, model);
	snprintf(tscm->card->longname, sizeof(tscm->card->longname),
		 "TASCAM %s, GUID %08x%08x at %s, S%d", model,
		 fw_dev->config_rom[3], fw_dev->config_rom[4],
		 dev_name(&tscm->unit->device), 100 << fw_dev->max_speed);

	return 0;
}

Not compile-tested.
-- 
Stefan Richter
-=====-===== =-=- ---==
http://arcgraph.de/sr/
