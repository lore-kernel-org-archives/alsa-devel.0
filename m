From: Sean Cross <xobs-nXMMniAx+RbQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 1/3] sound: soc: codecs: Add es8328 codec
Date: Mon, 10 Feb 2014 17:24:47 +0800
Message-ID: <52F89ADF.8020305@kosagi.com>
References: <1391749517-11787-1-git-send-email-xobs@kosagi.com> <1391749517-11787-2-git-send-email-xobs@kosagi.com> <20140207181238.GL1757@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140207181238.GL1757-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On 8/2/14 2:12 AM, Mark Brown wrote:
> On Fri, Feb 07, 2014 at 01:05:15PM +0800, Sean Cross wrote:
> 
> Please use subject likes matching the style for the subsystem.  If your
> changelog looks different to others in the same area it probably needs
> an update.
> 
> In general this looks like it should be making much more use of the
> framework rather than open coding, it looks like it's very much hard
> coded for one use cae.

I've tried to simplify the code somewhat, but I'm still unclear about
how much of the DAPM code functions.  I'm running into two problems:
Mapping the codec names "OUT1" and "OUT2" onto "Speaker" and "Headphone"
respectively, and accommodating this codec's one DAC / two outputs
architecture.

First, this particular codec doesn't specify what the outputs are used
for, it only specifies the names OUT1 and OUT2.  It is permitted to
connect either a speaker or headphones to either output.  In the initial
patch, I hardcoded OUT1 to be named "Speaker", and OUT2 to "Headphone".
 However, I've genericised the codec and changed them back to "OUT1" and
"OUT2".  Inthe board definition I've added DAPM routes that map
"Speaker" and "Headphone" back onto these names.  amixer still shows
OUT1 and OUT2.

There seems to be some overlap between DAPM and kcontrols.  How can I
specify in the board definition file that OUT1 should have a kcontrol
named "Speaker" and OUT2 should be named "Headphone"?  Tracing shows
that DAPM at least recognizes the naming: e.g. "snd_soc_dapm_input_path:
*Speaker <- (direct) <- ROUT1"

Second, I'm having trouble getting the DAPM routing to function
properly.  There is one DAC that routes to two outputs, OUT1 and OUT2.
Both OUT1 and OUT2 have their own volume controls as well, but the main
state machine and amplification comes from the DAC.  This doesn't seem
to be very common.  Are there any codecs I can use as an example that
have one DAC routing to two outputs?


Sean
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
