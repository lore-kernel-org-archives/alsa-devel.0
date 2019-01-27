From: GitHub pull_request - opened <github@alsa-project.org>
Subject: [PATCH 0/7] alsa-utils: axfer: misc fixes for manual
Date: Sun, 27 Jan 2019 10:08:12 +0100 (CET)
Message-ID: <20190127090812.DC54E26745A@alsa0.perex.cz>
References: <1548580090951561928-webhooks-bot@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webhooks-bot.alsa-project.org (master.perex-int.cz
 [192.168.100.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 03AFD266AA9
 for <alsa-devel@alsa-project.org>; Sun, 27 Jan 2019 10:08:11 +0100 (CET)
In-Reply-To: <1548580090951561928-webhooks-bot@alsa-project.org>
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

alsa-project/alsa-utils pull request #12 was opened from takaswie:

Hi,

This patchset includes fixes for the manual of axfer and add an entry to README in the end.

```
Takashi Sakamoto (7):
  axfer: add a section about unit test
  axfer: fulfill section for backward compatibitity for chmap option
  axfer: correct description about snoop mode of libffado
  axfer: correct message to notice that help text is implemented
  axfer: supplement value of options for the manual of transfer
    subcommand
  axfer: correct invalid usage of escape of itaric text
  axfer: add an entry of axfer to README

 README.md              |  1 +
 axfer/axfer-transfer.1 | 74 ++++++++++++++++++++++++++++--------------
 axfer/axfer.1          |  7 ++++
 3 files changed, 58 insertions(+), 24 deletions(-)
```

Request URL   : https://github.com/alsa-project/alsa-utils/pull/12
Patch URL     : https://github.com/alsa-project/alsa-utils/pull/12.patch
Repository URL: https://github.com/alsa-project/alsa-utils
