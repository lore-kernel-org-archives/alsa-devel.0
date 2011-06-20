From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [PATCH] ASoC: codecs: Max98095: Fix logging of
 hardware revision.
Date: Mon, 20 Jun 2011 21:06:29 +0100
Message-ID: <1308600389.2429.1.camel@CNA0741383>
References: <1308596072-17158-1-git-send-email-thutt@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 16C9E103818
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Jun 2011 22:06:44 +0200 (CEST)
Received: by wwf26 with SMTP id 26so3791780wwf.20
	for <alsa-devel@alsa-project.org>; Mon, 20 Jun 2011 13:06:43 -0700 (PDT)
In-Reply-To: <1308596072-17158-1-git-send-email-thutt@chromium.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Taylor Hutt <thutt@chromium.org>
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Peter Hsiang <Peter.Hsiang@maxim-ic.com>, Olof Johansson <olofj@chromium.org>
List-Id: alsa-devel@alsa-project.org

On Mon, 2011-06-20 at 11:54 -0700, Taylor Hutt wrote:
> The base hardware revision of the Maxim 98095 part is 0x40; the code
> which outputs the revision of the hardware has been updated to
> properly use uppercase alphabetic values for the revision numbers.
> 
> Also, the use of a constant for the length 'max98095_dai' has been
> replaced with ARRAY_SIZE().
> 
> Signed-off-by: Taylor Hutt <thutt@chromium.org>

Acked-by: Liam Girdwood <lrg@ti.com>
