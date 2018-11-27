From: Hans de Goede <hdegoede@redhat.com>
Subject: Re: [PATCH] conf: Move UCM profile snippets into
 ucm-includes subdirectory
Date: Tue, 27 Nov 2018 20:00:04 +0100
Message-ID: <363fce83-249a-6525-a89d-dd55057524cc@redhat.com>
References: <20181127130852.7567-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com
 [209.85.208.68])
 by alsa0.perex.cz (Postfix) with ESMTP id EB02E26770D
 for <alsa-devel@alsa-project.org>; Tue, 27 Nov 2018 20:00:07 +0100 (CET)
Received: by mail-ed1-f68.google.com with SMTP id x30so19968612edx.2
 for <alsa-devel@alsa-project.org>; Tue, 27 Nov 2018 11:00:07 -0800 (PST)
In-Reply-To: <20181127130852.7567-1-tiwai@suse.de>
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
Cc: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On 27-11-18 14:08, Takashi Iwai wrote:
> We have placed UCM profile snippets to be included by the main config
> files also in the same directory, src/conf/ucm, it confuses alsaucm
> program that scans over all subdirectories.  It thinks such a file is
> also the main config file, and spews errors like:
>    % alsaucm
>    ALSA lib utils.c:67:(uc_mgr_config_load) could not open configuration file /usr/share/alsa/ucm/bytcr/bytcr.conf
>    ALSA lib parser.c:1427:(load_master_config) error: could not parse configuration for card bytcr
>    alsaucm: unable to obtain card list: No such file or directory
> 
> For avoiding this, move UCM profile snippets into the own root
> directory, src/conf/ucm-includes, and include them by changing the
> include with "<searchdir:ucm-includes>".
> 
> Suggested-by: Hans de Goede <hdegoede@redhat.com>
> Signed-off-by: Takashi Iwai <tiwai@suse.de>

Looks good to me, thank you for doing this (I was about to reply
in the other thread that I did't know when I could make time
for this).

Regards,

Hans



