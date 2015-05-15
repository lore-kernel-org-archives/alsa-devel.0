From: sylvain.bertrand@gmail.com
Subject: Re: USB-Audio.conf routing and dmix
Date: Fri, 15 May 2015 13:16:01 +0000
Message-ID: <20150515131601.GA482@freedom>
References: <20150509002017.GB18945@freedom>
 <CAN8cciYjn2r4J0BCFQ8LdJbbH6tDrdcd48Qyzx2ARo=WQGkcKg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f177.google.com (mail-wi0-f177.google.com
 [209.85.212.177])
 by alsa0.perex.cz (Postfix) with ESMTP id 024372664F7
 for <alsa-devel@alsa-project.org>; Fri, 15 May 2015 15:16:04 +0200 (CEST)
Received: by wibt6 with SMTP id t6so57717781wib.0
 for <alsa-devel@alsa-project.org>; Fri, 15 May 2015 06:16:03 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAN8cciYjn2r4J0BCFQ8LdJbbH6tDrdcd48Qyzx2ARo=WQGkcKg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

My USB audio does work fine. The only thing: apps cannot output at the same
time 5.1 on that device.  (stereo goes through dmix by default so it's fine). 

Why does alsa-lib limit dmix/plug usage to stereo only? Is there a good reason?

-- 
Sylvain
