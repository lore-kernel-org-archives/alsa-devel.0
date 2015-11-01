From: "A. C. Censi" <accensi@gmail.com>
Subject: Re: Fwd: Re: Gmail thinks most alsa-devel mail is spam
Date: Sun, 1 Nov 2015 11:55:25 -0200
Message-ID: <CAA+gEbbRr5E9Nw8_Jfv-UEtudqbK=4oZMdtbJwFD+_KXRL2+3Q@mail.gmail.com>
References: <5627833D.8020908@tabi.org>
 <CAG5mAdyivbfwi1JBwHdu+c89j0GkE0Cux+eww7+SnAvUTkCPug@mail.gmail.com>
 <CAOZdJXXWDuU=Rk03KwixpFu1LYYX8Kzaq6q-wu-rA9uGTvHSWw@mail.gmail.com>
 <CAA+gEbYUaJcJ+qHskBfCd79JLEmjexhmMPGQE27i-sydOZgugA@mail.gmail.com>
 <CAA+gEbaUQEm0HAKNs7t=aXSt6X7KOPnsdSTAhGRoVAq89J3WGw@mail.gmail.com>
 <56289390.40902@perex.cz>
 <CAOZdJXXsWDMmDS1n4ssLyPyxX5OWmONmBaO-iOgt5TfgQJBbaA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ig0-f180.google.com (mail-ig0-f180.google.com
 [209.85.213.180])
 by alsa0.perex.cz (Postfix) with ESMTP id 80F5326047B
 for <Alsa-devel@alsa-project.org>; Sun,  1 Nov 2015 14:55:26 +0100 (CET)
Received: by igvi2 with SMTP id i2so34772697igv.0
 for <Alsa-devel@alsa-project.org>; Sun, 01 Nov 2015 05:55:25 -0800 (PST)
In-Reply-To: <CAOZdJXXsWDMmDS1n4ssLyPyxX5OWmONmBaO-iOgt5TfgQJBbaA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@codeaurora.org>
Cc: ALSA development <Alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Jaroslav

We are still getting alsa-dev email classiified as possible by gmail and
others.

It seems that your DNS entries still misses a PTR record. You can check
with digweb
http://www.digwebinterface.com/?hostnames=2002%3A4d30%3Ae0f1%3A1%3A5054%3Aff%3Afe8b%3Aa8f0%0D%0A&type=Reverse&useresolver=8.8.4.4&ns=all&nameservers=

or dnsquery.org
...
We've got referrals (ns1.bravonet.cz., ns2.dkm.cz.) from queries on
previous step. We'll query them now, until we got an authoritative result
153.67 msns1.bravonet.cz. [77.48.224.1] (Dubne, Jihocesky Kraj, Czech
Republic)
;;Authority
224.48.77.in-addr.arpa. 86400 undefined NS ns1.bravonet.cz.
224.48.77.in-addr.arpa. 86400 undefined NS ns2.dkm.cz.
;;Answer
243.224.48.77.in-addr.arpa. 86400 undefined PTR alsa0.perex.cz
;;Additional
ns1.bravonet.cz. 86400 undefined A 77.48.224.1

We got authoritative results from ns1.bravonet.cz.


Thanks

A C Censi

On Wed, Oct 28, 2015 at 8:36 PM, Timur Tabi <timur@codeaurora.org> wrote:

> On Thu, Oct 22, 2015 at 2:43 AM, Jaroslav Kysela <perex@perex.cz> wrote:
> >
> > OK. The outgoing e-mails should be from IPv4 now which has registered
> > reverse DNS record. You may check.
>
> It doesn't appear to be working.  I still get lots of alsa-devel posts
> in my Spam folder, with the same reason.
>
> Received: from alsa0.perex.cz (alsa0.perex.cz. [77.48.224.243])
>         by mx.google.com with ESMTP id
> qo10si41235490wjc.143.2015.10.26.17.34.56;
>         Mon, 26 Oct 2015 17:34:56 -0700 (PDT)
>
> --
> Qualcomm Innovation Center, Inc.
> The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
> a Linux Foundation Collaborative Project.
>



-- 
A. C. Censi
accensi [em] gmail [ponto] com
accensi [em] montreal [ponto] com [ponto] br
