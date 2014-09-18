From: Dominik Haumann <dhaumann@kde.org>
Subject: Re: Alsa Driver Scarlett
Date: Thu, 18 Sep 2014 18:07:46 +0200
Message-ID: <2132843.alxgI3GY82@eriador>
References: <54148F1B.2010608@gmail.com> <20140916161002.714e7667@sampi>
 <541AD01B.30101@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f181.google.com (mail-lb0-f181.google.com
 [209.85.217.181])
 by alsa0.perex.cz (Postfix) with ESMTP id 49573261ADE
 for <alsa-devel@alsa-project.org>; Thu, 18 Sep 2014 18:08:44 +0200 (CEST)
Received: by mail-lb0-f181.google.com with SMTP id z11so1435661lbi.26
 for <alsa-devel@alsa-project.org>; Thu, 18 Sep 2014 09:08:43 -0700 (PDT)
Received: from eriador.localnet (drms-4d0d98ba.pool.mediaWays.net.
 [77.13.152.186])
 by mx.google.com with ESMTPSA id as5sm7014031lac.46.2014.09.18.09.08.42
 for <alsa-devel@alsa-project.org>
 (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
 Thu, 18 Sep 2014 09:08:42 -0700 (PDT)
In-Reply-To: <541AD01B.30101@canonical.com>
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

Hi,

> > Orm Finnendahl <orm.finnendahl@selma.hfmdk-frankfurt.de> wrote:
> >> Am Dienstag, den 16. September 2014 um 15:22:27 Uhr (+0200) schrieb 
Johannes Kroll:
> >>> I guess I'll need to find the time to port the patch to a recent kernel
> >>> when I upgrade, unless someone else does it first.
> >> 
> >> The patch still works on our recent kernels (we are on debian testing
> >> with a 3.14-2 kernel), atm there is no porting necessary. I can also
> >> confirm that the driver has no known issues on our systems (we use a
> >> couple of Scarlett 18i20 in different configurations). It would be
> >> great, though if the patch could get integrated into alsa. At the
> >> moment it is quite painful for our students with linux laptops as they
> >> have to reapply the patch on every upgrade.
> > 
> > Oh, I see. I'm all for integrating this patch into mainline. But I have
> > never done such a thing, so I don't know how much effort it would be. I
> > guess it would be a simple thing to do for a routine Alsa developer.
> > Anyone? :]

just joined this mailing list yesterday for exactly the same reason: Bought an 
Focusrite Scarlett 6i6, and while it works with jack, it doesn't show up in 
the alsa mixer. As I understand, this patch should also work better for the 
6i6, so I'd also very much appreciate getting this patch into the kernel.

If you need a tester for the 6i6 device, I'd happily try a patch.

Greetings,
Dominik
