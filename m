From: GitHub pull_request - opened <github@alsa-project.org>
Subject: [PATCH 0/4] alsa-utils: axfer: add help texts
Date: Fri,  7 Dec 2018 10:41:47 +0100 (CET)
Message-ID: <20181207094147.40BB5267CF2@alsa0.perex.cz>
References: <1544175704401844025-webhooks-bot@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webhooks-bot.alsa-project.org (master.perex-int.cz
 [192.168.100.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 85539267CC9
 for <alsa-devel@alsa-project.org>; Fri,  7 Dec 2018 10:41:44 +0100 (CET)
In-Reply-To: <1544175704401844025-webhooks-bot@alsa-project.org>
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

alsa-project/alsa-utils pull request #7 was opened from takaswie:

This patchset adds help texts for command entry, list and transfer
subcommands. In this time, contents for each backend of transfer
subcommand is not added yet.

Unfortunately, execution of aliases (arecord/aplay) can print help text
for command text only. This bug will be fixed in future commits.

Additionally, due to program design, execution of the aliases cannot
print help text of list subcommand. This is unavoidable loss of backward
compatibility.

```
Takashi Sakamoto (4):
  axfer: print help text of command entry
  axfer: print help text of list subcommand
  axfer: print help text of transfer subcommand just for common options
  axfer: enable each backend to print own help

 axfer/main.c           | 12 +++++++++++-
 axfer/subcmd-list.c    |  9 ++++++++-
 axfer/xfer-libasound.c |  6 ++++++
 axfer/xfer-libffado.c  |  6 ++++++
 axfer/xfer-options.c   | 35 +++++++++++++++++++++++++++++++++++
 axfer/xfer.c           |  5 +++++
 axfer/xfer.h           |  2 ++
 7 files changed, 73 insertions(+), 2 deletions(-)
```

Request URL   : https://github.com/alsa-project/alsa-utils/pull/7
Patch URL     : https://github.com/alsa-project/alsa-utils/pull/7.patch
Repository URL: https://github.com/alsa-project/alsa-utils
