From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: How to mix two PCM channels with ALSA
Date: Thu, 06 Dec 2012 19:05:27 +0100
Message-ID: <50C0DE67.1000000@ladisch.de>
References: <loom.20121206T132219-620@post.gmane.org>
 <50C0AA5F.1040503@ladisch.de> <loom.20121206T171348-66@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com
 [66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id 3C282261710
 for <alsa-devel@alsa-project.org>; Thu,  6 Dec 2012 19:05:53 +0100 (CET)
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
 by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 5BCDC2067D
 for <alsa-devel@alsa-project.org>; Thu,  6 Dec 2012 13:05:52 -0500 (EST)
Received: from [192.168.42.56] (unknown [46.115.36.32])
 by mail.messagingengine.com (Postfix) with ESMTPA id CB38D4827CE
 for <alsa-devel@alsa-project.org>; Thu,  6 Dec 2012 13:05:51 -0500 (EST)
In-Reply-To: <loom.20121206T171348-66@post.gmane.org>
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
> I'd like to know how is performed with the ALSA API.
>
> playSound(buffer1);
> playSound(buffer2);
>
> is it implicitly mixed when playing two buffers by hardware?

Yes, if the hardware actually support this (nowadays, none does), or if
ALSA is configured to use software mixing through dmix or PulseAudio
(which are enabled by default in most distributions).


Regards,
Clemens
