From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 2/2] alsa-lib: bring pcm.h and pcm.c in
 sync with the kernel list
Date: Thu, 28 Mar 2013 10:54:04 +0100
Message-ID: <5154133C.9040703@gmail.com>
References: <1364427144-30036-1-git-send-email-zonque@gmail.com>
 <1364427144-30036-2-git-send-email-zonque@gmail.com>
 <51538493.40309@sonarnerd.net>
 <7.0.0.16.2.20130327213632.13b07718@akdesigninc.com>
 <5153F2FD.50704@sonarnerd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f47.google.com (mail-bk0-f47.google.com
 [209.85.214.47])
 by alsa0.perex.cz (Postfix) with ESMTP id 7BAFE2652B8
 for <alsa-devel@alsa-project.org>; Thu, 28 Mar 2013 10:54:17 +0100 (CET)
Received: by mail-bk0-f47.google.com with SMTP id ik5so1953155bkc.34
 for <alsa-devel@alsa-project.org>; Thu, 28 Mar 2013 02:54:17 -0700 (PDT)
In-Reply-To: <5153F2FD.50704@sonarnerd.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jussi Laako <jussi@sonarnerd.net>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, clemens@ladisch.de, demian@auraliti.com, ray@auraliti.com, Andreas Koch <andreas@akdesigninc.com>
List-Id: alsa-devel@alsa-project.org

On 28.03.2013 08:36, Jussi Laako wrote:
> Either way, application will have to be able to reshuffle the bits for 
> the other format.

If you share your implementation to do that, it could eventually also
move into the 'plug' plugin in userspace, so conversion is done on the
fly as needed.


Daniel
