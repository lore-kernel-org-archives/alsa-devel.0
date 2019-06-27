From: nick83ola <nick83ola@gmail.com>
Subject: [BUG] Line6 Helix / X Stomp:
 parse_audio_format_rates_v2v3(): unable to retrieve number of sample rates
 (clock 16)
Date: Thu, 27 Jun 2019 08:45:27 +0100
Message-ID: <CABPh3UNCZhssHLmZF2paU4EKOK1WKScbC7Vw=uGfJn7WUeXO3Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com
 [IPv6:2a00:1450:4864:20::12b])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id A0069F80C0B
 for <alsa-devel@alsa-project.org>; Thu, 27 Jun 2019 09:45:40 +0200 (CEST)
Received: by mail-lf1-x12b.google.com with SMTP id 136so873695lfa.8
 for <alsa-devel@alsa-project.org>; Thu, 27 Jun 2019 00:45:40 -0700 (PDT)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
Cc: info@jensverwiebe.de
List-Id: alsa-devel@alsa-project.org

Hi all,
I just purchased an HX stomp and when I connect to linux I get the
following error message:

    [  322.404503] usb 1-6: new high-speed USB device number 13 using xhci_hcd
    [  322.531804] usb 1-6: New USB device found, idVendor=0e41,
idProduct=4246, bcdDevice= 2.00
    [  322.531806] usb 1-6: New USB device strings: Mfr=1, Product=3,
SerialNumber=2
    [  322.531806] usb 1-6: Product: HX Stomp
    [  322.531807] usb 1-6: Manufacturer: LINE 6
    [  322.531808] usb 1-6: SerialNumber:    3021888
    [  322.535789] usb 1-6: parse_audio_format_rates_v2v3(): unable to
retrieve number of sample rates (clock 16)
    [  322.535907] usb 1-6: parse_audio_format_rates_v2v3(): unable to
retrieve number of sample rates (clock 16)

I have some kernel development experience but not a lot with usb so
can someone point me where to start looking?

there was a previous discussion on the mailing list related to this by
Jens Verwiebe (and other request for help).
Here are the relevant patches/discussion

    https://www.spinics.net/lists/alsa-devel/msg71459.html
    https://patchwork.kernel.org/patch/10113121/

If someone can help me I have an HX stomp here and time to do some debugging.

Also if someone from Line6 is listening would be helpful to have some hints.

Cheers
Nicola Lunghi
