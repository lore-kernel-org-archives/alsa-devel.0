From: GitHub issues - edited <github@alsa-project.org>
Subject: axfer: FTBFS of axfer with glibc-2.11 or before due to
 missing definition of POLLRDNORM
Date: Fri, 11 Jan 2019 01:24:11 +0100 (CET)
Message-ID: <20190111002411.A44EC2675CD@alsa0.perex.cz>
References: <1547166249956650019-webhooks-bot@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webhooks-bot.alsa-project.org (master.perex-int.cz
 [192.168.100.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 269DD2674DE
 for <alsa-devel@alsa-project.org>; Fri, 11 Jan 2019 01:24:10 +0100 (CET)
In-Reply-To: <1547166249956650019-webhooks-bot@alsa-project.org>
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

alsa-project/alsa-utils issue #9 was edited from takaswie:

Reported by Jay Foster in alsa-devel list.
http://mailman.alsa-project.org/pipermail/alsa-devel/2019-January/144024.html

The v1.1.8 release brings FTBFS of axfer in his legacy toolchain (glibc v2.9)
for arm platform, due to missing definition `POLLRDNORM` and the others, used in
`axfer/waiter-select.c`. An option of  `-D_GNU_SOURCE` for CFLAGS can suppress
the issue. With glibc v2.22, no issues.

During development period of axfer, this issue has never been got. More recent
version of glibc (v2.28) was used and the macro is available without any explicit
options.

Issue URL     : https://github.com/alsa-project/alsa-utils/issues/9
Repository URL: https://github.com/alsa-project/alsa-utils
