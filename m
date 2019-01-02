From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH 1/1] conf/ucm: chtrt5650: Add UCM config
 for chtrt5650
Date: Wed, 2 Jan 2019 10:14:06 -0600
Message-ID: <1f9d849d-db6f-ae8b-5551-efdb1b13bdea@linux.intel.com>
References: <20181230053526.14989-1-russell.parker7@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20181230053526.14989-1-russell.parker7@gmail.com>
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
To: Russell Parker <russell.parker7@gmail.com>, patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, evananderson@thelinuxman.us
List-Id: alsa-devel@alsa-project.org


On 12/29/18 11:35 PM, Russell Parker wrote:
> Add a UCM configuration for the rt5650 codec. Tested on
> a Samsung Chromebook 3. Adapted with minor modifications
> from GitHub user evan-a-a's gist:
> https://gist.github.com/evan-a-a/86b2a698708074530e2d0ee7c6498767
>
> Signed-off-by: Russell Parker <russell.parker7@gmail.com>

Interesting, thanks!

IIRC rt5650 is a low-cost version of rt5645, the machine driver only has 
a minor difference in the routing map and the controls are largely 
identical. Could we maybe factor the common codec parts with the include 
mechanism, similar to what was done for the SOC/platform driver settings?


>
> diff --git a/configure.ac b/configure.ac
> index d0cab2d6..d524ff4b 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -737,6 +737,7 @@ AC_OUTPUT(Makefile doc/Makefile doc/pictures/Makefile doc/doxygen.cfg \
>   	  src/conf/ucm/chtnau8824/Makefile \
>   	  src/conf/ucm/chtrt5645/Makefile \
>   	  src/conf/ucm/chtrt5645-mono-speaker-analog-mic/Makefile \
> +	  src/conf/ucm/chtrt5650/Makefile \
>   	  src/conf/ucm/cube-i1_TF-Defaultstring-CherryTrailCR/Makefile \
>   	  src/conf/ucm/DAISY-I2S/Makefile \
>   	  src/conf/ucm/DB410c/Makefile \
> diff --git a/src/conf/ucm/Makefile.am b/src/conf/ucm/Makefile.am
> index 85c15090..985c460c 100644
> --- a/src/conf/ucm/Makefile.am
> +++ b/src/conf/ucm/Makefile.am
> @@ -21,6 +21,7 @@ bytcr-rt5651-stereo-spk-in12-mic \
>   chtnau8824 \
>   chtrt5645 \
>   chtrt5645-mono-speaker-analog-mic \
> +chtrt5650 \
>   cube-i1_TF-Defaultstring-CherryTrailCR \
>   DAISY-I2S \
>   DB410c \
> diff --git a/src/conf/ucm/chtrt5650/HiFi.conf b/src/conf/ucm/chtrt5650/HiFi.conf
> new file mode 100644
> index 00000000..cc3d64bf
> --- /dev/null
> +++ b/src/conf/ucm/chtrt5650/HiFi.conf
> @@ -0,0 +1,203 @@
> +
> +SectionVerb {
> +	# ALSA PCM
> +	Value {
> +		TQ "HiFi"
> +
> +		# ALSA PCM device for HiFi
> +		PlaybackPCM "hw:chtrt5650"
> +		CapturePCM "hw:chtrt5650"
> +	}
> +
> +	EnableSequence [
> +		cdev "hw:chtrt5650"
> +
> +		<platforms/bytcr/PlatformEnableSeq.conf>
> +
> +		# Output Configuration
> +		cset "name='DAC1 L Mux' IF1 DAC"
> +		cset "name='DAC1 R Mux' IF1 DAC"
> +		cset "name='DAC1 MIXL DAC1 Switch' 1"
> +		cset "name='DAC1 MIXR DAC1 Switch' 1"
> +		cset "name='Stereo DAC MIXL DAC L1 Switch' 1"
> +		cset "name='Stereo DAC MIXR DAC R1 Switch' 1"
> +		cset "name='Speaker HWEQ' 1,164,237,135,1,165,0,0,1,166,237,135,1,167,0,0,1,192,30,196,1,193,0,0,1,194,30,196,1,195,0,0,1,196,31,180,1,197,0,75,1,198,31,180,1,199,31,180,1,200,0,75,1,201,31,180,0,177,51,224"
> +		cset "name='DAC1 Playback Volume' 77,77"
> +
> +		cset "name='Speaker ClassD Playback Volume' 4"
> +
> +		cset "name='DAC L2 Mux' IF2 DAC"
> +		cset "name='DAC R2 Mux' IF2 DAC"
> +		cset "name='Mono DAC MIXL DAC L2 Switch' on"
> +		cset "name='Mono DAC MIXR DAC R2 Switch' on"
> +		cset "name='DAC2 Playback Switch' on"
> +
> +		cset "name='HPOVOL MIXL DAC1 Switch' on"
> +		cset "name='HPOVOL MIXR DAC1 Switch' on"
> +		cset "name='HPOVOL MIXL DAC2 Switch' on"
> +		cset "name='HPOVOL MIXR DAC2 Switch' on"
> +		cset "name='HPO MIX HPVOL Switch' on"
> +		cset "name='HPOVOL L Switch' on"
> +		cset "name='HPOVOL R Switch' on"
> +
> +		cset "name='SPK MIXL DAC L1 Switch' on"
> +		cset "name='SPK MIXR DAC R1 Switch' on"
> +		cset "name='SPK MIXL DAC L2 Switch' on"
> +		cset "name='SPK MIXR DAC R2 Switch' on"
> +		cset "name='SPOL MIX SPKVOL L Switch' on"
> +		cset "name='SPOR MIX SPKVOL R Switch' on"
> +		cset "name='SPKVOL L Switch' on"
> +		cset "name='SPKVOL R Switch' on"
> +
> +		# Input Configuration
> +		cset "name='Stereo1 DMIC Mux' 0"
> +		cset "name='Stereo1 ADC2 Mux' 1"
> +		cset "name='ADC Capture Switch' on"
> +		cset "name='ADC Capture Volume' 74"
> +		cset "name='ADC Boost Capture Volume' 3"
> +		cset "name='Mono ADC Capture Volume' 74"
> +		cset "name='Mono ADC Boost Capture Volume' 2"
> +		cset "name='IN Capture Volume' 63"
> +		cset "name='RT5650 IF1 ADC Mux' 0"
> +		cset "name='I2S2 Func Switch' off"
> +	]
> +
> +	DisableSequence [
> +		cdev "hw:chtrt5650"
> +
> +		# Disable audio output path
> +		cset "name='codec_out1 mix 0 pcm0_in Switch' off"
> +		cset "name='media0_out mix 0 media1_in Switch' off"
> +
> +		cset "name='media1_in Gain 0 Switch' off"
> +		cset "name='pcm0_in Gain 0 Switch' off"
> +		cset "name='codec_out1 Gain 0 Switch' off"
> +
> +		# Disable audio input path
> +		cset "name='pcm1_out mix 0 media_loop2_in Switch' off"
> +		cset "name='media_loop2_out mix 0 codec_in0 Switch' off"
> +
> +		cset "name='media_loop2_out Gain 0 Switch' off"
> +		cset "name='pcm1_out Gain 0 Switch' off"
> +		cset "name='codec_in0 Gain 0 Switch' off"
> +	]
> +}
> +
> +SectionDevice."Speaker" {
> +	Comment "Speaker"
> +
> +	Value {
> +		PlaybackChannels "2"
> +	}
> +
> +	ConflictingDevice [
> +		"Headphones"
> +	]
> +
> +	EnableSequence [
> +		cdev "hw:chtrt5650"
> +
> +		cset "name='Headphone Switch' off"
> +		cset "name='Headphone Channel Switch' off"
> +
> +		cset "name='Ext Spk Switch' on"
> +		cset "name='Speaker Channel Switch' on"
> +		cset "name='Speaker Playback Volume' 31"
> +	]
> +
> +	DisableSequence [
> +		cdev "hw:chtrt5650"
> +
> +		cset "name='Ext Spk Switch' off"
> +		cset "name='Speaker Channel Switch' off"
> +	]
> +}
> +
> +SectionDevice."Headphones" {
> +	Comment "Headphones"
> +
> +	Value {
> +		PlaybackChannels "2"
> +		JackControl "Headphone Jack"
> +		JackHWMute "Speaker"
> +	}
> +
> +	ConflictingDevice [
> +		"Speaker"
> +	]
> +
> +	EnableSequence [
> +		cdev "hw:chtrt5650"
> +
> +		cset "name='Ext Spk Switch' off"
> +		cset "name='Speaker Channel Switch' off"
> +
> +		cset "name='Headphone Switch' on"
> +		cset "name='Headphone Channel Switch' on"
> +		cset "name='Headphone Playback Volume' 31"
> +	]
> +
> +	DisableSequence [
> +		cdev "hw:chtrt5650"
> +
> +		cset "name='Headphone Switch' off"
> +		cset "name='Headphone Channel Switch' off"
> +	]
> +}
> +
> +SectionDevice."Mic".0 {
> +	Comment "Internal Microphone"
> +
> +	Value {
> +		CaptureChannels "2"
> +		CapturePriority "150"
> +	}
> +
> +	EnableSequence [
> +		cdev "hw:chtrt5650"
> +
> +		cset "name='Int Mic Switch' on"
> +		cset "name='Sto1 ADC MIXL ADC2 Switch' on"
> +		cset "name='Sto1 ADC MIXR ADC2 Switch' on"
> +	]
> +
> +	DisableSequence [
> +		cdev "hw:chtrt5650"
> +
> +		cset "name='Sto1 ADC MIXL ADC2 Switch' off"
> +		cset "name='Sto1 ADC MIXR ADC2 Switch' off"
> +		cset "name='Int Mic Switch' off"
> +	]
> +}
> +
> +SectionDevice."HSMic".0 {
> +	Comment "Headset Microphone"
> +
> +	Value {
> +		CaptureChannels "2"
> +		JackControl "Headset Mic Jack"
> +		JackHWMute "Mic"
> +	}
> +
> +	EnableSequence [
> +		cdev "hw:chtrt5650"
> +
> +		cset "name='Headset Mic Switch' on"
> +		cset "name='RECMIXL BST1 Switch' on"
> +		cset "name='RECMIXR BST1 Switch' on"
> +		cset "name='Sto1 ADC MIXL ADC1 Switch' on"
> +		cset "name='Sto1 ADC MIXR ADC1 Switch' on"
> +		cset "name='IN1 Boost' 1"
> +	]
> +
> +	DisableSequence [
> +		cdev "hw:chtrt5650"
> +
> +		cset "name='Headset Mic Switch' off"
> +		cset "name='RECMIXL BST1 Switch' off"
> +		cset "name='RECMIXR BST1 Switch' off"
> +		cset "name='Sto1 ADC MIXL ADC1 Switch' off"
> +		cset "name='Sto1 ADC MIXR ADC1 Switch' off"
> +		cset "name='IN1 Boost' 0"
> +	]
> +}
> diff --git a/src/conf/ucm/chtrt5650/Makefile.am b/src/conf/ucm/chtrt5650/Makefile.am
> new file mode 100644
> index 00000000..f506cd77
> --- /dev/null
> +++ b/src/conf/ucm/chtrt5650/Makefile.am
> @@ -0,0 +1,4 @@
> +alsaconfigdir = @ALSA_CONFIG_DIR@
> +ucmdir = $(alsaconfigdir)/ucm/chtrt5650
> +ucm_DATA = chtrt5650.conf HiFi.conf
> +EXTRA_DIST = $(ucm_DATA)
> diff --git a/src/conf/ucm/chtrt5650/chtrt5650.conf b/src/conf/ucm/chtrt5650/chtrt5650.conf
> new file mode 100644
> index 00000000..dfc36c89
> --- /dev/null
> +++ b/src/conf/ucm/chtrt5650/chtrt5650.conf
> @@ -0,0 +1,5 @@
> +Comment "Intel SoC Audio Device"
> +SectionUseCase."HiFi" {
> +	File "HiFi.conf"
> +	Comment "Default"
> +}
