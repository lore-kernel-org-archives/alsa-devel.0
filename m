From: GitHub pull_request - opened <github@alsa-project.org>
Subject: [PATCH] axfer: allow to be compiled with glibc-2.11 or
	former
Date: Sun, 27 Jan 2019 09:59:38 +0100 (CET)
Message-ID: <20190127085938.199C626745A@alsa0.perex.cz>
References: <1548579576131805897-webhooks-bot@alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webhooks-bot.alsa-project.org (master.perex-int.cz
 [192.168.100.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 620B1266AA9
 for <alsa-devel@alsa-project.org>; Sun, 27 Jan 2019 09:59:36 +0100 (CET)
In-Reply-To: <1548579576131805897-webhooks-bot@alsa-project.org>
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

alsa-project/alsa-utils pull request #11 was opened from takaswie:

The program, axfer, was developed in userspace with glibc-2.28. This
userspace is mostly compliant to POSIX:2008 and some additional macros
for poll event are officially available. The glibc supports them as a
default since its v2.12 release. It will be failed to be compiled with
old glibc or the other libraries for C standard APIs.

One of the purpose of axfer is an better alternative of aplay. In a
point of the purpose, it's preferable to be compiled with the old
libraries.

This commit adds conditional macros to be compiled with libraries for
old compliance level of POSIX. This fixes #9 .

Request URL   : https://github.com/alsa-project/alsa-utils/pull/11
Patch URL     : https://github.com/alsa-project/alsa-utils/pull/11.patch
Repository URL: https://github.com/alsa-project/alsa-utils
