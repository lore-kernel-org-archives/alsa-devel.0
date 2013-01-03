From: Alexander Nestorov <alexandernst@gmail.com>
Subject: [Tiny6410/Mini6410] Sound support
Date: Thu, 3 Jan 2013 18:34:55 +0100
Message-ID: <CACuz9s22EWa8EO0tBHyzPFktuSMCfmwW0Bdnb3qfwC7NuPhO_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oa0-f43.google.com (mail-oa0-f43.google.com
 [209.85.219.43])
 by alsa0.perex.cz (Postfix) with ESMTP id 3D325261655
 for <alsa-devel@alsa-project.org>; Thu,  3 Jan 2013 18:35:39 +0100 (CET)
Received: by mail-oa0-f43.google.com with SMTP id k1so14206037oag.2
 for <alsa-devel@alsa-project.org>; Thu, 03 Jan 2013 09:35:38 -0800 (PST)
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
Cc: sbkim73@samsung.com, kgene.kim@samsung.com
List-Id: alsa-devel@alsa-project.org

I'm working on a Tiny6410 device (S3C6410) on top of a 3.7 kernel and sound
isn't working with the default settings.
I also wasn't able to make it work enablig the related stuff to AC97 in
menuconfig so I'm wondering if there is actually
any support for this device?

Looking at the code in sound/soc, there is something for the SMDK6410 but
I'm not really sure if that's compatible with
my device or even if that code is fully functional.

Can I get some help with this, please? I'll appreciate any kind of help.

Regards

PS: I'm including Kukjin Kim and Sangbeom Kim as of recomendation of
<broonie> from #alsa-soc at Freenode

-- 
alexandernst
