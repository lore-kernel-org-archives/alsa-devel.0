From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Handle large period size end-of-stream situation
Date: Thu, 04 Apr 2013 19:08:45 +0200
Message-ID: <515DB39D.1070506@ladisch.de>
References: <515C459A.5070209@codeaurora.org> <515D1122.9020502@gmail.com>
 <515D477F.9010406@ladisch.de> <515D97B6.1080701@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id C9B3B265ED6
 for <alsa-devel@alsa-project.org>; Thu,  4 Apr 2013 19:08:52 +0200 (CEST)
In-Reply-To: <515D97B6.1080701@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Gabriel M. Beddingfield" <gabrbedd@gmail.com>
Cc: Patrick Lai <plai@codeaurora.org>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Gabriel M. Beddingfield wrote:
> So, if the hardware can detect it then the hardware needs to signal an interrupt for the XRUN.

The hardware typically doesn't know the application pointer.

> Another option... from userspace you can call SYNC_PTR (e.g.
> pcm_get_htimestamp() in tinyalsa) to update the hw and application
> pointers, then inspect them to detect when all the data is transferred.
> When you see all is played, immediately stop the stream.

ALSA checks for xruns before returning the pointer.  It's enough to just
ask for the pointer (or the state).


Regards,
Clemens
