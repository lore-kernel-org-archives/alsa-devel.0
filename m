From: Kevin Groeneveld <kgroeneveld@gmail.com>
Subject: Re: alsa-lib 1.0.27 incorrect definition of
	__kernel_off_t?
Date: Tue, 23 Jul 2013 10:58:24 -0400
Message-ID: <CABF+-6WWOAJzH1KX9474tBE6apFhfsZx_cg97pY37cVFtKRukQ@mail.gmail.com>
References: <CABF+-6UXCFt5Oq0yiOkrfiN3kxWtae8zbOkqrdTFmDMm3h07Pw@mail.gmail.com>
 <51EE7D4F.6040204@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f172.google.com (mail-we0-f172.google.com
 [74.125.82.172])
 by alsa0.perex.cz (Postfix) with ESMTP id 31F97264FEE
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2013 16:58:28 +0200 (CEST)
Received: by mail-we0-f172.google.com with SMTP id t61so2271724wes.31
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2013 07:58:24 -0700 (PDT)
In-Reply-To: <51EE7D4F.6040204@perex.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jul 23, 2013 at 8:55 AM, Jaroslav Kysela <perex@perex.cz> wrote:

> I tried to fix this issue using <linux/types.h>. Please, check:
>
>
> http://git.alsa-project.org/?p=alsa-lib.git;a=commitdiff;h=b3b53a1bec47aaa2baef724cc9e79adadd603caf
>
>
Yes, that patch fixes the compile error I was getting.  Thanks for looking
into this.

You don't actually need to include <linux/types.h> in local.h.  local.h
includes asound.h which already includes <linux/types.h>.  This is how I
just got away with deleting the #define __kernel_off_t line.


Kevin
