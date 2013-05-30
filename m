From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: [PATCH] hda_analyzer: don't fail to display audio
 selector if caps variables aren't available
Date: Thu, 30 May 2013 14:27:19 +0200
Message-ID: <51A745A7.5020403@perex.cz>
References: <1369916047-27642-1-git-send-email-anisse@astier.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C218265150
 for <alsa-devel@alsa-project.org>; Thu, 30 May 2013 14:27:21 +0200 (CEST)
In-Reply-To: <1369916047-27642-1-git-send-email-anisse@astier.eu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anisse Astier <anisse@astier.eu>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Date 30.5.2013 14:14, Anisse Astier wrote:
> In particular, when an audio selector node has Amp-In caps: N/A, it
> allows to still interact with the selector, and not have TypeError traceback
> throwns because of NoneType variables.

When ofs is None, the steps are not defined, too. I fixed it in:

http://git.alsa-project.org/?p=alsa.git;a=commitdiff;h=5bcf62d6947fe348a2b055bce633df1d12ff4370

Thank you for this report.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
