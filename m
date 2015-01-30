From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH V2] ASoC: sgtl5000: add delay before first
 I2C access
Date: Fri, 30 Jan 2015 19:31:37 -0200
Message-ID: <CAOMZO5BwM1CEAtFnqxS9xwSy2OamHCuEw=YBT8vf5FNa_4GA7A@mail.gmail.com>
References: <1422651131-13261-1-git-send-email-eric.nelson@boundarydevices.com>
 <1422652075-13604-1-git-send-email-eric.nelson@boundarydevices.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f173.google.com (mail-lb0-f173.google.com
 [209.85.217.173])
 by alsa0.perex.cz (Postfix) with ESMTP id 62023260506
 for <alsa-devel@alsa-project.org>; Fri, 30 Jan 2015 22:31:38 +0100 (CET)
Received: by mail-lb0-f173.google.com with SMTP id p9so38503871lbv.4
 for <alsa-devel@alsa-project.org>; Fri, 30 Jan 2015 13:31:37 -0800 (PST)
In-Reply-To: <1422652075-13604-1-git-send-email-eric.nelson@boundarydevices.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Eric Nelson <eric.nelson@boundarydevices.com>
Cc: Takashi Iwai <tiwai@suse.de>, Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi Eric,

On Fri, Jan 30, 2015 at 7:07 PM, Eric Nelson
<eric.nelson@boundarydevices.com> wrote:
> To quote from section 1.3.1 of the data sheet:
>         The SGTL5000 has an internal reset that is deasserted
>         8 SYS_MCLK cycles after all power rails have been brought
>         up. After this time, communication can start
>
>         ...
>         1.0uS represents 8 SYS_MCLK cycles at the minimum 8.0 MHz SYS_MCLK.

Small detail: Should be us instead of uS.

Reviewed-by: Fabio Estevam <fabio.estevam@freescale.com>
