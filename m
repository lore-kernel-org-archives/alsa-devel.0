From: "Claudio Matsuoka" <cmatsuoka@gmail.com>
Subject: Re: [PATCH] model for alc883 to support M720R
Date: Tue, 4 Mar 2008 08:55:40 -0300
Message-ID: <5f52f6d70803040355y63031fc0q5b4876a1c69bff8e@mail.gmail.com>
References: <1204622185.13743.14.camel@localhost.localdomain>
	<s5hd4qa6anc.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.187])
	by alsa0.perex.cz (Postfix) with ESMTP id 53E0624498
	for <alsa-devel@alsa-project.org>; Tue,  4 Mar 2008 12:55:48 +0100 (CET)
Received: by rv-out-0910.google.com with SMTP id k20so554473rvb.32
	for <alsa-devel@alsa-project.org>; Tue, 04 Mar 2008 03:55:41 -0800 (PST)
In-Reply-To: <s5hd4qa6anc.wl%tiwai@suse.de>
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
Cc: Jiang zhe <zhe.jiang@intel.com>, alsa-devel@alsa-project.org, miura@mandriva.com
List-Id: alsa-devel@alsa-project.org

On Tue, Mar 4, 2008 at 7:33 AM, Takashi Iwai <tiwai@suse.de> wrote:

> At Tue, 04 Mar 2008 17:16:25 +0800, Jiang zhe wrote:
>
>  > Please refer to [0003781] on the alsa mantis.
>  > There is no suitable model for M720R.
>  > This patch is to support HP jack-sensing and mixer.
>
>  Applied to HG tree (with minor modifications).  Thanks.

Interesting, I tested a Clevo M720R yesterday with a recent ALSA
snapshot and it worked correctly (HP detection and all) prior to
applying this patch. I'll recheck this, but I believe this patch might
be not entirely necessary.


>  > The reporter complained that there was a constant noise when
>  > he recorded from Mic, It existed even after he muted the input.
>  > I checked the codec info carefully, the input widget was muted
>  > indeed.
>  >
>  > It's strange, Is there anything special for this codec?
>
>  I don't know of such a problem.  We had a noisy *output* on AD1986A,
>  but the input isn't a problem.

I didn't test recording extensively. Miura, did you notice any
problems in mic input?
