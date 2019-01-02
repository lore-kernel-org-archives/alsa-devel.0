From: GitHub pull_request - opened <github@alsa-project.org>
Subject: [PATCH 0/8] alsa-utils: axfer: fulfill help texts and
 manual sections for each of xfer backend
Date: Wed,  2 Jan 2019 04:17:39 +0100 (CET)
Message-ID: <20190102031739.84B14267BE2@alsa0.perex.cz>
References: <1546399056916929007-webhooks-bot@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webhooks-bot.alsa-project.org (master.perex-int.cz
 [192.168.100.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 69EFC267B97
 for <alsa-devel@alsa-project.org>; Wed,  2 Jan 2019 04:17:36 +0100 (CET)
In-Reply-To: <1546399056916929007-webhooks-bot@alsa-project.org>
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

alsa-project/alsa-utils pull request #8 was opened from takaswie:

Hi,

This patchset fulfills help texts and manual sections for each of xfer backend. All of
options are described in this patchset, however I leave a placeholder for scheduling
model of libasound. This section will be fulfilled later.

(I note that this is a first attempt to explain about `slave` and `snoop` options of libffado.)

```
Takashi Sakamoto (8):
  axfer: fix no return statement in print_help() function
  axfer: fix typo in axfer(1) manual
  axfer: correct description about signal handling
  axfer: print help for libffado backend
  axfer: fulfill manual section for libffado backend
  axfer: print help for libasound backend
  axfer: fulfill manual section for libasound backend
  axfer: add text for compatibility loss of sw parameter in libasound backend

 axfer/axfer-transfer.1 | 383 ++++++++++++++++++++++++++++++++++++++++-
 axfer/axfer.1          |   2 +-
 axfer/xfer-libasound.c |  25 ++-
 axfer/xfer-libffado.c  |  11 +-
 axfer/xfer-options.c   |   2 +-
 5 files changed, 414 insertions(+), 9 deletions(-)
```

Request URL   : https://github.com/alsa-project/alsa-utils/pull/8
Patch URL     : https://github.com/alsa-project/alsa-utils/pull/8.patch
Repository URL: https://github.com/alsa-project/alsa-utils
