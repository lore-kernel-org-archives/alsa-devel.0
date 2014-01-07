From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ASoC: fsl_ssi: Fixed wrong printf format
	identifier
Date: Tue, 7 Jan 2014 08:08:14 -0200
Message-ID: <CAOMZO5AK3=d322K80a6Y16xWKFYy9dWJEupF6W8mqLxm0_=j8g@mail.gmail.com>
References: <1389074690-21654-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vb0-f49.google.com (mail-vb0-f49.google.com
 [209.85.212.49])
 by alsa0.perex.cz (Postfix) with ESMTP id BCFE626170F
 for <alsa-devel@alsa-project.org>; Tue,  7 Jan 2014 11:08:15 +0100 (CET)
Received: by mail-vb0-f49.google.com with SMTP id x11so9361031vbb.8
 for <alsa-devel@alsa-project.org>; Tue, 07 Jan 2014 02:08:15 -0800 (PST)
In-Reply-To: <1389074690-21654-1-git-send-email-shc_work@mail.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, Mark Brown <broonie@kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 7, 2014 at 4:04 AM, Alexander Shiyan <shc_work@mail.ru> wrote:
> sound/soc/fsl/fsl_ssi.c: In function 'fsl_ssi_probe':
> sound/soc/fsl/fsl_ssi.c:1180:6: warning: format '%d' expects argument
> of type 'int', but argument 3 has type 'long int' [-Wformat=]
>
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Signed-off-by: Alexander Shiyan <shc_work@mail.ru>

I have sent the same fix as well as I haven't seen your patch before I
submitted mine.

It is usually a good idea to specify in the commit log what was the
commit that caused the warning.

Regards,

Fabio Estevam
