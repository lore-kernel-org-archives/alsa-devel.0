From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: [PATCH] ASoC: TWL4030: Add input selection
	and	gain controls
Date: Tue, 2 Dec 2008 20:38:01 +0000
Message-ID: <20081202203800.GB6972@sirena.org.uk>
References: <1228243738-9561-1-git-send-email-notasas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 5D7191037EB
	for <alsa-devel@alsa-project.org>; Tue,  2 Dec 2008 21:38:08 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1228243738-9561-1-git-send-email-notasas@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Dec 02, 2008 at 08:48:58PM +0200, Grazvydas Ignotas wrote:

Applied, thanks.

> as it might still be useful for weak sources. "Capture" was
> also changed to "Input", as inputs can be also routed to outputs,
> not only recorded.

This is true, however "Caputure" has special meaning in ALSA control
names - see Documentation/sound/alsa/ControlNames.txt.  I've applied the
patch anyway since the main capture volume is still called that and the
control names normally end up getting a bit lost for ASoC but it may be
worth checking how this is presented in the UIs.

Also, if there are bypass paths then the set_bias_level() function is
probably going to need fixing since it powers the chip down when there's
no active playback/record.  Not an issue for this patch, though.

> @@ -46,9 +46,9 @@ static const u8 twl4030_reg[TWL4030_CACHEREGNUM] = {
>  	0xc3, /* REG_OPTION		(0x2)	*/
>  	0x00, /* REG_UNKNOWN		(0x3)	*/
>  	0x00, /* REG_MICBIAS_CTL	(0x4)	*/
> -	0x24, /* REG_ANAMICL		(0x5)	*/
> -	0x04, /* REG_ANAMICR		(0x6)	*/
> -	0x0a, /* REG_AVADC_CTL		(0x7)	*/
> +	0x20, /* REG_ANAMICL		(0x5)	*/
> +	0x00, /* REG_ANAMICR		(0x6)	*/
> +	0x00, /* REG_AVADC_CTL		(0x7)	*/
>  	0x00, /* REG_ADCMICSEL		(0x8)	*/
>  	0x00, /* REG_DIGMIXING		(0x9)	*/
>  	0x0c, /* REG_ATXL1PGA		(0xA)	*/

Hrm.  This is getting to be quite a common thing.  It might be better to
change the driver to just use whatever state the chip has by default
rather than having a set of defaults hard coded into it (normally the
defaults in the drivers are the power on defaults of the chip).  Also
not a problem for this patch, though.

> +static int twl4030_put_left_input(struct snd_kcontrol *kcontrol,
> +	struct snd_ctl_elem_value *ucontrol)

...

> +	switch (value) {

...

> +	default:
> +		break;

I'd expect to see an error being flagged if this is out of bounds.  Not
that the core does that for its puts and anyway there should be
validation further up the stack.
