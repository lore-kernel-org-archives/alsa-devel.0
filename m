From: James Cameron <quozl@laptop.org>
Subject: Re: MEDION laptop full of Intel components
Date: Wed, 14 Jun 2017 16:32:14 +1000
Message-ID: <20170614063214.GH16503@us.netrek.org>
References: <CALmBKt=WEiJfCEwSKiXzkd9duQ3Bp=o2X3NEcKnQfrPkF77xbQ@mail.gmail.com>
 <CALmBKtkhByU1+5SNXQdS+wRSGQoc8yRgcP=sOH7cF3=f6AGU-g@mail.gmail.com>
 <CALmBKt=6e=ht4ASxbRbzn74xkNSA9+Kap_7E9TJBRFB1LVMNBw@mail.gmail.com>
 <CALmBKt=G63MiXMGshdVCTJ_BU25K2wvCo4XyNY8rgRPKDvrwRg@mail.gmail.com>
 <CALmBKt=bVaST+apjdxiOndBN6SY56+=XR6EjZA44ACu2gTnZrw@mail.gmail.com>
 <CALmBKtn_LrjDUnvXUzoZyZ-sTAuye8UGN0umDRapNVk-NG62=A@mail.gmail.com>
 <CALmBKtnx-rvKbOhy_vER3e8Gpcnk43CaQm-oM5E-mhi-FVDGiw@mail.gmail.com>
 <CALmBKtnhZXeUyVskjhyP3A40iMLf0PE8rZKdhy07GBGD-fo5ig@mail.gmail.com>
 <CALmBKtm=TgdZEWFFLCTYN8DXmWimCC16a4QGHx7mwWVwskc9dg@mail.gmail.com>
 <CALmBKtmY5r9iRGvg94zetp13hmaHoJf3Gkm7SdRuB66=YnR3=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from swan.laptop.org (swan.media.mit.edu [18.85.44.157])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F7CB266587
 for <alsa-devel@alsa-project.org>; Wed, 14 Jun 2017 08:32:26 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CALmBKtmY5r9iRGvg94zetp13hmaHoJf3Gkm7SdRuB66=YnR3=A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: fulgor fulgor <l.vanwinnendaele@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 14, 2017 at 07:38:15AM +0200, fulgor fulgor wrote:
> Hello,
> I bought a MEDION laptop in December 2016
> I had some problems like crashes
> but with manjaro I still have no sound
> I believe the device is not detected
> I tried to get hardware informations in a file

Missing is dmesg.  But your lsmod shows rt5640, rt5645, and rt5670
codec drivers loaded.  Without dmesg I'm not sure which one is in use,
if any.

I'm having "no sound" issue with rt5645 on same CPU family.

-- 
James Cameron
http://quozl.netrek.org/
