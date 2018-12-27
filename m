From: Ricardo Biehl Pasquali <pasqualirb@gmail.com>
Subject: Coherence of status structure after SYNC_PTR
Date: Thu, 27 Dec 2018 15:22:24 -0200
Message-ID: <20181227172224.GA18933@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com
 [209.85.222.170])
 by alsa0.perex.cz (Postfix) with ESMTP id 09ED4267AC8
 for <alsa-devel@alsa-project.org>; Thu, 27 Dec 2018 18:22:31 +0100 (CET)
Received: by mail-qk1-f170.google.com with SMTP id q8so11202557qke.1
 for <alsa-devel@alsa-project.org>; Thu, 27 Dec 2018 09:22:31 -0800 (PST)
Received: from localhost.localdomain ([187.183.221.211])
 by smtp.gmail.com with ESMTPSA id f13sm12714306qkm.52.2018.12.27.09.22.28
 for <alsa-devel@alsa-project.org>
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Thu, 27 Dec 2018 09:22:29 -0800 (PST)
Content-Disposition: inline
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

In alsa-lib, pcm_hw, htimestamp(), avail is rechecked to
ensure a valid timestamp.

I guess this is for the case when status is mmaped, when
hardware pointer is read, an interrupt occur, and timestamp
is read.

Does SYNC_PTR ioctl always fill a coherent status?

Cheers!

	pasquali
