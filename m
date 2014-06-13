From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: pcm: Add missing callbacks that cannot be NULL
Date: Fri, 13 Jun 2014 09:14:55 +0200
Message-ID: <539AA4EF.7000001@perex.cz>
References: <1402569264-2789-1-git-send-email-patrakov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
 by alsa0.perex.cz (Postfix) with ESMTP id EEB0F26171D
 for <alsa-devel@alsa-project.org>; Fri, 13 Jun 2014 09:14:55 +0200 (CEST)
In-Reply-To: <1402569264-2789-1-git-send-email-patrakov@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Alexander E. Patrakov" <patrakov@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Date 12.6.2014 12:34, Alexander E. Patrakov wrote:
> Some plugins don't implement some mandatory fast_ops. Thus, these
> fast_ops get defaulted to NULL, and programs crash when calling the
> corresponding snd_pcm_* functions.
> 
> The following callbacks were missing:
> 
> file: htimestamp
> multi: rewindable, forwardable
> null: rewindable, forwardable

I applied above three patches. Thanks.

> rate: rewindable, forwardable

A comment sent.

                                        Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project; Red Hat, Inc.
