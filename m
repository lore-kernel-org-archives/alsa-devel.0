From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: [PATCH 2/4] pcm: rate: add rewindable and
 forwardable callbacks
Date: Fri, 13 Jun 2014 15:46:35 +0600
Message-ID: <539AC87B.5090005@gmail.com>
References: <1402569264-2789-1-git-send-email-patrakov@gmail.com>
 <1402569264-2789-3-git-send-email-patrakov@gmail.com>
 <539AA4B0.2050005@perex.cz> <539AB9D2.6080504@gmail.com>
 <539AC235.3050400@perex.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-lb0-f171.google.com (mail-lb0-f171.google.com
 [209.85.217.171])
 by alsa0.perex.cz (Postfix) with ESMTP id C28762618F2
 for <alsa-devel@alsa-project.org>; Fri, 13 Jun 2014 11:46:37 +0200 (CEST)
Received: by mail-lb0-f171.google.com with SMTP id s7so1198450lbd.30
 for <alsa-devel@alsa-project.org>; Fri, 13 Jun 2014 02:46:37 -0700 (PDT)
In-Reply-To: <539AC235.3050400@perex.cz>
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
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

13.06.2014 15:19, Jaroslav Kysela wrote:
> I see, I agree that the current code is/was tricky and probably broken
> as you noted.
>
> But along with your patch, the code in rewind/forward callbacks should
> be also removed. I put yours and this patch to the alsa-lib repository:
>
> http://git.alsa-project.org/?p=alsa-lib.git;a=commit;h=5256e150eb34cf599e79839feaff7398ed67a499

Thanks, that's indeed a logical step.

-- 
Alexander E. Patrakov
