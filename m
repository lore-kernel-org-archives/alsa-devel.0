From: "John Kacur" <jkacur@gmail.com>
Subject: Re: Fwd: [PATCH 7/9] ASoC: Blackfin: I2S CPU DAI driver
Date: Thu, 9 Oct 2008 10:02:55 +0200
Message-ID: <520f0cf10810090102je412ff9rb02017973d339ec1@mail.gmail.com>
References: <1220516528-20301-1-git-send-email-cooloney@kernel.org>
	<1220516528-20301-8-git-send-email-cooloney@kernel.org>
	<20080904144343.GB32531@rakim.wolfsonmicro.main>
	<520f0cf10810082353r2694535evc3edbcb2b3c76796@mail.gmail.com>
	<520f0cf10810082358t274a46afy7d9c5bbc5ca56de7@mail.gmail.com>
	<38521.1223537753@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.179])
	by alsa0.perex.cz (Postfix) with ESMTP id DEA6D2434D
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Oct 2008 10:03:09 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id l35so4160235waf.16
	for <alsa-devel@alsa-project.org>; Thu, 09 Oct 2008 01:02:55 -0700 (PDT)
In-Reply-To: <38521.1223537753@turing-police.cc.vt.edu>
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
To: Valdis.Kletnieks@vt.edu
Cc: Cliff Cai <cliff.cai@analog.com>, Bryan Wu <cooloney@kernel.org>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Oct 9, 2008 at 9:35 AM,  <Valdis.Kletnieks@vt.edu> wrote:
> On Thu, 09 Oct 2008 08:58:08 +0200, John Kacur said:
>
>> My eyes fell upon this switch statement, probably I have similar
>> criticisms as to what has already been said, but:
>> 1. Surely the default case is also an -EINVAL
>> 2. Why not let all the EINVALS fall through, it will shorten up the
>> code, and IMO make it more readable, something like this?
>> +       switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
>> +       case SND_SOC_DAIFMT_CBM_CFM: /* Passing Case */
>> +               break;
>> +       case SND_SOC_DAIFMT_CBS_CFS: /* Failing Cases */
>> +       case SND_SOC_DAIFMT_CBM_CFS:
>> +       case SND_SOC_DAIFMT_CBS_CFM:
>> +               ret = -EINVAL;
>> +               break;
>> +       default:
>> +               printk(KERN_INFO "Unknown SND_SOC_DAIFMT kind\n");
>> +               ret = -EINVAL;
>> +               break;
>> +       }
>
> Even shorter, but puts the default in a non-standard place:
>
> +       switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
> +       case SND_SOC_DAIFMT_CBM_CFM: /* Passing Case */
> +               break;
> +       default:                        /* So much Fail we should say something */
> +               printk(KERN_INFO "Unknown SND_SOC_DAIFMT kind\n");
> +       case SND_SOC_DAIFMT_CBS_CFS: /* Failing Cases */
> +       case SND_SOC_DAIFMT_CBM_CFS:
> +       case SND_SOC_DAIFMT_CBS_CFM:
> +               ret = -EINVAL;
> +               break;
> +       }
>
> (I see a checkpatch update to check where default: is, coming in 3.. 2.. 1.. :)
>

Well, of course you only want to make things shorter when it increases
clarity, you don't want to make things shorter for the sake of making
them shorter, so yeah, I would nix that non-standard default position
too.
