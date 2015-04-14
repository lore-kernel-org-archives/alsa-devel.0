From: "Johannes Lorenz" <johannes89@mailueberfall.de>
Subject: Re: parallel, real time safe waiting?
Date: Tue, 14 Apr 2015 22:03:36 +0200
Message-ID: <trinity-f5deb6ac-8715-451e-b150-bfd93a6537ea-1429041816217@3capp-gmx-bs67>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A47AD26527F
 for <alsa-devel@alsa-project.org>; Tue, 14 Apr 2015 22:03:36 +0200 (CEST)
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

> Of course.  Not only does this page say so:
> http://www.alsa-project.org/main/index.php/SMP_Design

Ah, I read this, but that's probably just if two threads would share one handle:

  "The use of returned handles must be serialized in the application using own locking scheme."

One more question: You said snd_pcm_wait() was real time safe. I guess that's also true for similar functions, like snd_pcm_htimestamp(), snd_pcm_readi(), ..., correct?
