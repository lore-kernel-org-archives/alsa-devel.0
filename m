From: Anatol Pomozov <anatol.pomozov@gmail.com>
Subject: Re: [PATCH] ASoC: nau8825: Add driver for headset chip
	Nuvoton 8825
Date: Fri, 2 Oct 2015 09:55:11 -0700
Message-ID: <CAOMFOmWBnJ03yhVO9X1jTiSimMtHdHCt3Y6zrrbRpibYoiXLnw@mail.gmail.com>
References: <1443804554-36592-1-git-send-email-anatol.pomozov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vk0-f46.google.com (mail-vk0-f46.google.com
 [209.85.213.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 8740F260668
 for <alsa-devel@alsa-project.org>; Fri,  2 Oct 2015 18:55:13 +0200 (CEST)
Received: by vkat63 with SMTP id t63so63386159vka.1
 for <alsa-devel@alsa-project.org>; Fri, 02 Oct 2015 09:55:12 -0700 (PDT)
In-Reply-To: <1443804554-36592-1-git-send-email-anatol.pomozov@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: mfelton1@nuvoton.com, Mark Brown <broonie@kernel.org>, Chih-Chiang Chang <ccchang12@nuvoton.com>, Anatol Pomozov <anatol.pomozov@gmail.com>, Ben Zhang <benzh@google.com>
List-Id: alsa-devel@alsa-project.org

Hi

Changes from previous revision:
 - nau8825 uses clk API to enable/disabale MCLK
 - added sar_compare_time/sar_sampling_time DTS options for SAR configuration
 - added control for crosstalk volume configuration
 - it is possible to provide nau8825 structure via platform data (in
case if the driver not used with DTS/ACPI)
 - added 10ms delay for Charge Pump initialization. It reduced pops at
stream startup.
