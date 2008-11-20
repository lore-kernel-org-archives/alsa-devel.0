From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: twl4030 asoc kcontrols and widgets
Date: Thu, 20 Nov 2008 10:52:06 +0000
Message-ID: <20081120105205.GA4539@sirena.org.uk>
References: <ef0d8a250811200138y36fc840dn9978dd862214dec4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id E75F724415
	for <alsa-devel@alsa-project.org>; Thu, 20 Nov 2008 11:52:07 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <ef0d8a250811200138y36fc840dn9978dd862214dec4@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: naveen krishna ch <naveenkrishna.ch@gmail.com>
Cc: alsa-devel@alsa-project.org, Steve Sakoman <steve@sakoman.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 20, 2008 at 03:08:33PM +0530, naveen krishna ch wrote:
> I have been working on TWL4030 codec driver for ALSA SOC.
> I have taken sound/soc/codec/twl4030.c as reference from main line

CCing Steve Sakoman who wrote the driver.

> This Patch adds some kcontrols, widgets and interconnection map for some of
> the TWL4030 ASOC codec

It's doing a bit more than that...  This should be split up into several 
patches, each making a single logical change: for example, the change to
the register defaults could be split out since they are (presumably)
something that applies in general.  Splitting things up like this makes
it easier to review your patches since it makes the purpose of each
individual code change much clearer and easier to verify.

Please see Documentation/SubmittingPatches for details on how to format
patches for submission.

> Suggestions on the DAPM part of the driver would be helpful

Aside from the control name and formatting issues identified below it
looks mostly reasonable, though I've not looked at how well it
corresponds to the codec at all.  My main concern is that the driver has
non-DAPM power management provided by twl4030_power_up() and friends -
how does your driver interact with this?  I would expect to see
something dealing with that, for pops and clicks if nothing else.

Some more specific comments:

> --- twl4030.c    2008-11-19 12:04:32.000000000 +0530
> +++ /home/chnaveen/Desktop/twl4030.c    2008-11-21 15:08:06.000000000 +0530
> @@ -16,7 +16,9 @@
>   * along with this program; if not, write to the Free Software
>   * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA
>   * 02110-1301 USA
> - *
> + * Modified by  : Naveen Krishna Ch
> + * Added Kcontrols for OMAP3 WaterlooBoard
> + * Dated    : 28th october 2008
>   */

Don't add in-code changelogs, git keeps track of the history of files.

>  /*
>   * twl4030 register cache & default register settings
>   */
>  static const u8 twl4030_reg[TWL4030_CACHEREGNUM] = {
>      0x00, /* this register not used        */
> -    0x93, /* REG_CODEC_MODE        (0x1)    */
> +    0x03, /* REG_CODEC_MODE        (0x1)    */
>      0xc3, /* REG_OPTION        (0x2)    */

...

> -    0x00, /* REG_ANAMIC_GAIN    (0x48)    */
> +    0x24, /* REG_ANAMIC_GAIN    (0x48)    */
>      0x00, /* REG_MISC_SET_2        (0x49)    */

This whole hunk should be splittable out from the rest of the code.  I'd
also like to see some discussion about what's being changed and why - is
it just that the register defaults are incorrect?

>  };
> +static void twl4030_ext_control(struct snd_soc_codec *codec)
> +{

There should be a blank line between the register defaults and the start
of the function - this is a problem in several parts of your patch.

> +        if (twl4030_jack_func)
> +                snd_soc_dapm_enable_pin(codec, "Headphone Jack");
> +        else
> +                snd_soc_dapm_disable_pin(codec, "Headphone Jack");
> +
> +            snd_soc_dapm_sync(codec);
> +}

The jack handling code you have added should not be part of the TWL4030
driver, it should be part of the machine driver for the board.  Any
jacks will depend on the particular board - some boards may not wire up
the headphone output at all.

