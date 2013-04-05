From: Eldad Zack <eldad@fogrefinery.com>
Subject: Re: [PATCH 05/10] ALSA: usb-audio: use endianness
 macros
Date: Fri, 5 Apr 2013 20:36:27 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.1304052010090.1139@xoschi>
References: <1364745152-1762-1-git-send-email-eldad@fogrefinery.com>
 <1364745152-1762-6-git-send-email-eldad@fogrefinery.com>
 <51585EF4.7090907@ladisch.de> <alpine.LNX.2.00.1303311909180.1963@xoschi>
 <515872D0.6010400@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f53.google.com (mail-bk0-f53.google.com
 [209.85.214.53])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C29C2625E3
 for <alsa-devel@alsa-project.org>; Fri,  5 Apr 2013 20:39:38 +0200 (CEST)
Received: by mail-bk0-f53.google.com with SMTP id e19so2213919bku.26
 for <alsa-devel@alsa-project.org>; Fri, 05 Apr 2013 11:39:36 -0700 (PDT)
In-Reply-To: <515872D0.6010400@ladisch.de>
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



On Sun, 31 Mar 2013, Clemens Ladisch wrote:

> Eldad Zack wrote:
> > On Sun, 31 Mar 2013, Clemens Ladisch wrote:
> >> cpu_to_le32() returns not u32 but __le32.
> >> Please use that to make sparse happy.
> >
> > BTW, sparse (0.4.3) didn't complain on my box.
> > I'm just calling make C=1.
> 
> make C=1 CF=-D__CHECK_ENDIAN__

Heh, I felt quite silly about this question now that I read
Documentation/sparse.txt to the end :)

I see why you care so much about it too. I just found 3 places 
with endian bugs thanks to sparse, where usb_control_msg() is
handed a LE instead of CPU native.

snd_nativeinstruments_control_get()/put() and 
snd_usb_nativeinstruments_boot_quirk do this (I'll post a patch to
fix this soon).

Cheers,
Eldad
