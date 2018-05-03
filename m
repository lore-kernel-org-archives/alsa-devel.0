From: "Pan, Xiuli" <xiuli.pan@linux.intel.com>
Subject: Re: [PATCH alsa-lib] conf/ucm: Add a UCM profile for
 Dell WD15 Dock USB-audio
Date: Thu, 3 May 2018 13:20:53 +0800
Message-ID: <7a8c0202-87e7-69af-ab4e-05398a749432@linux.intel.com>
References: <20180502145431.4192-1-tiwai@suse.de>
 <s5ha7tinl2b.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id CEE0A266F46
 for <alsa-devel@alsa-project.org>; Thu,  3 May 2018 07:20:54 +0200 (CEST)
In-Reply-To: <s5ha7tinl2b.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



On 5/2/2018 23:17, Takashi Iwai wrote:
> On Wed, 02 May 2018 16:54:31 +0200,
> Takashi Iwai wrote:
>> USB-audio device on Dell WD15 docking station provides two individual
>> PCM streams, one for headphone and another for line out.  A UCM
>> profile gives the proper roles for these.
>>
>> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> The change in configure.ac was missing.  Below is the corrected one.
> Sorry for the mess.
The V1 patch seems to be merged in the master branch.
I send a patch to fix the build error based on your V2 version patch.

Thanks
Xiuli

>
> Takashi
>
> -- 8< --
> From: Takashi Iwai <tiwai@suse.de>
> Subject: [PATCH alsa-lib v2] conf/ucm: Add a UCM profile for Dell WD15 Dock USB-audio
>
> USB-audio device on Dell WD15 docking station provides two individual
> PCM streams, one for headphone and another for line out.  A UCM
> profile gives the proper roles for these.
>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>   configure.ac                                    |  1 +
>   src/conf/ucm/Dell-WD15-Dock/Dell-WD15-Dock.conf |  5 +++++
>   src/conf/ucm/Dell-WD15-Dock/HiFi.conf           | 26 +++++++++++++++++++++++++
>   src/conf/ucm/Dell-WD15-Dock/Makefile.am         |  4 ++++
>   src/conf/ucm/Makefile.am                        |  1 +
>   5 files changed, 37 insertions(+)
>   create mode 100644 src/conf/ucm/Dell-WD15-Dock/Dell-WD15-Dock.conf
>   create mode 100644 src/conf/ucm/Dell-WD15-Dock/HiFi.conf
>   create mode 100644 src/conf/ucm/Dell-WD15-Dock/Makefile.am
>
> diff --git a/configure.ac b/configure.ac
> index 3ee989eb32e1..693b5d538436 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -725,6 +725,7 @@ AC_OUTPUT(Makefile doc/Makefile doc/pictures/Makefile doc/doxygen.cfg \
>   	  src/conf/ucm/chtrt5645-mono-speaker-analog-mic/Makefile \
>   	  src/conf/ucm/DAISY-I2S/Makefile \
>   	  src/conf/ucm/DB410c/Makefile \
> +	  src/conf/ucm/Dell-WD15-Dock/Makefile \
>   	  src/conf/ucm/GoogleNyan/Makefile \
>   	  src/conf/ucm/gpd-win-pocket-rt5645/Makefile \
>   	  src/conf/ucm/HDAudio-Gigabyte-ALC1220DualCodecs/Makefile \
> diff --git a/src/conf/ucm/Dell-WD15-Dock/Dell-WD15-Dock.conf b/src/conf/ucm/Dell-WD15-Dock/Dell-WD15-Dock.conf
> new file mode 100644
> index 000000000000..f4f0a8d97e73
> --- /dev/null
> +++ b/src/conf/ucm/Dell-WD15-Dock/Dell-WD15-Dock.conf
> @@ -0,0 +1,5 @@
> +Comment "USB-audio on Dell WD15 docking station"
> +SectionUseCase."HiFi" {
> +	File "HiFi.conf"
> +	Comment "Default"
> +}
> diff --git a/src/conf/ucm/Dell-WD15-Dock/HiFi.conf b/src/conf/ucm/Dell-WD15-Dock/HiFi.conf
> new file mode 100644
> index 000000000000..b07f34400086
> --- /dev/null
> +++ b/src/conf/ucm/Dell-WD15-Dock/HiFi.conf
> @@ -0,0 +1,26 @@
> +SectionDevice."Headphone" {
> +	Comment "Headphone"
> +
> +	Value {
> +		PlaybackChannels "2"
> +		PlaybackPCM "hw:WD15Dock,0"
> +	}
> +}
> +
> +SectionDevice."LineOut" {
> +	Comment "Line Out"
> +
> +	Value {
> +		PlaybackChannels "2"
> +		PlaybackPCM "hw:WD15Dock,1"
> +	}
> +}
> +
> +SectionDevice."Mic" {
> +	Comment "Microphone"
> +
> +	Value {
> +		CaptureChannels "2"
> +		CapturePCM "hw:WD15Dock,0"
> +	}
> +}
> diff --git a/src/conf/ucm/Dell-WD15-Dock/Makefile.am b/src/conf/ucm/Dell-WD15-Dock/Makefile.am
> new file mode 100644
> index 000000000000..7ab58730dc26
> --- /dev/null
> +++ b/src/conf/ucm/Dell-WD15-Dock/Makefile.am
> @@ -0,0 +1,4 @@
> +alsaconfigdir = @ALSA_CONFIG_DIR@
> +ucmdir = $(alsaconfigdir)/ucm/Dell-WD15-Dock
> +ucm_DATA = Dell-WD15-Dock.conf HiFi.conf
> +EXTRA_DIST = $(ucm_DATA)
> diff --git a/src/conf/ucm/Makefile.am b/src/conf/ucm/Makefile.am
> index 02df25f01b25..38fc6b252bcb 100644
> --- a/src/conf/ucm/Makefile.am
> +++ b/src/conf/ucm/Makefile.am
> @@ -7,6 +7,7 @@ chtrt5645 \
>   chtrt5645-mono-speaker-analog-mic \
>   DAISY-I2S \
>   DB410c \
> +Dell-WD15-Dock \
>   GoogleNyan \
>   gpd-win-pocket-rt5645 \
>   HDAudio-Gigabyte-ALC1220DualCodecs \
