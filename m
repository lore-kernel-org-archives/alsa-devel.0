From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: pcm prepare
Date: Tue, 28 Jul 2015 08:56:43 +0200
Message-ID: <55B727AB.8090902@ladisch.de>
References: <CAAVaN8woRd9Xvp3kE-=8gW-diB4KSWjEw+hU=bfi7cQdBvdQkQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 0316B260459
 for <alsa-devel@alsa-project.org>; Tue, 28 Jul 2015 08:56:44 +0200 (CEST)
In-Reply-To: <CAAVaN8woRd9Xvp3kE-=8gW-diB4KSWjEw+hU=bfi7cQdBvdQkQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andy Ng <andreas2025@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Andy Ng wrote:
> I am quite surprised that by sending hardware params with alsa-lib the
> prepare function is called automatically in the driver.
>
> In my case, I would like to open and configure pcmNp and pcmNc and
> then call prepare for pcmNp and pcmPc channels.
>
> It is quite imperative to execute specific configuration steps after
> both channels are opened and configured.

What configuration steps?  Is there some dependency or shared resource
between the two streams?  In that case, you have to set the
SNDRV_PCM_INFO_JOINT_DUPLEX flag, and do whatever is necessary in the
first hw_params call, and just check for correctness in the later
hw_params call of the other stream.

> I was wondering if there is any ioctl interface that can be hooked in
> alsa-lib to pass extra configuration info before start the streams.

No.


Regards,
Clemens
