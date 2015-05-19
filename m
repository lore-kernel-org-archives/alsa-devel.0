From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: getting the sound to work on my asus m6s00v
Date: Tue, 19 May 2015 09:07:14 +0800
Message-ID: <CAN8cciZMN0XkOjKQHSJBHgsq-4JsgC8nqDWns1=9WWOwTbLL4w@mail.gmail.com>
References: <5a713868662bb9ea47f5a30bd1849ce8@swn.nu>
 <5508DD4D.3040901@canonical.com>
 <CAN8cciaU_U+UwpJkayz2RhpSjfur9TC+X_HVC1=AGY2ypbcEmA@mail.gmail.com>
 <e137111e5526d3424e7ce1f219bcfa88@swn.nu>
 <CAN8cciY7zPaM1kGbky3st_V5G=vg_aeLrm2QrNbpVinYOU=qyA@mail.gmail.com>
 <64443a816660f3098fc300c7d7b5a01f@swn.nu>
 <CAN8cciY-K-FkQp1H6Bj0v51CRHrOyFrJ2=ZaY5YLvkRmNU8TRg@mail.gmail.com>
 <ec6b05bc169224058a4835e2139cbcb4@swn.nu>
 <CAN8cciYo-SSeoBg69qaj+aYBx+ZRbVuhbgkURutuBWGwCxauWA@mail.gmail.com>
 <CAN8cciam2=TE3zhWNB_GQEr1Q1z_X7S+k34fAgajE_XNYJzo0Q@mail.gmail.com>
 <CAN8cciZhtL_C-DAErzhM4E3t3nn7KdAbjQXQEPk3iVcBvm4aUw@mail.gmail.com>
 <CAN8cciZqdwONrrpWc0EKNfGz9Xwibh9Xj+=JnZ=ieK+m1rbF8w@mail.gmail.com>
 <CAN8cciZNz1TGSQah+KzRGGhRwGWR4U3LbMVUxV+=0mtX1gdM=w@mail.gmail.com>
 <f7a08a5262537ca8764cb91177f85646@swn.nu>
 <s5hiodlz116.wl-tiwai@suse.de>
 <CAN8cciatm9MjVkc9wy-dOwQow9i9KuffxE-XcyqkbSi=78Se7w@mail.gmail.com>
 <10d760a1b9c16c5388124146d090f3e0@swn.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f171.google.com (mail-ob0-f171.google.com
 [209.85.214.171])
 by alsa0.perex.cz (Postfix) with ESMTP id 5101426129B
 for <alsa-devel@alsa-project.org>; Tue, 19 May 2015 03:07:16 +0200 (CEST)
Received: by obblk2 with SMTP id lk2so143623obb.0
 for <alsa-devel@alsa-project.org>; Mon, 18 May 2015 18:07:15 -0700 (PDT)
In-Reply-To: <10d760a1b9c16c5388124146d090f3e0@swn.nu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Christian Gleerup <cromozon@swn.nu>
Cc: Hui Wang <hui.wang@canonical.com>, tiwai@suse.de, ALSA Development Mailing List <alsa-devel@alsa-project.org>, nb <nb@dagami.org>, korobka@en.gov.ua
List-Id: alsa-devel@alsa-project.org

>
> I manged to get sound working again while playing arround with hdaretask.
> but initially i tried setting up the outputs as suggest,
> which didn't giveanything, then a then I tried setting 0.15 as internal
speaker also.
>
> For the first few seconds there where no sound, and then the sound slowly
started to increase, but not the sound i was playing just some noise, not
continously but.. erhm like this:
> .|.|.|.|.|.|.|.|.|.|.|.|.|.|
>
> I was not able to kill the sound even when muting all channels in alsa
mixer.

> then I removed all overrides (expect ch0x18), after clicking apply the
repeating periodic sound dis-apered, and I was able to play sound.
>
> So now I am able to play sound through the internal speaker
> I have toggled ho_mic_detect=false, set model=auto.

You have to post output of alsa-info.sh for your patched driver if it work

Do you mean you cannot get correct impedence value for your jacks ?
