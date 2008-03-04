From: "Claudio Matsuoka" <cmatsuoka@gmail.com>
Subject: Re: [PATCH] model for alc883 to support M720R
Date: Tue, 4 Mar 2008 12:42:43 -0300
Message-ID: <5f52f6d70803040742m54a601a4pe11f4e6a19d894fe@mail.gmail.com>
References: <1204622185.13743.14.camel@localhost.localdomain>
	<s5hd4qa6anc.wl%tiwai@suse.de>
	<5f52f6d70803040355y63031fc0q5b4876a1c69bff8e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.239])
	by alsa0.perex.cz (Postfix) with ESMTP id 02E7E1038C5
	for <alsa-devel@alsa-project.org>; Tue,  4 Mar 2008 16:42:45 +0100 (CET)
Received: by wr-out-0506.google.com with SMTP id 58so1783077wri.8
	for <alsa-devel@alsa-project.org>; Tue, 04 Mar 2008 07:42:44 -0800 (PST)
In-Reply-To: <5f52f6d70803040355y63031fc0q5b4876a1c69bff8e@mail.gmail.com>
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

On Tue, Mar 4, 2008 at 8:55 AM, Claudio Matsuoka <cmatsuoka@gmail.com> wrote:

> On Tue, Mar 4, 2008 at 7:33 AM, Takashi Iwai <tiwai@suse.de> wrote:
>
>  > At Tue, 04 Mar 2008 17:16:25 +0800, Jiang zhe wrote:
>  >
> >  > Please refer to [0003781] on the alsa mantis.
>  >  > There is no suitable model for M720R.
>  >  > This patch is to support HP jack-sensing and mixer.
>  >
>  >  Applied to HG tree (with minor modifications).  Thanks.
>
>  Interesting, I tested a Clevo M720R yesterday with a recent ALSA
>  snapshot and it worked correctly (HP detection and all) prior to
>  applying this patch. I'll recheck this, but I believe this patch might
>  be not entirely necessary.

My M720R is using auto configuration. The BIOS version is 1.00.05, but
I think Jiang's is different and requires the quirk to work. If that's
the case, keeping the quirk ensures it will work regardless of BIOS
version.
