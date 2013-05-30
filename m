From: Anisse Astier <anisse@astier.eu>
Subject: Re: [PATCH] hda_analyzer: don't fail to display audio
 selector if caps variables aren't available
Date: Thu, 30 May 2013 14:37:58 +0200
Message-ID: <20130530143758.0c174743@serenity>
References: <1369916047-27642-1-git-send-email-anisse@astier.eu>
 <51A745A7.5020403@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-we0-f196.google.com (mail-we0-f196.google.com
 [74.125.82.196])
 by alsa0.perex.cz (Postfix) with ESMTP id E4DB226517C
 for <alsa-devel@alsa-project.org>; Thu, 30 May 2013 14:38:40 +0200 (CEST)
Received: by mail-we0-f196.google.com with SMTP id w62so56642wes.11
 for <alsa-devel@alsa-project.org>; Thu, 30 May 2013 05:38:40 -0700 (PDT)
In-Reply-To: <51A745A7.5020403@perex.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 30 May 2013 14:27:19 +0200, Jaroslav Kysela <perex@perex.cz> wrote :

> Date 30.5.2013 14:14, Anisse Astier wrote:
> > In particular, when an audio selector node has Amp-In caps: N/A, it
> > allows to still interact with the selector, and not have TypeError traceback
> > throwns because of NoneType variables.
> 
> When ofs is None, the steps are not defined, too. I fixed it in:
> 
> http://git.alsa-project.org/?p=alsa.git;a=commitdiff;h=5bcf62d6947fe348a2b055bce633df1d12ff4370
> 

Awesome, thanks.

Anisse
