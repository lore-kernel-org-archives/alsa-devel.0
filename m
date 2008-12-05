From: "Jarkko Nikula" <jhnikula@gmail.com>
Subject: Re: [PATCH] ASoC: Add support for OMAP3 Pandora
Date: Fri, 5 Dec 2008 12:41:06 +0200
Message-ID: <bd7b27490812050241i6f0f3de3t9ab9c22f33da8e3f@mail.gmail.com>
References: <1228423194-19567-1-git-send-email-notasas@gmail.com>
	<bd7b27490812042348t6593afa8saafb3a42bd346ad7@mail.gmail.com>
	<6ed0b2680812050115v635095f8p336a6825654a205f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.150])
	by alsa0.perex.cz (Postfix) with ESMTP id 826231037F2
	for <alsa-devel@alsa-project.org>; Fri,  5 Dec 2008 11:41:07 +0100 (CET)
Received: by ey-out-1920.google.com with SMTP id 21so1836703eyc.56
	for <alsa-devel@alsa-project.org>; Fri, 05 Dec 2008 02:41:06 -0800 (PST)
In-Reply-To: <6ed0b2680812050115v635095f8p336a6825654a205f@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Grazvydas Ignotas <notasas@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>
> >> +       if (!machine_is_omap3_pandora()) {
> >> +               pr_debug(PREFIX "Not OMAP3 Pandora\n");
> >> +               return -ENODEV;
> >> +       }
> >> +       pr_info("OMAP3 Pandora SoC init\n");
> >> +
> >
> > Minor muttering, but I don't see very much use for these debug prints.
>
> Well, every other OMAP3 board file has this. Do I need to resend?
>

Not necessary but if doing another modifications.


Jarkko
