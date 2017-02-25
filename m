From: Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH] ASoC: sh: Remove redundant out of memory
	message
Date: Sat, 25 Feb 2017 18:20:38 -0300
Message-ID: <CAOMZO5Dj_NMib1NxGotDE-zyc0ifDUOzeGAdmAEOPzRKZJkUcA@mail.gmail.com>
References: <20170225101629.12694-1-done.cristian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ot0-f169.google.com (mail-ot0-f169.google.com
 [74.125.82.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 7551C26751F
 for <alsa-devel@alsa-project.org>; Sat, 25 Feb 2017 22:20:40 +0100 (CET)
Received: by mail-ot0-f169.google.com with SMTP id x10so33166434otb.1
 for <alsa-devel@alsa-project.org>; Sat, 25 Feb 2017 13:20:39 -0800 (PST)
In-Reply-To: <20170225101629.12694-1-done.cristian@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Cristian Done <done.cristian@gmail.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Feb 25, 2017 at 7:16 AM, Cristian Done <done.cristian@gmail.com> wrote:

>         master = devm_kzalloc(&pdev->dev, sizeof(*master), GFP_KERNEL);
>         if (!master) {
> -               dev_err(&pdev->dev, "Could not allocate master\n");
>                 return -ENOMEM;
>         }

As you are removing the dev_err line you can also remove the if brackets.
