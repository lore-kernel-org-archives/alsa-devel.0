From: Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
Subject: [PATCH v2 0/6] DT: Fix spelling of standard properties
Date: Fri, 21 Oct 2016 10:51:11 +0200
Message-ID: <1477039877-20227-1-git-send-email-geert+renesas@glider.be>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Patrice Chotard <patrice.chotard-qxv4g6HH51o@public.gmane.org>, Chanho Min <chanho.min-Hm3cg6mZ9cc@public.gmane.org>, Michael Ellerman <mpe-Gsx/Oe8HsFggBc27wqDAHg@public.gmane.org>
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, kernel-F5mvAk5X5gdBDgjK7y7TUQ@public.gmane.org, linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Geert Uytterhoeven <geert+renesas-gXvu3+zWzMSzQB+pC5nmwQ@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

	Hi all,

This patch series fixes misspellings of various standard DT properties
in DT binding documentation, DTS files, and error messages.
While most of these are harmless, some of them may cause hard-to-debug
failures.

Changes compared to v2:
  - Dropped patches that have been applied already,
  - Add Rob Herring's Acked-by,
  - Split off "[PATCH v2 4/6] ASoC: davinci-mcbsp: DT fix
    s/interrupts-names/interrupt-names/" from the unrelated "[PATCH 06/14]
    dmaengine: bcm2835: DT spelling s/interrupts-names/interrupt-names/",
  - Add new patch "[PATCH v2 3/6] arm64: dts: lg1313: DT fix
    s/#interrupts-cells/#interrupt-cells/".

Please apply where appropriate.

Thanks!

P.S. I used the following to detect misspellings:

    words="(address|clock|cooling|dma|gpio|index|interrupt|mbox|msi|nvmem|phy|phys|power-domain|pwm|reset|size|sleep|sound-dai|thermal-sensor)"

    git grep -Ew "${words}s-names"
    git grep -E "[^-]\<${words}-name\>[^-]"
    git grep -Ew "#${words}s-cells"             # false positive phys-cells
    git grep -E "#${words}-cell\>[^-]"

    git grep -w adress-cells
    git grep -Ew "interrupts-(map|parent)"

Geert Uytterhoeven (6):
  ARM: dts: STiH407: DT fix s/interrupts-names/interrupt-names/
  arm64: dts: lg1312: DT fix s/#interrupts-cells/#interrupt-cells/
  arm64: dts: lg1313: DT fix s/#interrupts-cells/#interrupt-cells/
  ASoC: davinci-mcbsp: DT fix s/interrupts-names/interrupt-names/
  dt: booting-without-of: DT fix s/#interrupt-cell/#interrupt-cells/
  powerpc: dts: acadia: DT fix s/#interrupts-parent/#interrupt-parent/

 Documentation/devicetree/bindings/sound/davinci-mcbsp.txt | 2 +-
 Documentation/devicetree/booting-without-of.txt           | 2 +-
 arch/arm/boot/dts/stih407-pinctrl.dtsi                    | 2 +-
 arch/arm64/boot/dts/lg/lg1312.dtsi                        | 2 +-
 arch/arm64/boot/dts/lg/lg1313.dtsi                        | 2 +-
 arch/powerpc/boot/dts/acadia.dts                          | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

-- 
1.9.1

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
