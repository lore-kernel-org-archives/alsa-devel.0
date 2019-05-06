From: GitHub pull_request - opened <github@alsa-project.org>
Subject: alsa-utils: axfer/test: fix compiler warnings due to
 uninitialized return value
Date: Mon,  6 May 2019 23:01:10 +0200 (CEST)
Message-ID: <20190506210110.85150F896F0@alsa1.perex.cz>
References: <1557176467691142082-webhooks-bot@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webhooks-bot.alsa-project.org (gate.perex.cz [77.48.224.242])
 by alsa1.perex.cz (Postfix) with ESMTP id 64EF5F80C07
 for <alsa-devel@alsa-project.org>; Mon,  6 May 2019 23:01:08 +0200 (CEST)
In-Reply-To: <1557176467691142082-webhooks-bot@alsa-project.org>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

alsa-project/alsa-utils pull request #18 was opened from takaswie:

Hi,

One of test programs for axfer internals has bugs to let compiler generate warnings due to uninitialized return value. This patchset fixes them.

```
Takashi Sakamoto (2):
  axfer/test: fix uninitialized warning
  axfer/test: fix uninitialized warning

 axfer/test/mapper-test.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)
```

Request URL   : https://github.com/alsa-project/alsa-utils/pull/18
Patch URL     : https://github.com/alsa-project/alsa-utils/pull/18.patch
Repository URL: https://github.com/alsa-project/alsa-utils
