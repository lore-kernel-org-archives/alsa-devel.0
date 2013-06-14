From: Rajan Vaja <rajan.vaja@sibridgetech.com>
Subject: [ALSA] Codec Registration after soc_probe ()
Date: Fri, 14 Jun 2013 19:13:56 +0530
Message-ID: <CAApRLV08C+44YHdxd6CbW_VjMw3GhSh=6eaELX7ATJbYbWwirg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f42.google.com (mail-bk0-f42.google.com
 [209.85.214.42])
 by alsa0.perex.cz (Postfix) with ESMTP id 91488261AF2
 for <alsa-devel@alsa-project.org>; Fri, 14 Jun 2013 15:44:17 +0200 (CEST)
Received: by mail-bk0-f42.google.com with SMTP id jk13so283917bkc.29
 for <alsa-devel@alsa-project.org>; Fri, 14 Jun 2013 06:44:17 -0700 (PDT)
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

My codec is registered after SOC init is done (sdp4430_init()). In soc
init, ALSA cannot find codec registered (given in SOC dai) and hence it
defers sound card registration. Later on codec is registered successfully
but sound card registration is not done again. Is there any way to register
codec later?

I am using kernel version 3.4.0 with OMAP Panda.

Thanks,
Rajan