>  static const struct snd_kcontrol_new twl4030_snd_controls[] = {
> -    SOC_DOUBLE_R("Master Playback Volume",
> -         TWL4030_REG_ARXL2PGA, TWL4030_REG_ARXR2PGA,
> -        0, 127, 0),
> -    SOC_DOUBLE_R("Capture Volume",
> -         TWL4030_REG_ATXL1PGA, TWL4030_REG_ATXR1PGA,
> -        0, 127, 0),
> +
> +    /* Master Playback Volume Controls */
> +    SOC_DOUBLE_R("Master PLayback Course Gain ctrl",
> +                TWL4030_REG_ARXL2PGA, TWL4030_REG_ARXR2PGA,
> +                6, 3, 0),
> +    SOC_DOUBLE_R("Master Playback Fine Gain ctrl",
> +                TWL4030_REG_ARXL2PGA, TWL4030_REG_ARXR2PGA,
> +                0, 63, 0),

These and your other control names should conform to the ALSA control
names standard - see Documentation/sound/alsa/ControlNames.txt.  For
gain controls the last word should be Volume.

> +    /* Loop gain controls*/
> +        SOC_DOUBLE("Loop Gain ctrl", TWL4030_REG_ATX2ARXPGA,
> +                3 , 0, 7, 0),
> +
> +        SOC_DOUBLE("Main +Sub mic capture gain ctrl",
> +                TWL4030_REG_ANAMIC_GAIN, 3 , 0, 5, 0),
> +
> +        SOC_DOUBLE_R("External Speaker Volume control",
> +                TWL4030_REG_PREDL_CTL, TWL4030_REG_PREDR_CTL,
> +                4, 3, 0),
> +
> +    SOC_DOUBLE_R("Pre Car kit Volume control",
> +                TWL4030_REG_PRECKL_CTL, TWL4030_REG_PRECKR_CTL,
> +                4, 3, 0),

Your indentation appears to be done rather inconsistently.

> +/* Right PGA Mixer control switches */
> +static const struct snd_kcontrol_new twl4030_right_pga_mixer_controls[] = {
> +        SOC_DAPM_SINGLE("HS Mic switch", TWL4030_REG_ANAMICL, 1, 1, 0),
> +        SOC_DAPM_SINGLE("Aux/FM right switch", TWL4030_REG_ANAMICR, 2, 1,
> 0),
> +        SOC_DAPM_SINGLE("Sub Mic switch", TWL4030_REG_ANAMICR, 0, 1, 0),
> +};

Should be "Switch" not "switch".

>  static const struct snd_soc_dapm_widget twl4030_dapm_widgets[] = {
> -    SND_SOC_DAPM_INPUT("INL"),
> -    SND_SOC_DAPM_INPUT("INR"),
> -
> -    SND_SOC_DAPM_OUTPUT("OUTL"),
> -    SND_SOC_DAPM_OUTPUT("OUTR"),

Why have these been changed?

> +    /* Right ADC for capture*/
> +        SND_SOC_DAPM_ADC("ADCR", "Right Capture ADC",
> TWL4030_REG_AVADC_CTL, 1, 0),

It looks like your MUA has word wrapped your patch here.  This will make
it impossible to apply.  You might find it's easier to use something
like git-send-email to send the patches if you can't see how to turn off
word wrapping in your MUA.

> +        SND_SOC_DAPM_INPUT("HSMIC"),
> +        SND_SOC_DAPM_INPUT("Aux/fm left"),
> +        SND_SOC_DAPM_INPUT("Main mic"),

The normal thing here is to use the pin names specified in the datasheet
rather than plain text descriptions - this avoids any confusion when
people are connecting these up in machine drivers.

> +        /* ******** Right Output ******** */
> +        //{"DACR2", NULL, "DACR2 Mixer"},

Remove code rather than leaving it commented out.

> @@ -280,7 +454,7 @@
>      /* toggle CODECPDZ as per TRM */
>      twl4030_clear_codecpdz(codec);
>      twl4030_set_codecpdz(codec);
> -
> +
>      /* program anti-pop with bias ramp delay */
>      popn = twl4030_read_reg_cache(codec, TWL4030_REG_HS_POPN_SET);
>      popn &= TWL4030_RAMP_DELAY;

Random indentation change here - you've got a few of those, please
remove them.

> @@ -384,6 +558,9 @@
>      case 48000:
>          mode |= TWL4030_APLL_RATE_48000;
>          break;
> +    case 96000:
> +        mode |= TWL4030_APLL_RATE_96000;
> +        break;

This should be split out into a separate patch.

> @@ -504,20 +682,24 @@
>      return 0;
>  }
> 
> -#define TWL4030_RATES     (SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000)
> +#define TWL4030_RATES (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_11025 |     \
> +                       SNDRV_PCM_RATE_16000 | SNDRV_PCM_RATE_22050 |    \
> +                       SNDRV_PCM_RATE_32000 | SNDRV_PCM_RATE_44100 |    \
> +                       SNDRV_PCM_RATE_48000 | SNDRV_PCM_RATE_96000)
> +

This definitely won't apply to the current driver.  Also I suspect you
just want SNDRV_PCM_RATE_8000_96000 here.
