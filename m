From: "Koul, Vinod" <vinod.koul@intel.com>
Subject: SND_SOC_DAPM_VIRT_MUX question
Date: Thu, 07 Apr 2011 14:50:08 +0530
Message-ID: <1302168008.27103.21.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id D1E491037F2
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Apr 2011 11:50:25 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa <alsa-devel@alsa-project.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

Hi,

I have the audio DSP decoder which I tried to connect to the codec.
The decoder output is treated as Input. For the VIRT MUX i gave register
bits as SND_SOC_NOPM both in MUX as well as enum describing this as my
aim is to create a virtual mux for routing.

Aim is to have usespace be able to use this mux and connect to either
headset or speaker DAI or leave it non connected. Machine driver map is
taking care of this.

But the problem is that the this VIRT mux is not allowing me to change
values :(, set to to 1.
I remember that code checks if the path should be allowed for MUX and
implements only if its allowed, but in virtual mix case it should not do
so... or I am missing something?

static const char *sn95031_decoder_text[] = {"None", "Speaker",
	"Headset"};
static const struct soc_enum sn95031_decoder_enum =
       	SOC_ENUM_SINGLE(SND_SOC_NOPM, 0, 3, sn95031_decoder_text);
static const struct snd_kcontrol_new sn95031_decoder_control =
	SOC_DAPM_ENUM("Route", sn95031_decoder_enum);

SND_SOC_DAPM_VIRT_MUX_E("Compressed Decoder Mux",
                        SND_SOC_NOPM, 0, 0, &sn95031_decoder_control,
                        sn95031_decoder_event, SND_SOC_DAPM_POST_PMD),
SND_SOC_DAPM_INPUT("Dummy"), /* sst decoder output*/

        /* decoder output map */
        {"Compressed Decoder Mux", NULL, "Compressed Decoder"},
        {"IHFDAC Left", "Speaker", "Compressed Decoder Mux"},
        {"IHFDAC Right", "Speaker", "Compressed Decoder Mux"},
        {"PCM2_IN", "Headset", "Compressed Decoder Mux"},
        {"Dummy", "None", "Compressed Decoder Mux"},

-- 
~Vinod
