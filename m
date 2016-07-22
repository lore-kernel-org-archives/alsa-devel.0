From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: M-Audio Fast track problem
Date: Fri, 22 Jul 2016 14:44:11 +0200
Message-ID: <f6c5384c-695c-1ea2-8ce4-a7ca0189dce0@ladisch.de>
References: <e1010d1f-8265-7a29-2c49-279a6fceab9f@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 67B92265D6A
 for <alsa-devel@alsa-project.org>; Fri, 22 Jul 2016 14:44:11 +0200 (CEST)
Received: from [10.1.2.4] (unknown [94.101.37.79])
 by dehamd003.servertools24.de (Postfix) with ESMTPSA id A2E5CF520300
 for <alsa-devel@alsa-project.org>; Fri, 22 Jul 2016 14:44:10 +0200 (CEST)
In-Reply-To: <e1010d1f-8265-7a29-2c49-279a6fceab9f@free.fr>
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

Yann Collette wrote:
> I've got a M-Audio fast track.
>
> If I open alsamixer and select the fast track sound card, alsamixer just displays the message
>
> "This device has no command"

The actual message is "This sound device does not have any controls."
(Apparently, the translation is somewhat off.)

> Is it a bug or a normal behavior ?

It were a bug only if that device actually had some control.


Regards,
Clemens
