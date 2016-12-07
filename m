From: Joseph Wang <joequant@gmail.com>
Subject: Re: Cherry trail and Nau 88l24 codec
Date: Wed, 7 Dec 2016 04:21:47 -0500
Message-ID: <CAPoeEY_QV8inYz=rAf5sveTtB5636sNwGyy0Uf==mPWuq0DZPg@mail.gmail.com>
References: <CAPoeEY_Tve2TAgBqY+MqPEUGnbadYHg9Z90DQ=YQumWebfW++A@mail.gmail.com>
 <62e35b1dac6b4000beb73d857f780f04@NTHCML01B.nuvoton.com>
 <CAPoeEY8=A949-cuVwfyov2GfpQc=hAjPsDG-suXmT_TDytOKBQ@mail.gmail.com>
 <30f62f0d-1e3e-0839-8d85-df9e209b5cf9@linux.intel.com>
 <CAPoeEY98GP9VCQLPKSL0sUo3TDcgxHf65wCbR=T95wyJz2Ai7Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qt0-f194.google.com (mail-qt0-f194.google.com
 [209.85.216.194])
 by alsa0.perex.cz (Postfix) with ESMTP id AF789267172
 for <alsa-devel@alsa-project.org>; Wed,  7 Dec 2016 10:21:49 +0100 (CET)
Received: by mail-qt0-f194.google.com with SMTP id m48so43693900qta.2
 for <alsa-devel@alsa-project.org>; Wed, 07 Dec 2016 01:21:49 -0800 (PST)
In-Reply-To: <CAPoeEY98GP9VCQLPKSL0sUo3TDcgxHf65wCbR=T95wyJz2Ai7Q@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc: CTLIN0@nuvoton.com, alsa-devel@alsa-project.org, KCHSU0@nuvoton.com
List-Id: alsa-devel@alsa-project.org

Two new items:

1) The firmware time outs happen when I try to turn on all of the switches
in alsa mixer and set the volumes and gains of everything to 100%,  It
doesn't like that.

2) In pulseaudio, I'm only seeing the output device "Headphones".  Not sure
where this is getting set.

But it looks like things are working up until the mixer, and it's a matter
of finding the right magic configurations for those.
