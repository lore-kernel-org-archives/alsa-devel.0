From: Gabriele Mazzotta <gabriele.mzt@gmail.com>
Subject: Re: [PATCH] ALSA: hda - Disable AA-loopback on ALC668
Date: Tue, 20 May 2014 17:59:30 +0200
Message-ID: <1912473.njNymtsN1l@xps13>
References: <1784940.JdFq8Pv96a@xps13> <5132959.uTC67tbQhF@xps13>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ee0-f68.google.com (mail-ee0-f68.google.com [74.125.83.68])
 by alsa0.perex.cz (Postfix) with ESMTP id 9E76C261AF6
 for <alsa-devel@alsa-project.org>; Tue, 20 May 2014 17:59:32 +0200 (CEST)
Received: by mail-ee0-f68.google.com with SMTP id d49so651558eek.7
 for <alsa-devel@alsa-project.org>; Tue, 20 May 2014 08:59:32 -0700 (PDT)
Received: from xps13.localnet ([193.190.253.149])
 by mx.google.com with ESMTPSA id m44sm4824534eep.6.2014.05.20.08.59.31
 for <alsa-devel@alsa-project.org>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 20 May 2014 08:59:31 -0700 (PDT)
In-Reply-To: <5132959.uTC67tbQhF@xps13>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thursday 15 May 2014 21:56:23, Gabriele Mazzotta <gabriele.mzt@gmail.com> 
wrote:
> On Wednesday 14 May 2014 16:31:13, Gabriele Mazzotta 
<gabriele.mzt@gmail.com> wrote:
> I'm sorry, I was wrong. This patch does not help. I'm still trying to
> understand what temporarily fixed the problem, I was quite sure this patch 
did
> it, but all of the sudden the noise came back. I'm still trying to find the
> real cause, but I doubt I'll succeed.
> 
> Regards,
> Gabriele
I have to correct myself again, the first patch I submitted is working, I'm 
sorry. However, it seems that disabling the AA-loopback path is not necessary, 
muting the input 0x0b in node 0x0c (as it was suggested here: 
https://bugs.launchpad.net/ubuntu/+source/alsa-driver/+bug/1252733/comments/26) is enough to get rid of the white noise.

What is the proper way to fix this problem?

Regards,

Gabriele
