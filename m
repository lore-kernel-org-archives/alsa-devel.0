From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [RFC PATCH 1/2] ALSA: hda - Fix "PCM" name being
 used on one DAC when there are two DACs
Date: Thu, 16 Oct 2014 23:02:32 +0800
Message-ID: <CAN8cciZAteQAaG9GAxwLWyF6u5xH_fGtRDOTq5j+4LNoj_d_jA@mail.gmail.com>
References: <1413466426-2672-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qa0-f53.google.com (mail-qa0-f53.google.com
 [209.85.216.53])
 by alsa0.perex.cz (Postfix) with ESMTP id F03F92605C9
 for <alsa-devel@alsa-project.org>; Thu, 16 Oct 2014 17:02:34 +0200 (CEST)
Received: by mail-qa0-f53.google.com with SMTP id v10so2456838qac.26
 for <alsa-devel@alsa-project.org>; Thu, 16 Oct 2014 08:02:34 -0700 (PDT)
In-Reply-To: <1413466426-2672-1-git-send-email-david.henningsson@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>
> In the scenario where there is one "Line Out", one "Speaker" and one
> "Headphone", and there are only two DACs, two outputs will share a DAC.
> Currently any mixer on such a DAC will get the "PCM" name, which is
> misleading. Instead use "Headphone+LO" or "Speaker+LO" to better
> specify what the volume actually controls.

Are there any examples ?

seem there are two cases

1) business desktop with internal speaker
2) notebook with dock line out

https://launchpadlibrarian.net/186782123/AlsaInfo.txt

>
