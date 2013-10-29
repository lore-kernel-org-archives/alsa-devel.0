From: Chen Guangyu-B42378 <B42378@freescale.com>
Subject: Re: [PATCH] ASoC: fsl_ssi: separately enable and
 disable TIE/RIE in trigger()
Date: Tue, 29 Oct 2013 13:16:52 +0000
Message-ID: <df3ajlgpavhroiiray67at4q.1383052621653@email.android.com>
References: <1383044688-28596-1-git-send-email-b42378@freescale.com>
 <526FA330.3080209@tabi.org> <20131029115711.GA9605@MrMyself>
 <526FA78D.2090601@tabi.org>
 <20131029121330.GB9605@MrMyself>,<526FACC1.7010909@tabi.org>
 <50y5h8hi19x5t2r9jhjrk097.1383051600782@email.android.com>,
 <526FB499.5090506@tabi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe005.messaging.microsoft.com [207.46.163.28])
 by alsa0.perex.cz (Postfix) with ESMTP id 23A27261B1B
 for <alsa-devel@alsa-project.org>; Tue, 29 Oct 2013 14:17:53 +0100 (CET)
In-Reply-To: <526FB499.5090506@tabi.org>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@tabi.org>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@kernel.org" <broonie@kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: alsa-devel@alsa-project.org

As you wish, sir.

Sent by Android device.

Timur Tabi <timur@tabi.org> wrote:


Chen Guangyu-B42378 wrote:
> I mean there is a possibility.
>
>   I'm sorry if my patch is kinda annoying and it really bother you, sir. I also want to make things better.

It does not bother me.  I'm glad people are working on my driver.  I
just want to make sure that my driver does not get bloated.

>
> If you really don't like it, we can drop it. It's all your call.

I think this patch should be dropped, because I don't see any real
reason for it.
