From: "ilya .d" <errordeveloper@gmail.com>
Subject: Re: snd-hdsp in 2.6.22 crashes badly
Date: Mon, 29 Oct 2007 02:25:02 +0000
Message-ID: <20071029022502.GA7907@00110101.errordevlopment.org.uk>
References: <20071014222122.GA9228@00110101.errordevlopment.org.uk>
	<s5hr6jw629e.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.171])
	by alsa0.perex.cz (Postfix) with ESMTP id D9D8724A00
	for <alsa-devel@alsa-project.org>; Mon, 29 Oct 2007 03:23:47 +0100 (CET)
Received: by ug-out-1314.google.com with SMTP id h2so920668ugf
	for <alsa-devel@alsa-project.org>; Sun, 28 Oct 2007 19:23:47 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <s5hr6jw629e.wl%tiwai@suse.de>
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

On Mon, Oct 15, 2007 at 01:33:33PM +0200, Takashi Iwai wrote:
> Does the patch below fix the problem?
> 
yes it fixes it.
all fine. thanx a lot.

-- 
cheers,
ilya .d

> 
> Thanks,
> 
> Takashi
> 
> diff -r 29661bff769f pci/rme9652/hdsp.c
> --- a/pci/rme9652/hdsp.c	Mon Oct 15 10:36:45 2007 +0200
> +++ b/pci/rme9652/hdsp.c	Mon Oct 15 13:59:20 2007 +0200
> @@ -3058,6 +3058,9 @@ static int hdsp_dds_offset(struct hdsp *
>  	u32 r;
>  	unsigned int dds_value = hdsp->dds_value;
>  	int system_sample_rate = hdsp->system_sample_rate;
> +
> +	if (!dds_value)
> +		return 0;
>  
>  	n = DDS_NUMERATOR;
>  	/*
