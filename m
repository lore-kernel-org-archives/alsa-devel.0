From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Audio Jack Out does not work
Date: Wed, 8 Apr 2015 21:20:29 +0800
Message-ID: <CAN8ccib8mOjUKEEexssF0Xocs4WgnE7n1g-N=og3PbUj2Z-q7w@mail.gmail.com>
References: <CAD67Mo_N1_uEtjWKcV4+Rkjrvc6kcZuvUgrMPvBURJX0hFaaMA@mail.gmail.com>
 <20150407225642.GN16501@mwanda>
 <CAN8cciY89MH1p7An-RsRkMbFgdKF3OdYGO1hHV594buOpjSuBw@mail.gmail.com>
 <20150408080630.GO16501@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ob0-f173.google.com (mail-ob0-f173.google.com
 [209.85.214.173])
 by alsa0.perex.cz (Postfix) with ESMTP id A90412652CE
 for <alsa-devel@alsa-project.org>; Wed,  8 Apr 2015 15:20:31 +0200 (CEST)
Received: by obbfy7 with SMTP id fy7so136940865obb.2
 for <alsa-devel@alsa-project.org>; Wed, 08 Apr 2015 06:20:30 -0700 (PDT)
In-Reply-To: <20150408080630.GO16501@mwanda>
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

> > This patch only change the name of control, you will also need
pulseaudio
> > patch if you are using pulseaudio
> >
> >
http://cgit.freedesktop.org/pulseaudio/pulseaudio/commit/src/modules/alsa/mixer?id=aec811798cd883a454b9b5cd82c77831906bbd2d
>
> Ugh...  You are going to make Linus start cursing.
>
> https://lkml.org/lkml/2012/12/23/75
>

The patch does not only affect codecs with two DAC , using hda-emu

it also affect several codecs

cmi9880-lg-lw60
idt92hd73c1x5-alienware-m17x
stac9200-dell-precision-490
stac9228-dell-xps-m1330

Rename "PCM playback volume" control also force the system to create
softvol  "PCM playback volume" when application use front or sysdefault
device
