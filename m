From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: "modprobe snd_hda_intel" crashes on my hardware
Date: Tue, 27 Sep 2011 15:18:38 +0200
Message-ID: <4E81CD2E.2010009@ladisch.de>
References: <4E817010.7030607@ezono.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 988F1103991
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Sep 2011 15:18:20 +0200 (CEST)
In-Reply-To: <4E817010.7030607@ezono.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Abdelghani Ouchabane <abdelghani@ezono.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This looks like a patch, not like a crash report.

Please check linux/Documentation/SubmittingPatches.

Abdelghani Ouchabane wrote:
> +    /* THis is added because Ezono sound card doesn't support auto detection */

         "This"

_All_ VT1708 chips support autodetection; the registers just have to be
initialized correctly by the BIOS.

> +    /* Port_A PW0 */
> +    snd_hda_codec_write(codec, 0x1c, 0, AC_VERB_SET_CONFIG_DEFAULT_BYTES_0, 0x00);
> +    snd_hda_codec_write(codec, 0x1c, 0, AC_VERB_SET_CONFIG_DEFAULT_BYTES_1, 0xf0);
> +    snd_hda_codec_write(codec, 0x1c, 0, AC_VERB_SET_CONFIG_DEFAULT_BYTES_2, 0x00);
> +    snd_hda_codec_write(codec, 0x1c, 0, AC_VERB_SET_CONFIG_DEFAULT_BYTES_3, 0x00);
> ...

A table of initialization values that gets written in a loop would look
less ugly.

>  static int patch_vt1708(struct hda_codec *codec)
>  {
>  	struct via_spec *spec;
> @@ -902,7 +945,10 @@ static int patch_vt1708(struct hda_codec
>  		return -ENOMEM;
>  
>  	codec->spec = spec;
> -
> +	
> +	/* Init Ezono Sound card */
> +	ezono_vt1708_init(codec);
> +	

Please don't add whitespace to empty lines.

This initialization gets applied to _all_ VT1708 chips; thus it will
break all non-Ezono machines.

The driver has to check whether it is running on this particular model
of an Ezono computer.  The correct way to do this is to check the PCI
IDs:

> 00:1b.0 0403: 8086:27d8
> ...
> Subsystem Id: 0xffffffff

Oh well, somebody forgot to initialize them.  Probably the same BIOS
programmer that forgot to initialize the VT1708 registers.

Another way would be to check the DMI strings.

> Manufacturer:      
> Product Name:      
> Product Version:   

Or not.  Who wrote that BIOS?  Somebody whose brain was damaged by too
much ultrasound?


Anyway, you could just override the pin configs with a HDA patch file.
Ensure that your kernel is compiled with CONFIG_SND_HDA_PATCH_LOADER;
then create a file /lib/firmware/forgotten-ezono-hda-settings with the
following contents:

[codec]
0x11061708 0xffffffff 2
[pincfg]
0x1c 0x0000f000
0x1d 0x00a0f040
0x1f 0x0100f010
0x20 0x0020f000
0x22 0x0000f002
0x23 0x0000f004

Then load the snd-hda-intel driver with the parameter
"patch=forgotten-ezono-hda-settings", either by adding that
parameter to the modprobe command line, or by putting the line

  options snd-hda-intel patch=forgotten-ezono-hda-settings

into a .conf file in /etc/modprobe.d/.


Regards,
Clemens
