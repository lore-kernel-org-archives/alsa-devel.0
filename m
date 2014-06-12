From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: pcm: Add missing callbacks that cannot be NULL
Date: Thu, 12 Jun 2014 16:34:20 +0600
Message-ID: <1402569264-2789-1-git-send-email-patrakov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-la0-f50.google.com (mail-la0-f50.google.com
 [209.85.215.50])
 by alsa0.perex.cz (Postfix) with ESMTP id 6D1BE264F8D
 for <alsa-devel@alsa-project.org>; Thu, 12 Jun 2014 12:34:43 +0200 (CEST)
Received: by mail-la0-f50.google.com with SMTP id b8so567418lan.37
 for <alsa-devel@alsa-project.org>; Thu, 12 Jun 2014 03:34:41 -0700 (PDT)
Received: from localhost.localdomain (111279190.convex.ru. [82.193.153.141])
 by mx.google.com with ESMTPSA id b6sm24054791laa.20.2014.06.12.03.34.40
 for <alsa-devel@alsa-project.org>
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Thu, 12 Jun 2014 03:34:40 -0700 (PDT)
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

Some plugins don't implement some mandatory fast_ops. Thus, these
fast_ops get defaulted to NULL, and programs crash when calling the
corresponding snd_pcm_* functions.

The following callbacks were missing:

file: htimestamp
multi: rewindable, forwardable
null: rewindable, forwardable
rate: rewindable, forwardable

After this series, all required callbacks are present, but I cannot
guarantee that they return meaningful values.

All patches in this series are only compile-tested.


-- 
Alexander E. Patrakov
