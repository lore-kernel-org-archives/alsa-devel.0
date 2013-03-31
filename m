From: Eldad Zack <eldad@fogrefinery.com>
Subject: Re: [PATCH 05/10] ALSA: usb-audio: use endianness
 macros
Date: Sun, 31 Mar 2013 19:15:48 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1303311909180.1963@xoschi>
References: <1364745152-1762-1-git-send-email-eldad@fogrefinery.com>
 <1364745152-1762-6-git-send-email-eldad@fogrefinery.com>
 <51585EF4.7090907@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f46.google.com (mail-bk0-f46.google.com
 [209.85.214.46])
 by alsa0.perex.cz (Postfix) with ESMTP id 79839261B3E
 for <alsa-devel@alsa-project.org>; Sun, 31 Mar 2013 19:15:53 +0200 (CEST)
Received: by mail-bk0-f46.google.com with SMTP id je9so692230bkc.19
 for <alsa-devel@alsa-project.org>; Sun, 31 Mar 2013 10:15:53 -0700 (PDT)
In-Reply-To: <51585EF4.7090907@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Daniel Mack <zonque@gmail.com>
List-Id: alsa-devel@alsa-project.org


Hi Clemens,

On Sun, 31 Mar 2013, Clemens Ladisch wrote:

> Eldad Zack wrote:
> > Replace the endianness conversions with the kernel-wide swabbing macros.
> 
> > +	u32 data;
> > +	data = cpu_to_le32(rate);
> 
> cpu_to_le32() returns not u32 but __le32.
> Please use that to make sparse happy.

Thanks! Fixed locally. This propogates along the series, so I'll wait
for other comments to repost.

BTW, sparse (0.4.3) didn't complain on my box. Maybe I'm doing it wrong?
I'm just calling make C=1.

Cheers,
Eldad
