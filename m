From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Audio Jack Out does not work
Date: Wed, 8 Apr 2015 09:57:13 +0800
Message-ID: <CAN8cciY89MH1p7An-RsRkMbFgdKF3OdYGO1hHV594buOpjSuBw@mail.gmail.com>
References: <CAD67Mo_N1_uEtjWKcV4+Rkjrvc6kcZuvUgrMPvBURJX0hFaaMA@mail.gmail.com>
 <20150407225642.GN16501@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f175.google.com (mail-ob0-f175.google.com
 [209.85.214.175])
 by alsa0.perex.cz (Postfix) with ESMTP id F28C9265068
 for <alsa-devel@alsa-project.org>; Wed,  8 Apr 2015 03:57:14 +0200 (CEST)
Received: by obbgh1 with SMTP id gh1so112651754obb.1
 for <alsa-devel@alsa-project.org>; Tue, 07 Apr 2015 18:57:13 -0700 (PDT)
In-Reply-To: <20150407225642.GN16501@mwanda>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, linux-kernel@vger.kernel.org, Taylor Smock <smocktaylor@gmail.com>, joe@perches.com, david.henningsson@canonical.com
List-Id: alsa-devel@alsa-project.org

>
> So it's 03ad6a8c93b6df2 ('ALSA: hda - Fix "PCM" name being used on one
> DAC when there are two DACs') which causes the problem?  Have you tried
> to just revert that patch?
>
> git show 03ad6a8c93b6df2d65c305b5b5f9474068b45bfb | patch -p1 -R
>

Please provide output of alsa-info.sh

This patch only change the name of control, you will also need pulseaudio
patch if you are using pulseaudio

http://cgit.freedesktop.org/pulseaudio/pulseaudio/commit/src/modules/alsa/mixer?id=aec811798cd883a454b9b5cd82c77831906bbd2d

Are you using a laptop with two DACs , 2.1 speakers and headphone ?
