From: "A. C. Censi" <accensi@gmail.com>
Subject: Fwd: Re:  Gmail thinks most alsa-devel mail is spam
Date: Wed, 21 Oct 2015 23:55:41 -0200
Message-ID: <CAA+gEbaUQEm0HAKNs7t=aXSt6X7KOPnsdSTAhGRoVAq89J3WGw@mail.gmail.com>
References: <5627833D.8020908@tabi.org>
 <CAG5mAdyivbfwi1JBwHdu+c89j0GkE0Cux+eww7+SnAvUTkCPug@mail.gmail.com>
 <CAOZdJXXWDuU=Rk03KwixpFu1LYYX8Kzaq6q-wu-rA9uGTvHSWw@mail.gmail.com>
 <CAA+gEbYUaJcJ+qHskBfCd79JLEmjexhmMPGQE27i-sydOZgugA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f179.google.com (mail-ig0-f179.google.com
 [209.85.213.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 53059266808
 for <Alsa-devel@alsa-project.org>; Thu, 22 Oct 2015 03:55:43 +0200 (CEST)
Received: by igbhv6 with SMTP id hv6so50818905igb.0
 for <Alsa-devel@alsa-project.org>; Wed, 21 Oct 2015 18:55:42 -0700 (PDT)
In-Reply-To: <CAA+gEbYUaJcJ+qHskBfCd79JLEmjexhmMPGQE27i-sydOZgugA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ALSA development <Alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

--
A C Censi
accensi @ gmail . com
accensi @ montreal . com . br
---------- Forwarded message ----------
From: "A. C. Censi" <accensi@gmail.com>
Date: Oct 21, 2015 22:50
Subject: Re: [alsa-devel] Gmail thinks most alsa-devel mail is spam
To: "Timur Tabi" <timur@tabi.org>
Cc:

I have the same problem and not only with gmail, but my company server does
the same check

Probably the misclassification is due to:

- Keep valid reverse DNS records for the IP address(es) from which you send
mail, pointing to your domain.

>From the source one email misclassified:

Received: by 10.107.154.1 with SMTP id c1csp256822ioe;
        Wed, 21 Oct 2015 13:55:10 -0700 (PDT)
X-Received: by 10.194.216.228 with SMTP id ot4mr13139641wjc.156.1445460910180;
        Wed, 21 Oct 2015 13:55:10 -0700 (PDT)
Return-Path: <alsa-devel-bounces@alsa-project.org>
Received: from alsa0.perex.cz ([2002:4d30:e0f1:1:5054:ff:fe8b:a8f0])
        by mx.google.com with ESMTP id kb1si14026248wjc.16.2015.10.21.13.55.09;
        Wed, 21 Oct 2015 13:55:10 -0700 (PDT)
Received-SPF: neutral (google.com: 2002:4d30:e0f1:1:5054:ff:fe8b:a8f0
is neither permitted nor denied by best guess record for domain of
alsa-devel-bounces@alsa-project.org)
client-ip=2002:4d30:e0f1:1:5054:ff:fe8b:a8f0;
Authentication-Results: mx.google.com;
       spf=neutral (google.com: 2002:4d30:e0f1:1:5054:ff:fe8b:a8f0 is
neither permitted nor denied by best guess record for domain of
alsa-devel-bounces@alsa-project.org)
smtp.mailfrom=alsa-devel-bounces@alsa-project.org
Received: by alsa0.perex.cz (Postfix, from userid 1000)
	id 782D52667C3; Wed, 21 Oct 2015 22:55:09 +0200 (CEST)


An correct email fom linux-fs-devel list:

Received: by 10.107.154.1 with SMTP id c1csp276010ioe;
        Wed, 21 Oct 2015 14:43:58 -0700 (PDT)
X-Received: by 10.66.147.74 with SMTP id ti10mr13215193pab.88.1445463838506;
        Wed, 21 Oct 2015 14:43:58 -0700 (PDT)
Return-Path: <linux-fsdevel-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org. [209.132.180.67])
        by mx.google.com with ESMTP id qp7si1236731pbc.93.2015.10.21.14.43.44;
        Wed, 21 Oct 2015 14:43:58 -0700 (PDT)
Received-SPF: pass (google.com: best guess record for domain of
linux-fsdevel-owner@vger.kernel.org designates 209.132.180.67 as
permitted sender) client-ip=209.132.180.67;
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of
linux-fsdevel-owner@vger.kernel.org designates 209.132.180.67 as
permitted sender) smtp.mailfrom=linux-fsdevel-owner@vger.kernel.org

To solve adjust the DNS for the reverse entry and PTR record.

ACC


On Wed, Oct 21, 2015 at 8:53 PM, Timur Tabi <timur@tabi.org> wrote:

> On Wed, Oct 21, 2015 at 2:32 PM, Caleb Crome <caleb@crome.org> wrote:
>
> > In gmail go to
> >
> >    settings->Filters and blocked Addresses->Create New Filter
> >
> > Subject = [alsa-devel]
> >
> > Then, "Create Filter With This Search"
> >
> > Then "Apply The Label" = alsa
> > and tick the box that says, "Never send it to Spam"
>
> All that does is disable the spam filter completely for alsa-devel,
> which means I'll get more spam.  Then I will have to scan my
> alsa-devel folder to remove actual spam, which is more difficult than
> fishing out legitimate mail from the spam folder.
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>



-- 
A. C. Censi
accensi [em] gmail [ponto] com
accensi [em] montreal [ponto] com [ponto] br
