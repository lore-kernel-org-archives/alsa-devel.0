From: GitHub pull_request - opened <github@alsa-project.org>
Subject: alsa-utils: axfer: add manuals
Date: Wed,  5 Dec 2018 22:46:40 +0100 (CET)
Message-ID: <20181205214640.D1508267C4D@alsa0.perex.cz>
References: <1544046398697707891-webhooks-bot@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webhooks-bot.alsa-project.org (master.perex-int.cz
 [192.168.100.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D64B267BA8
 for <alsa-devel@alsa-project.org>; Wed,  5 Dec 2018 22:46:38 +0100 (CET)
In-Reply-To: <1544046398697707891-webhooks-bot@alsa-project.org>
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

alsa-project/alsa-utils pull request #6 was opened from takaswie:

alsa-utils: axfer: add manuals

This patchset adds manuals. As a result, users can refer to documents
by man(1):

```
 $ man 1 axfer
 $ man 1 axfer-list
 $ man 1 axfer-transfer
```

The manuals are written according to groff_man(7) and man-pages(7),
however in some points they don't follow the guideline; e.g. usage
of hyphen-minus ('-') without backslash '\' in pre-formatted text.
I'll welcome any fixes.

In this time, description of each backend in transfer subcommand is
not yet added. It will be added in later work.

```
Takashi Sakamoto (5):
  axfer: add a manual for entry point
  axfer: add a manual for list subcommand
  axfer: add a manual for transfer subcommand
  axfer: add a section to describe compatibility to aplay(1)
  axfer: add a section about design of transfer subcommand

 axfer/Makefile.am      |  10 +
 axfer/axfer-list.1     |  86 +++++++
 axfer/axfer-transfer.1 | 500 +++++++++++++++++++++++++++++++++++++++++
 axfer/axfer.1          | 132 +++++++++++
 4 files changed, 728 insertions(+)
 create mode 100644 axfer/axfer-list.1
 create mode 100644 axfer/axfer-transfer.1
 create mode 100644 axfer/axfer.1
```

Request URL   : https://github.com/alsa-project/alsa-utils/pull/6
Patch URL     : https://github.com/alsa-project/alsa-utils/pull/6.patch
Repository URL: https://github.com/alsa-project/alsa-utils
