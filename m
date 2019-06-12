From: Michael Forney <mforney@mforney.org>
Subject: [PATCH 0/6] alsa-lib: Various portability fixes
Date: Tue, 11 Jun 2019 23:08:08 -0700
Message-ID: <20190612060814.13534-1-mforney@mforney.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 2EA7BF80791
 for <alsa-devel@alsa-project.org>; Wed, 12 Jun 2019 08:08:18 +0200 (CEST)
Received: by mail-pg1-x544.google.com with SMTP id f25so8308394pgv.10
 for <alsa-devel@alsa-project.org>; Tue, 11 Jun 2019 23:08:18 -0700 (PDT)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Even though alsa-lib doesn't aim for ISO C conformance, hopefully these
changes are uncontroversial enough to be considered anyway.

Michael Forney (6):
  Use __func__ instead of __FUNCTION__
  List cases in range explicitly
  Don't return in a void function
  Make sure parameter qualifiers match between declaration and
    definition
  Remove unused empty struct
  Avoid pointer arithmetic on `void *`

 aserver/aserver.c    |  4 ++--
 include/error.h      |  8 ++++----
 include/local.h      |  4 ++--
 src/conf.c           | 22 ++++++++++++----------
 src/pcm/pcm.c        | 16 ++++++++--------
 src/pcm/pcm_direct.h |  2 --
 src/pcm/pcm_hw.c     |  2 +-
 src/pcm/pcm_rate.c   |  8 ++++----
 src/pcm/pcm_share.c  |  4 ++--
 9 files changed, 35 insertions(+), 35 deletions(-)

-- 
2.20.1
