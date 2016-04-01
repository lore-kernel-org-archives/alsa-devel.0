From: Adam Goode <agoode@google.com>
Subject: Re: [PATCH - alsa-lib 1/1] Change card/pid get
 functions to return -ENOSYS if the kernel is too old
Date: Fri, 1 Apr 2016 13:45:46 -0400
Message-ID: <CAOf41Nm11=oPBV_HwBDipMhc0SO4H4VTFAmoKaUnvPq1V0L2Hg@mail.gmail.com>
References: <1459532030-6387-1-git-send-email-agoode@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f179.google.com (mail-yw0-f179.google.com
 [209.85.161.179])
 by alsa0.perex.cz (Postfix) with ESMTP id A0A6B26512A
 for <alsa-devel@alsa-project.org>; Fri,  1 Apr 2016 19:46:26 +0200 (CEST)
Received: by mail-yw0-f179.google.com with SMTP id g3so176943026ywa.3
 for <alsa-devel@alsa-project.org>; Fri, 01 Apr 2016 10:46:26 -0700 (PDT)
In-Reply-To: <1459532030-6387-1-git-send-email-agoode@google.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: martin.koegler@chello.at
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, Apr 1, 2016 at 1:33 PM, Adam Goode <agoode@google.com> wrote:

> When trying to get the pid or card of a client, the get functions will
> return -1 if there is no pid or card for a client. Clients have zero or
> one of these, so -1 is correct for these cases. But we also need to detect
> the case where the kernel cannot tell us if there is a card or pid, so
> that userspace can fallback to probing this information in the old way.
>


Also: Thanks Martin, for taking care of this! I wrote the seq/sysfs probing
code in Chromium and have been struggling to find the time to fix it up.
Now I've got no excuse. :)


Adam
