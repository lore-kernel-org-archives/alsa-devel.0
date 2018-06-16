From: Connor McAdams <conmanx360@gmail.com>
Subject: Re: [PATCH 4/6] ALSA: hda/ca0132: Don't test for
	QUIRK_NONE
Date: Fri, 15 Jun 2018 22:20:18 -0400
Message-ID: <CAM8Agx12RSbcd1-N0cQ96GtznbmmFWH=FCJCCaHyvynhX8_d5A@mail.gmail.com>
References: <20180616015620.26663-1-alastair.bridgewater@gmail.com>
 <20180616015620.26663-5-alastair.bridgewater@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180616015620.26663-5-alastair.bridgewater@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alastair Bridgewater <alastair.bridgewater@gmail.com>
Cc: alsa-devel@alsa-project.org, patch@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Good call. Please understand that I'm fairly new to all of this, so
mistakes like this are more due to being ignorant than anything else.
I was afraid certain things may end up broken by my changes, and I
hope it didn't inconvenience you.

On Fri, Jun 15, 2018 at 9:56 PM, Alastair Bridgewater
<alastair.bridgewater@gmail.com> wrote:
> QUIRK_NONE is, quite explicitly, the default case.  The entire
> point of a quirks system is to allow "programming by difference"
> from a given base case, which requires that merely defining a new
> quirk for some piece of hardware should not change the behavior of
> the driver for that hardware.  In turn, this means that testing
> for QUIRK_NONE explicitly is a violation of that implicit contract.
>
> Change a test for QUIRK_NONE and QUIRK_ALIENWARE to default, and
> add a test for QUIRK_SBZ to disable the default behavior in that
> instance.
>
> Signed-off-by: Alastair Bridgewater <alastair.bridgewater@gmail.com>
>
> diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
> index ca7375e48138..71487b82eef5 100644
> --- a/sound/pci/hda/patch_ca0132.c
> +++ b/sound/pci/hda/patch_ca0132.c
> @@ -7237,8 +7237,9 @@ static int ca0132_init(struct hda_codec *codec)
>         case QUIRK_R3DI:
>                 r3di_setup_defaults(codec);
>                 break;
> -       case QUIRK_NONE:
> -       case QUIRK_ALIENWARE:
> +       case QUIRK_SBZ:
> +               break;
> +       default:
>                 ca0132_setup_defaults(codec);
>                 ca0132_init_analog_mic2(codec);
>                 ca0132_init_dmic(codec);
> --
> 2.16.1
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
