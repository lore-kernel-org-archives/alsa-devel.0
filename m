From: "Risto Suominen" <risto.suominen@gmail.com>
Subject: Re: [PATCH 001/003] snd-powermac: enable headphone
	detection
Date: Tue, 15 Apr 2008 19:39:38 +0300
Message-ID: <46e1c7760804150939y372bc7cco403d60e95f5e5884@mail.gmail.com>
References: <46e1c7760804141012s22f638a1v199ae9a4af112169@mail.gmail.com>
	<s5h3apn480y.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.244])
	by alsa0.perex.cz (Postfix) with ESMTP id C0C3B103805
	for <alsa-devel@alsa-project.org>;
	Tue, 15 Apr 2008 18:39:48 +0200 (CEST)
Received: by an-out-0708.google.com with SMTP id c36so583391ana.80
	for <alsa-devel@alsa-project.org>; Tue, 15 Apr 2008 09:39:38 -0700 (PDT)
In-Reply-To: <s5h3apn480y.wl%tiwai@suse.de>
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2008/4/15, Takashi Iwai <tiwai@suse.de>:
>
> Please split the patch, one to fix the initialization and one to fix
>  coding styles.
>

Ok, I will. Sorry, I'm still a beginner at this.

>
>  > @@ -1063,6 +1063,10 @@ static int __init snd_pmac_detect(struct
>  >       else {
>  >               struct pci_dev *pdev = NULL;
>  >
>  > +#ifndef for_each_pci_dev
>  > +#define for_each_pci_dev(d) \
>  > +             while ((d = pci_get_device(PCI_ANY_ID, PCI_ANY_ID, d)) != NULL)
>  > +#endif
>
>
> Why is this needed?
>

Good question :) I found it necessary on older kernels, it didn't
exist. So maybe it should be there only in alsa-driver tree. I
believed that it was the same source.

Risto
