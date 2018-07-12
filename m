From: Connor McAdams <conmanx360@gmail.com>
Subject: Re: [PATCH 1/2] ALSA: hda/ca0132: Add Recon3Di quirk
 for Gigabyte G1.Sniper Z97
Date: Wed, 11 Jul 2018 20:08:46 -0400
Message-ID: <CAM8Agx1v=vBBM7jGZF+qx7h402SbDbpJZL5pmGwzz2T=M66THg@mail.gmail.com>
References: <20180711220946.20368-1-alastair.bridgewater@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20180711220946.20368-1-alastair.bridgewater@gmail.com>
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

Reviewed-by: Connor McAdams <conmanx360@gmail.com>

On Wed, Jul 11, 2018 at 6:09 PM, Alastair Bridgewater
<alastair.bridgewater@gmail.com> wrote:
> These motherboards have Sound Core3D and apparently "support"
> Recon3Di.  Added to the quirk list as QUIRK_R3DI.
>
> Issue report, PCI Subsystem ID, and testing by a contributor on
> IRC who wished to remain anonymous.
>
> Signed-off-by: Alastair Bridgewater <alastair.bridgewater@gmail.com>
>
> diff --git a/sound/pci/hda/patch_ca0132.c b/sound/pci/hda/patch_ca0132.c
> index d62c56feaf7d..c803cca1c236 100644
> --- a/sound/pci/hda/patch_ca0132.c
> +++ b/sound/pci/hda/patch_ca0132.c
> @@ -1048,6 +1048,7 @@ static const struct snd_pci_quirk ca0132_quirks[] = {
>         SND_PCI_QUIRK(0x1102, 0x0010, "Sound Blaster Z", QUIRK_SBZ),
>         SND_PCI_QUIRK(0x1102, 0x0023, "Sound Blaster Z", QUIRK_SBZ),
>         SND_PCI_QUIRK(0x1458, 0xA016, "Recon3Di", QUIRK_R3DI),
> +       SND_PCI_QUIRK(0x1458, 0xA026, "Gigabyte G1.Sniper Z97", QUIRK_R3DI),
>         SND_PCI_QUIRK(0x1458, 0xA036, "Recon3Di", QUIRK_R3DI),
>         {}
>  };
> --
> 2.16.1
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
