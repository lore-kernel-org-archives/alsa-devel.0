From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: How to mix two PCM channels with ALSA
Date: Thu, 06 Dec 2012 15:23:27 +0100
Message-ID: <50C0AA5F.1040503@ladisch.de>
References: <loom.20121206T132219-620@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id 9E3202615C7
 for <alsa-devel@alsa-project.org>; Thu,  6 Dec 2012 15:23:29 +0100 (CET)
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
 by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id B0B2920C4E
 for <alsa-devel@alsa-project.org>; Thu,  6 Dec 2012 09:23:28 -0500 (EST)
Received: from [10.1.2.65] (unknown [94.101.37.4])
 by mail.messagingengine.com (Postfix) with ESMTPA id 5137B48275C
 for <alsa-devel@alsa-project.org>; Thu,  6 Dec 2012 09:23:28 -0500 (EST)
In-Reply-To: <loom.20121206T132219-620@post.gmane.org>
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

itxEpsilon wrote:
> I'm trying to write a simple application
> for mixing two PCM sound channels in
> C++. Could anyone provide me a
> quick example about how to implement
> this operation?

  outputSample[i] = inputChannel1[i] + inputChannel2[i];

What does this have to do with ALSA?


Regards,
Clemens