> ---
>   configure.ac                                             | 9 +++++----
>   src/conf/Makefile.am                                     | 2 +-
>   src/conf/ucm-includes/Makefile.am                        | 5 +++++
>   src/conf/{ucm => ucm-includes}/bytcr/Makefile.am         | 2 +-
>   .../{ucm => ucm-includes}/bytcr/PlatformDisableSeq.conf  | 0
>   .../{ucm => ucm-includes}/bytcr/PlatformEnableSeq.conf   | 0
>   src/conf/{ucm => ucm-includes}/nau8824/EnableSeq.conf    | 0
>   src/conf/{ucm => ucm-includes}/nau8824/HeadPhones.conf   | 0
>   src/conf/{ucm => ucm-includes}/nau8824/HeadsetMic.conf   | 0
>   src/conf/{ucm => ucm-includes}/nau8824/InternalMic.conf  | 0
>   src/conf/{ucm => ucm-includes}/nau8824/Makefile.am       | 2 +-
>   src/conf/{ucm => ucm-includes}/nau8824/MonoSpeaker.conf  | 0
>   src/conf/{ucm => ucm-includes}/nau8824/Speaker.conf      | 0
>   src/conf/{ucm => ucm-includes}/rt5640/DigitalMics.conf   | 0
>   src/conf/{ucm => ucm-includes}/rt5640/EnableSeq.conf     | 0
>   src/conf/{ucm => ucm-includes}/rt5640/HeadPhones.conf    | 0
>   src/conf/{ucm => ucm-includes}/rt5640/HeadsetMic.conf    | 0
>   .../{ucm => ucm-includes}/rt5640/IN1-InternalMic.conf    | 0
>   .../{ucm => ucm-includes}/rt5640/IN3-InternalMic.conf    | 0
>   src/conf/{ucm => ucm-includes}/rt5640/Makefile.am        | 2 +-
>   src/conf/{ucm => ucm-includes}/rt5640/MonoSpeaker.conf   | 0
>   src/conf/{ucm => ucm-includes}/rt5640/Speaker.conf       | 0
>   src/conf/{ucm => ucm-includes}/rt5651/EnableSeq.conf     | 0
>   .../{ucm => ucm-includes}/rt5651/HeadPhones-swapped.conf | 0
>   src/conf/{ucm => ucm-includes}/rt5651/HeadPhones.conf    | 0
>   .../{ucm => ucm-includes}/rt5651/IN1-InternalMic.conf    | 0
>   .../{ucm => ucm-includes}/rt5651/IN12-InternalMic.conf   | 0
>   .../{ucm => ucm-includes}/rt5651/IN2-InternalMic.conf    | 0
>   .../{ucm => ucm-includes}/rt5651/IN3-HeadsetMic.conf     | 0
>   src/conf/{ucm => ucm-includes}/rt5651/Makefile.am        | 2 +-
>   src/conf/{ucm => ucm-includes}/rt5651/MonoSpeaker.conf   | 0
>   src/conf/{ucm => ucm-includes}/rt5651/Speaker.conf       | 0
>   src/conf/ucm/Makefile.am                                 | 4 ----
>   .../ucm/PIPO-W2S-Defaultstring-CherryTrailCR/HiFi.conf   | 2 +-
>   src/conf/ucm/bytcr-rt5640-mono-spk-dmic1-mic/HiFi.conf   | 2 +-
>   src/conf/ucm/bytcr-rt5640-mono-spk-in1-mic/HiFi.conf     | 2 +-
>   src/conf/ucm/bytcr-rt5640-mono-spk-in3-mic/HiFi.conf     | 2 +-
>   src/conf/ucm/bytcr-rt5640-stereo-spk-dmic1-mic/HiFi.conf | 2 +-
>   src/conf/ucm/bytcr-rt5640-stereo-spk-in1-mic/HiFi.conf   | 2 +-
>   src/conf/ucm/bytcr-rt5640-stereo-spk-in3-mic/HiFi.conf   | 2 +-
>   src/conf/ucm/bytcr-rt5640/HiFi.conf                      | 2 +-
>   src/conf/ucm/bytcr-rt5651-mono-spk-in1-mic/HiFi.conf     | 2 +-
>   .../bytcr-rt5651-mono-spk-in2-mic-hp-swapped/HiFi.conf   | 2 +-
>   src/conf/ucm/bytcr-rt5651-mono-spk-in2-mic/HiFi.conf     | 2 +-
>   src/conf/ucm/bytcr-rt5651-stereo-spk-in1-mic/HiFi.conf   | 2 +-
>   src/conf/ucm/bytcr-rt5651-stereo-spk-in12-mic/HiFi.conf  | 2 +-
>   src/conf/ucm/bytcr-rt5651-stereo-spk-in2-mic/HiFi.conf   | 2 +-
>   src/conf/ucm/bytcr-rt5651/HiFi.conf                      | 2 +-
>   src/conf/ucm/chtnau8824/HiFi.conf                        | 2 +-
>   .../ucm/cube-i1_TF-Defaultstring-CherryTrailCR/HiFi.conf | 2 +-
>   50 files changed, 32 insertions(+), 30 deletions(-)
>   create mode 100644 src/conf/ucm-includes/Makefile.am
>   rename src/conf/{ucm => ucm-includes}/bytcr/Makefile.am (72%)
>   rename src/conf/{ucm => ucm-includes}/bytcr/PlatformDisableSeq.conf (100%)
>   rename src/conf/{ucm => ucm-includes}/bytcr/PlatformEnableSeq.conf (100%)
>   rename src/conf/{ucm => ucm-includes}/nau8824/EnableSeq.conf (100%)
>   rename src/conf/{ucm => ucm-includes}/nau8824/HeadPhones.conf (100%)
>   rename src/conf/{ucm => ucm-includes}/nau8824/HeadsetMic.conf (100%)
>   rename src/conf/{ucm => ucm-includes}/nau8824/InternalMic.conf (100%)
>   rename src/conf/{ucm => ucm-includes}/nau8824/Makefile.am (78%)
>   rename src/conf/{ucm => ucm-includes}/nau8824/MonoSpeaker.conf (100%)
>   rename src/conf/{ucm => ucm-includes}/nau8824/Speaker.conf (100%)
>   rename src/conf/{ucm => ucm-includes}/rt5640/DigitalMics.conf (100%)
>   rename src/conf/{ucm => ucm-includes}/rt5640/EnableSeq.conf (100%)
>   rename src/conf/{ucm => ucm-includes}/rt5640/HeadPhones.conf (100%)
>   rename src/conf/{ucm => ucm-includes}/rt5640/HeadsetMic.conf (100%)
>   rename src/conf/{ucm => ucm-includes}/rt5640/IN1-InternalMic.conf (100%)
>   rename src/conf/{ucm => ucm-includes}/rt5640/IN3-InternalMic.conf (100%)
>   rename src/conf/{ucm => ucm-includes}/rt5640/Makefile.am (81%)
>   rename src/conf/{ucm => ucm-includes}/rt5640/MonoSpeaker.conf (100%)
>   rename src/conf/{ucm => ucm-includes}/rt5640/Speaker.conf (100%)
>   rename src/conf/{ucm => ucm-includes}/rt5651/EnableSeq.conf (100%)
>   rename src/conf/{ucm => ucm-includes}/rt5651/HeadPhones-swapped.conf (100%)
>   rename src/conf/{ucm => ucm-includes}/rt5651/HeadPhones.conf (100%)
>   rename src/conf/{ucm => ucm-includes}/rt5651/IN1-InternalMic.conf (100%)
>   rename src/conf/{ucm => ucm-includes}/rt5651/IN12-InternalMic.conf (100%)
>   rename src/conf/{ucm => ucm-includes}/rt5651/IN2-InternalMic.conf (100%)
>   rename src/conf/{ucm => ucm-includes}/rt5651/IN3-HeadsetMic.conf (100%)
>   rename src/conf/{ucm => ucm-includes}/rt5651/Makefile.am (84%)
>   rename src/conf/{ucm => ucm-includes}/rt5651/MonoSpeaker.conf (100%)
>   rename src/conf/{ucm => ucm-includes}/rt5651/Speaker.conf (100%)
> 
> diff --git a/configure.ac b/configure.ac
> index 4c9d860fd0e5..0b7a1bdc42fa 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -720,7 +720,6 @@ AC_OUTPUT(Makefile doc/Makefile doc/pictures/Makefile doc/doxygen.cfg \
>   	  src/conf/ucm/ASUSTeKCOMPUTERINC.-T100HAN-1.0-T100HAN/Makefile \
>   	  src/conf/ucm/broadwell-rt286/Makefile \
>   	  src/conf/ucm/broxton-rt298/Makefile \
> -	  src/conf/ucm/bytcr/Makefile \
>   	  src/conf/ucm/bytcr-rt5640/Makefile \
>   	  src/conf/ucm/bytcr-rt5640-mono-spk-dmic1-mic/Makefile \
>   	  src/conf/ucm/bytcr-rt5640-mono-spk-in1-mic/Makefile \
> @@ -747,18 +746,20 @@ AC_OUTPUT(Makefile doc/Makefile doc/pictures/Makefile doc/doxygen.cfg \
>   	  src/conf/ucm/HDAudio-Gigabyte-ALC1220DualCodecs/Makefile \
>   	  src/conf/ucm/HDAudio-Lenovo-DualCodecs/Makefile \
>   	  src/conf/ucm/LENOVO-80XF-LenovoMIIX320_10ICR-LNVNB161216/Makefile \
> -	  src/conf/ucm/nau8824/Makefile \
>   	  src/conf/ucm/PandaBoard/Makefile \
>   	  src/conf/ucm/PandaBoardES/Makefile \
>   	  src/conf/ucm/PAZ00/Makefile \
>   	  src/conf/ucm/PIPO-W2S-Defaultstring-CherryTrailCR/Makefile \
> -	  src/conf/ucm/rt5640/Makefile \
> -	  src/conf/ucm/rt5651/Makefile \
>   	  src/conf/ucm/SDP4430/Makefile \
>   	  src/conf/ucm/skylake-rt286/Makefile \
>   	  src/conf/ucm/TECLAST-X80Pro-Defaultstring-CherryTrailCR/Makefile \
>   	  src/conf/ucm/tegraalc5632/Makefile \
>   	  src/conf/ucm/VEYRON-I2S/Makefile \
> +	  src/conf/ucm-includes/Makefile \
> +	  src/conf/ucm-includes/bytcr/Makefile \
> +	  src/conf/ucm-includes/nau8824/Makefile \
> +	  src/conf/ucm-includes/rt5640/Makefile \
> +	  src/conf/ucm-includes/rt5651/Makefile \
>   	  src/conf/topology/Makefile \
>   	  src/conf/topology/broadwell/Makefile \
>   	  modules/Makefile modules/mixer/Makefile modules/mixer/simple/Makefile \
> diff --git a/src/conf/Makefile.am b/src/conf/Makefile.am
> index 2b46f95c2cb7..4a4022e9bc1b 100644
> --- a/src/conf/Makefile.am
> +++ b/src/conf/Makefile.am
> @@ -1,7 +1,7 @@
>   SUBDIRS=cards pcm
>   
>   if BUILD_UCM
> -SUBDIRS += ucm
> +SUBDIRS += ucm ucm-includes
>   endif
>   if BUILD_TOPOLOGY
>   SUBDIRS += topology
> diff --git a/src/conf/ucm-includes/Makefile.am b/src/conf/ucm-includes/Makefile.am
> new file mode 100644
> index 000000000000..f94bba7b837f
> --- /dev/null
> +++ b/src/conf/ucm-includes/Makefile.am
> @@ -0,0 +1,5 @@
> +SUBDIRS=\
> +bytcr \
> +rt5640 \
> +rt5651 \
> +nau8824
> diff --git a/src/conf/ucm/bytcr/Makefile.am b/src/conf/ucm-includes/bytcr/Makefile.am
> similarity index 72%
> rename from src/conf/ucm/bytcr/Makefile.am
> rename to src/conf/ucm-includes/bytcr/Makefile.am
> index f7a54cbdedcd..f9565a53eaf2 100644
> --- a/src/conf/ucm/bytcr/Makefile.am
> +++ b/src/conf/ucm-includes/bytcr/Makefile.am
> @@ -1,4 +1,4 @@
>   alsaconfigdir = @ALSA_CONFIG_DIR@
> -ucmdir = $(alsaconfigdir)/ucm/bytcr
> +ucmdir = $(alsaconfigdir)/ucm-includes/bytcr
>   ucm_DATA = PlatformEnableSeq.conf PlatformDisableSeq.conf
>   EXTRA_DIST = $(ucm_DATA)
> diff --git a/src/conf/ucm/bytcr/PlatformDisableSeq.conf b/src/conf/ucm-includes/bytcr/PlatformDisableSeq.conf
> similarity index 100%
> rename from src/conf/ucm/bytcr/PlatformDisableSeq.conf
> rename to src/conf/ucm-includes/bytcr/PlatformDisableSeq.conf
> diff --git a/src/conf/ucm/bytcr/PlatformEnableSeq.conf b/src/conf/ucm-includes/bytcr/PlatformEnableSeq.conf
> similarity index 100%
> rename from src/conf/ucm/bytcr/PlatformEnableSeq.conf
> rename to src/conf/ucm-includes/bytcr/PlatformEnableSeq.conf
> diff --git a/src/conf/ucm/nau8824/EnableSeq.conf b/src/conf/ucm-includes/nau8824/EnableSeq.conf
> similarity index 100%
> rename from src/conf/ucm/nau8824/EnableSeq.conf
> rename to src/conf/ucm-includes/nau8824/EnableSeq.conf
> diff --git a/src/conf/ucm/nau8824/HeadPhones.conf b/src/conf/ucm-includes/nau8824/HeadPhones.conf
> similarity index 100%
> rename from src/conf/ucm/nau8824/HeadPhones.conf
> rename to src/conf/ucm-includes/nau8824/HeadPhones.conf
> diff --git a/src/conf/ucm/nau8824/HeadsetMic.conf b/src/conf/ucm-includes/nau8824/HeadsetMic.conf
> similarity index 100%
> rename from src/conf/ucm/nau8824/HeadsetMic.conf
> rename to src/conf/ucm-includes/nau8824/HeadsetMic.conf
> diff --git a/src/conf/ucm/nau8824/InternalMic.conf b/src/conf/ucm-includes/nau8824/InternalMic.conf
> similarity index 100%
> rename from src/conf/ucm/nau8824/InternalMic.conf
> rename to src/conf/ucm-includes/nau8824/InternalMic.conf
> diff --git a/src/conf/ucm/nau8824/Makefile.am b/src/conf/ucm-includes/nau8824/Makefile.am
> similarity index 78%
> rename from src/conf/ucm/nau8824/Makefile.am
> rename to src/conf/ucm-includes/nau8824/Makefile.am
> index b39b8bb4c934..aa65f4bd9b53 100644
> --- a/src/conf/ucm/nau8824/Makefile.am
> +++ b/src/conf/ucm-includes/nau8824/Makefile.am
> @@ -1,5 +1,5 @@
>   alsaconfigdir = @ALSA_CONFIG_DIR@
> -ucmdir = $(alsaconfigdir)/ucm/nau8824
> +ucmdir = $(alsaconfigdir)/ucm-includes/nau8824
>   ucm_DATA = EnableSeq.conf HeadPhones.conf HeadsetMic.conf InternalMic.conf \
>   	   MonoSpeaker.conf Speaker.conf
>   EXTRA_DIST = $(ucm_DATA)
> diff --git a/src/conf/ucm/nau8824/MonoSpeaker.conf b/src/conf/ucm-includes/nau8824/MonoSpeaker.conf
> similarity index 100%
> rename from src/conf/ucm/nau8824/MonoSpeaker.conf
> rename to src/conf/ucm-includes/nau8824/MonoSpeaker.conf
> diff --git a/src/conf/ucm/nau8824/Speaker.conf b/src/conf/ucm-includes/nau8824/Speaker.conf
> similarity index 100%
> rename from src/conf/ucm/nau8824/Speaker.conf
> rename to src/conf/ucm-includes/nau8824/Speaker.conf
> diff --git a/src/conf/ucm/rt5640/DigitalMics.conf b/src/conf/ucm-includes/rt5640/DigitalMics.conf
> similarity index 100%
> rename from src/conf/ucm/rt5640/DigitalMics.conf
> rename to src/conf/ucm-includes/rt5640/DigitalMics.conf
> diff --git a/src/conf/ucm/rt5640/EnableSeq.conf b/src/conf/ucm-includes/rt5640/EnableSeq.conf
> similarity index 100%
> rename from src/conf/ucm/rt5640/EnableSeq.conf
> rename to src/conf/ucm-includes/rt5640/EnableSeq.conf
> diff --git a/src/conf/ucm/rt5640/HeadPhones.conf b/src/conf/ucm-includes/rt5640/HeadPhones.conf
> similarity index 100%
> rename from src/conf/ucm/rt5640/HeadPhones.conf
> rename to src/conf/ucm-includes/rt5640/HeadPhones.conf
> diff --git a/src/conf/ucm/rt5640/HeadsetMic.conf b/src/conf/ucm-includes/rt5640/HeadsetMic.conf
> similarity index 100%
> rename from src/conf/ucm/rt5640/HeadsetMic.conf
> rename to src/conf/ucm-includes/rt5640/HeadsetMic.conf
> diff --git a/src/conf/ucm/rt5640/IN1-InternalMic.conf b/src/conf/ucm-includes/rt5640/IN1-InternalMic.conf
> similarity index 100%
> rename from src/conf/ucm/rt5640/IN1-InternalMic.conf
> rename to src/conf/ucm-includes/rt5640/IN1-InternalMic.conf
> diff --git a/src/conf/ucm/rt5640/IN3-InternalMic.conf b/src/conf/ucm-includes/rt5640/IN3-InternalMic.conf
> similarity index 100%
> rename from src/conf/ucm/rt5640/IN3-InternalMic.conf
> rename to src/conf/ucm-includes/rt5640/IN3-InternalMic.conf
> diff --git a/src/conf/ucm/rt5640/Makefile.am b/src/conf/ucm-includes/rt5640/Makefile.am
> similarity index 81%
> rename from src/conf/ucm/rt5640/Makefile.am
> rename to src/conf/ucm-includes/rt5640/Makefile.am
> index a6fbdc572529..2cbea4da4543 100644
> --- a/src/conf/ucm/rt5640/Makefile.am
> +++ b/src/conf/ucm-includes/rt5640/Makefile.am
> @@ -1,5 +1,5 @@
>   alsaconfigdir = @ALSA_CONFIG_DIR@
> -ucmdir = $(alsaconfigdir)/ucm/rt5640
> +ucmdir = $(alsaconfigdir)/ucm-includes/rt5640
>   ucm_DATA = DigitalMics.conf EnableSeq.conf HeadPhones.conf HeadsetMic.conf \
>   	IN1-InternalMic.conf IN3-InternalMic.conf MonoSpeaker.conf Speaker.conf
>   EXTRA_DIST = $(ucm_DATA)
> diff --git a/src/conf/ucm/rt5640/MonoSpeaker.conf b/src/conf/ucm-includes/rt5640/MonoSpeaker.conf
> similarity index 100%
> rename from src/conf/ucm/rt5640/MonoSpeaker.conf
> rename to src/conf/ucm-includes/rt5640/MonoSpeaker.conf
> diff --git a/src/conf/ucm/rt5640/Speaker.conf b/src/conf/ucm-includes/rt5640/Speaker.conf
> similarity index 100%
> rename from src/conf/ucm/rt5640/Speaker.conf
> rename to src/conf/ucm-includes/rt5640/Speaker.conf
> diff --git a/src/conf/ucm/rt5651/EnableSeq.conf b/src/conf/ucm-includes/rt5651/EnableSeq.conf
> similarity index 100%
> rename from src/conf/ucm/rt5651/EnableSeq.conf
> rename to src/conf/ucm-includes/rt5651/EnableSeq.conf
> diff --git a/src/conf/ucm/rt5651/HeadPhones-swapped.conf b/src/conf/ucm-includes/rt5651/HeadPhones-swapped.conf
> similarity index 100%
> rename from src/conf/ucm/rt5651/HeadPhones-swapped.conf
> rename to src/conf/ucm-includes/rt5651/HeadPhones-swapped.conf
> diff --git a/src/conf/ucm/rt5651/HeadPhones.conf b/src/conf/ucm-includes/rt5651/HeadPhones.conf
> similarity index 100%
> rename from src/conf/ucm/rt5651/HeadPhones.conf
> rename to src/conf/ucm-includes/rt5651/HeadPhones.conf
> diff --git a/src/conf/ucm/rt5651/IN1-InternalMic.conf b/src/conf/ucm-includes/rt5651/IN1-InternalMic.conf
> similarity index 100%
> rename from src/conf/ucm/rt5651/IN1-InternalMic.conf
> rename to src/conf/ucm-includes/rt5651/IN1-InternalMic.conf
> diff --git a/src/conf/ucm/rt5651/IN12-InternalMic.conf b/src/conf/ucm-includes/rt5651/IN12-InternalMic.conf
> similarity index 100%
> rename from src/conf/ucm/rt5651/IN12-InternalMic.conf
> rename to src/conf/ucm-includes/rt5651/IN12-InternalMic.conf
> diff --git a/src/conf/ucm/rt5651/IN2-InternalMic.conf b/src/conf/ucm-includes/rt5651/IN2-InternalMic.conf
> similarity index 100%
> rename from src/conf/ucm/rt5651/IN2-InternalMic.conf
> rename to src/conf/ucm-includes/rt5651/IN2-InternalMic.conf
> diff --git a/src/conf/ucm/rt5651/IN3-HeadsetMic.conf b/src/conf/ucm-includes/rt5651/IN3-HeadsetMic.conf
> similarity index 100%
> rename from src/conf/ucm/rt5651/IN3-HeadsetMic.conf
> rename to src/conf/ucm-includes/rt5651/IN3-HeadsetMic.conf
> diff --git a/src/conf/ucm/rt5651/Makefile.am b/src/conf/ucm-includes/rt5651/Makefile.am
> similarity index 84%
> rename from src/conf/ucm/rt5651/Makefile.am
> rename to src/conf/ucm-includes/rt5651/Makefile.am
> index acc8ea491043..f513b8c4d6f6 100644
> --- a/src/conf/ucm/rt5651/Makefile.am
> +++ b/src/conf/ucm-includes/rt5651/Makefile.am
> @@ -1,5 +1,5 @@
>   alsaconfigdir = @ALSA_CONFIG_DIR@
> -ucmdir = $(alsaconfigdir)/ucm/rt5651
> +ucmdir = $(alsaconfigdir)/ucm-includes/rt5651
>   ucm_DATA = EnableSeq.conf HeadPhones.conf HeadPhones-swapped.conf \
>   	   IN1-InternalMic.conf IN2-InternalMic.conf IN12-InternalMic.conf \
>   	   IN3-HeadsetMic.conf Speaker.conf MonoSpeaker.conf
> diff --git a/src/conf/ucm/rt5651/MonoSpeaker.conf b/src/conf/ucm-includes/rt5651/MonoSpeaker.conf
> similarity index 100%
> rename from src/conf/ucm/rt5651/MonoSpeaker.conf
> rename to src/conf/ucm-includes/rt5651/MonoSpeaker.conf
> diff --git a/src/conf/ucm/rt5651/Speaker.conf b/src/conf/ucm-includes/rt5651/Speaker.conf
> similarity index 100%
> rename from src/conf/ucm/rt5651/Speaker.conf
> rename to src/conf/ucm-includes/rt5651/Speaker.conf
> diff --git a/src/conf/ucm/Makefile.am b/src/conf/ucm/Makefile.am
> index 7cdc6176584a..2c98eac0b745 100644
> --- a/src/conf/ucm/Makefile.am
> +++ b/src/conf/ucm/Makefile.am
> @@ -2,7 +2,6 @@ SUBDIRS=\
>   ASUSTeKCOMPUTERINC.-T100HAN-1.0-T100HAN \
>   broadwell-rt286 \
>   broxton-rt298 \
> -bytcr \
>   bytcr-rt5640 \
>   bytcr-rt5640-mono-spk-dmic1-mic \
>   bytcr-rt5640-mono-spk-in1-mic \
> @@ -29,13 +28,10 @@ gpd-win-pocket-rt5645 \
>   HDAudio-Gigabyte-ALC1220DualCodecs \
>   HDAudio-Lenovo-DualCodecs \
>   LENOVO-80XF-LenovoMIIX320_10ICR-LNVNB161216 \
> -nau8824 \
>   PandaBoard \
>   PandaBoardES \
>   PAZ00 \
>   PIPO-W2S-Defaultstring-CherryTrailCR \
> -rt5640 \
> -rt5651 \
>   SDP4430 \
>   skylake-rt286 \
>   TECLAST-X80Pro-Defaultstring-CherryTrailCR \
> diff --git a/src/conf/ucm/PIPO-W2S-Defaultstring-CherryTrailCR/HiFi.conf b/src/conf/ucm/PIPO-W2S-Defaultstring-CherryTrailCR/HiFi.conf
> index 799163dbe481..f9c64ea16bd5 100644
> --- a/src/conf/ucm/PIPO-W2S-Defaultstring-CherryTrailCR/HiFi.conf
> +++ b/src/conf/ucm/PIPO-W2S-Defaultstring-CherryTrailCR/HiFi.conf
> @@ -1,4 +1,4 @@
> -<searchdir:ucm>
> +<searchdir:ucm-includes>
>   
>   SectionVerb {
>   
> diff --git a/src/conf/ucm/bytcr-rt5640-mono-spk-dmic1-mic/HiFi.conf b/src/conf/ucm/bytcr-rt5640-mono-spk-dmic1-mic/HiFi.conf
> index 938b359290d4..15b521be02e5 100644
> --- a/src/conf/ucm/bytcr-rt5640-mono-spk-dmic1-mic/HiFi.conf
> +++ b/src/conf/ucm/bytcr-rt5640-mono-spk-dmic1-mic/HiFi.conf
> @@ -1,6 +1,6 @@
>   # Use case Configuration for bytcr-rt5640
>   
> -<searchdir:ucm>
> +<searchdir:ucm-includes>
>   
>   SectionVerb {
>   	EnableSequence [
> diff --git a/src/conf/ucm/bytcr-rt5640-mono-spk-in1-mic/HiFi.conf b/src/conf/ucm/bytcr-rt5640-mono-spk-in1-mic/HiFi.conf
> index f36b245e5092..f9aa2cb2d2b1 100644
> --- a/src/conf/ucm/bytcr-rt5640-mono-spk-in1-mic/HiFi.conf
> +++ b/src/conf/ucm/bytcr-rt5640-mono-spk-in1-mic/HiFi.conf
> @@ -1,6 +1,6 @@
>   # Use case Configuration for bytcr-rt5640
>   
> -<searchdir:ucm>
> +<searchdir:ucm-includes>
>   
>   SectionVerb {
>   	EnableSequence [
> diff --git a/src/conf/ucm/bytcr-rt5640-mono-spk-in3-mic/HiFi.conf b/src/conf/ucm/bytcr-rt5640-mono-spk-in3-mic/HiFi.conf
> index 1a08ededc40c..0bec7f056de1 100644
> --- a/src/conf/ucm/bytcr-rt5640-mono-spk-in3-mic/HiFi.conf
> +++ b/src/conf/ucm/bytcr-rt5640-mono-spk-in3-mic/HiFi.conf
> @@ -1,6 +1,6 @@
>   # Use case Configuration for bytcr-rt5640
>   
> -<searchdir:ucm>
> +<searchdir:ucm-includes>
>   
>   SectionVerb {
>   	EnableSequence [
> diff --git a/src/conf/ucm/bytcr-rt5640-stereo-spk-dmic1-mic/HiFi.conf b/src/conf/ucm/bytcr-rt5640-stereo-spk-dmic1-mic/HiFi.conf
> index 4587b2e1294e..7c8388a0e153 100644
> --- a/src/conf/ucm/bytcr-rt5640-stereo-spk-dmic1-mic/HiFi.conf
> +++ b/src/conf/ucm/bytcr-rt5640-stereo-spk-dmic1-mic/HiFi.conf
> @@ -1,6 +1,6 @@
>   # Use case Configuration for bytcr-rt5640
>   
> -<searchdir:ucm>
> +<searchdir:ucm-includes>
>   
>   SectionVerb {
>   	EnableSequence [
> diff --git a/src/conf/ucm/bytcr-rt5640-stereo-spk-in1-mic/HiFi.conf b/src/conf/ucm/bytcr-rt5640-stereo-spk-in1-mic/HiFi.conf
> index decd396047aa..f074576b053b 100644
> --- a/src/conf/ucm/bytcr-rt5640-stereo-spk-in1-mic/HiFi.conf
> +++ b/src/conf/ucm/bytcr-rt5640-stereo-spk-in1-mic/HiFi.conf
> @@ -1,6 +1,6 @@
>   # Use case Configuration for bytcr-rt5640
>   
> -<searchdir:ucm>
> +<searchdir:ucm-includes>
>   
>   SectionVerb {
>   	EnableSequence [
> diff --git a/src/conf/ucm/bytcr-rt5640-stereo-spk-in3-mic/HiFi.conf b/src/conf/ucm/bytcr-rt5640-stereo-spk-in3-mic/HiFi.conf
> index d243bf823511..b3c2d03a301c 100644
> --- a/src/conf/ucm/bytcr-rt5640-stereo-spk-in3-mic/HiFi.conf
> +++ b/src/conf/ucm/bytcr-rt5640-stereo-spk-in3-mic/HiFi.conf
> @@ -1,6 +1,6 @@
>   # Use case Configuration for bytcr-rt5640
>   
> -<searchdir:ucm>
> +<searchdir:ucm-includes>
>   
>   SectionVerb {
>   	EnableSequence [
> diff --git a/src/conf/ucm/bytcr-rt5640/HiFi.conf b/src/conf/ucm/bytcr-rt5640/HiFi.conf
> index c833fe74845b..97823e3684d2 100644
> --- a/src/conf/ucm/bytcr-rt5640/HiFi.conf
> +++ b/src/conf/ucm/bytcr-rt5640/HiFi.conf
> @@ -1,6 +1,6 @@
>   # Use case Configuration for bytcr-rt5640
>   
> -<searchdir:ucm>
> +<searchdir:ucm-includes>
>   
>   SectionVerb {
>   	EnableSequence [
> diff --git a/src/conf/ucm/bytcr-rt5651-mono-spk-in1-mic/HiFi.conf b/src/conf/ucm/bytcr-rt5651-mono-spk-in1-mic/HiFi.conf
> index dd5b35fc02cb..391e977ddbd0 100644
> --- a/src/conf/ucm/bytcr-rt5651-mono-spk-in1-mic/HiFi.conf
> +++ b/src/conf/ucm/bytcr-rt5651-mono-spk-in1-mic/HiFi.conf
> @@ -1,6 +1,6 @@
>   # Adapted from https://github.com/plbossart/UCM/tree/master/bytcr-rt5651
>   
> -<searchdir:ucm>
> +<searchdir:ucm-includes>
>   
>   SectionVerb {
>   	EnableSequence [
> diff --git a/src/conf/ucm/bytcr-rt5651-mono-spk-in2-mic-hp-swapped/HiFi.conf b/src/conf/ucm/bytcr-rt5651-mono-spk-in2-mic-hp-swapped/HiFi.conf
> index 777ed7836ee5..f0b80194e39c 100644
> --- a/src/conf/ucm/bytcr-rt5651-mono-spk-in2-mic-hp-swapped/HiFi.conf
> +++ b/src/conf/ucm/bytcr-rt5651-mono-spk-in2-mic-hp-swapped/HiFi.conf
> @@ -1,6 +1,6 @@
>   # Adapted from https://github.com/plbossart/UCM/tree/master/bytcr-rt5651
>   
> -<searchdir:ucm>
> +<searchdir:ucm-includes>
>   
>   SectionVerb {
>   	EnableSequence [
> diff --git a/src/conf/ucm/bytcr-rt5651-mono-spk-in2-mic/HiFi.conf b/src/conf/ucm/bytcr-rt5651-mono-spk-in2-mic/HiFi.conf
> index 9f56c077b65a..049b2ebec9ad 100644
> --- a/src/conf/ucm/bytcr-rt5651-mono-spk-in2-mic/HiFi.conf
> +++ b/src/conf/ucm/bytcr-rt5651-mono-spk-in2-mic/HiFi.conf
> @@ -1,6 +1,6 @@
>   # Adapted from https://github.com/plbossart/UCM/tree/master/bytcr-rt5651
>   
> -<searchdir:ucm>
> +<searchdir:ucm-includes>
>   
>   SectionVerb {
>   	EnableSequence [
> diff --git a/src/conf/ucm/bytcr-rt5651-stereo-spk-in1-mic/HiFi.conf b/src/conf/ucm/bytcr-rt5651-stereo-spk-in1-mic/HiFi.conf
> index e2a579ab2261..63570fb45fbb 100644
> --- a/src/conf/ucm/bytcr-rt5651-stereo-spk-in1-mic/HiFi.conf
> +++ b/src/conf/ucm/bytcr-rt5651-stereo-spk-in1-mic/HiFi.conf
> @@ -1,6 +1,6 @@
>   # Adapted from https://github.com/plbossart/UCM/tree/master/bytcr-rt5651
>   
> -<searchdir:ucm>
> +<searchdir:ucm-includes>
>   
>   SectionVerb {
>   	EnableSequence [
> diff --git a/src/conf/ucm/bytcr-rt5651-stereo-spk-in12-mic/HiFi.conf b/src/conf/ucm/bytcr-rt5651-stereo-spk-in12-mic/HiFi.conf
> index ae52e7196110..85516cd23856 100644
> --- a/src/conf/ucm/bytcr-rt5651-stereo-spk-in12-mic/HiFi.conf
> +++ b/src/conf/ucm/bytcr-rt5651-stereo-spk-in12-mic/HiFi.conf
> @@ -1,6 +1,6 @@
>   # Adapted from https://github.com/plbossart/UCM/tree/master/bytcr-rt5651
>   
> -<searchdir:ucm>
> +<searchdir:ucm-includes>
>   
>   SectionVerb {
>   	EnableSequence [
> diff --git a/src/conf/ucm/bytcr-rt5651-stereo-spk-in2-mic/HiFi.conf b/src/conf/ucm/bytcr-rt5651-stereo-spk-in2-mic/HiFi.conf
> index a73ff5f86b8f..1767906ffd99 100644
> --- a/src/conf/ucm/bytcr-rt5651-stereo-spk-in2-mic/HiFi.conf
> +++ b/src/conf/ucm/bytcr-rt5651-stereo-spk-in2-mic/HiFi.conf
> @@ -1,6 +1,6 @@
>   # Adapted from https://github.com/plbossart/UCM/tree/master/bytcr-rt5651
>   
> -<searchdir:ucm>
> +<searchdir:ucm-includes>
>   
>   SectionVerb {
>   	EnableSequence [
> diff --git a/src/conf/ucm/bytcr-rt5651/HiFi.conf b/src/conf/ucm/bytcr-rt5651/HiFi.conf
> index 8733403cf28d..f254eac979cb 100644
> --- a/src/conf/ucm/bytcr-rt5651/HiFi.conf
> +++ b/src/conf/ucm/bytcr-rt5651/HiFi.conf
> @@ -1,6 +1,6 @@
>   # Adapted from https://github.com/plbossart/UCM/tree/master/bytcr-rt5651
>   
> -<searchdir:ucm>
> +<searchdir:ucm-includes>
>   
>   SectionVerb {
>   	EnableSequence [
> diff --git a/src/conf/ucm/chtnau8824/HiFi.conf b/src/conf/ucm/chtnau8824/HiFi.conf
> index dc52800e5eaa..4bff322b33ee 100644
> --- a/src/conf/ucm/chtnau8824/HiFi.conf
> +++ b/src/conf/ucm/chtnau8824/HiFi.conf
> @@ -1,4 +1,4 @@
> -<searchdir:ucm>
> +<searchdir:ucm-includes>
>   
>   SectionVerb {
>   
> diff --git a/src/conf/ucm/cube-i1_TF-Defaultstring-CherryTrailCR/HiFi.conf b/src/conf/ucm/cube-i1_TF-Defaultstring-CherryTrailCR/HiFi.conf
> index 799163dbe481..f9c64ea16bd5 100644
> --- a/src/conf/ucm/cube-i1_TF-Defaultstring-CherryTrailCR/HiFi.conf
> +++ b/src/conf/ucm/cube-i1_TF-Defaultstring-CherryTrailCR/HiFi.conf
> @@ -1,4 +1,4 @@
> -<searchdir:ucm>
> +<searchdir:ucm-includes>
>   
>   SectionVerb {
>   
> 
