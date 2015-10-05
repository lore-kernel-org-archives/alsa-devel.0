From: maillist@superlative.org
Subject: Re: Boss GT-001
Date: Mon, 05 Oct 2015 15:46:33 +0100
Message-ID: <1837042.8ri5iYFGVx@kamdesktop>
References: <1481883.Y22cmGKEIB@kamdesktop> <2448573.QHGoo2Q6JJ@kamdesktop>
 <alpine.DEB.2.02.1510051635560.19610@lnxricardw1.se.axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f181.google.com (mail-wi0-f181.google.com
 [209.85.212.181])
 by alsa0.perex.cz (Postfix) with ESMTP id C72B726065F
 for <alsa-devel@alsa-project.org>; Mon,  5 Oct 2015 16:46:35 +0200 (CEST)
Received: by wicge5 with SMTP id ge5so124203527wic.0
 for <alsa-devel@alsa-project.org>; Mon, 05 Oct 2015 07:46:35 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.02.1510051635560.19610@lnxricardw1.se.axis.com>
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
Cc: Ricard Wanderlof <ricard.wanderlof@axis.com>
List-Id: alsa-devel@alsa-project.org

On Monday 05 Oct 2015 16:38:55 Ricard Wanderlof wrote:
error code -5. Is there any reference anywhere for what these errors are?
> 
> -5 would be an ordinary -E<foo> error code, looking in
> /usr/include/asm-generic/errno-base.h (ultimately from the kernel's
> uapi/asm-generic/errno-base.h) it would seem to be EIO (I/O error). Note
> too informative, but at least it'll stem from some 'return -EIO' or
> similar somewhere in the code. Must be some underlying function that is
> having problems.

Ah, OK, that would explain why I couldn't grep it in the alsa codebase.

Cheers,

Keith
