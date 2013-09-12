From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: USB Audio/ALSA
Date: Thu, 12 Sep 2013 19:57:43 +0200
Message-ID: <52320097.7050309@ladisch.de>
References: <CAOiXha+sn0okoKFN9Q-C0PLmP1EqServFfFLSHsJT-NCq1+z=w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
 [66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 9CA362654D6
 for <alsa-devel@alsa-project.org>; Thu, 12 Sep 2013 19:58:28 +0200 (CEST)
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
 by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id A55CC20E02
 for <alsa-devel@alsa-project.org>; Thu, 12 Sep 2013 13:58:27 -0400 (EDT)
Received: from [192.168.42.193] (unknown [80.187.107.4])
 by mail.messagingengine.com (Postfix) with ESMTPA id EF34BC00E83
 for <alsa-devel@alsa-project.org>; Thu, 12 Sep 2013 13:58:26 -0400 (EDT)
In-Reply-To: <CAOiXha+sn0okoKFN9Q-C0PLmP1EqServFfFLSHsJT-NCq1+z=w@mail.gmail.com>
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

Rajaram R wrote:
> I am trying to bring up Android Accessory Audio

There are lots of bugs in various accessory firmware version; you need
kernel 3.10 or the latest stable kernel on the host for a workaround.

> But when I play song, I see nothing on the bus.  I can see an AOA
> audio device entry in /proc/asound/cards.

The important thing is whether you see an entry with "arecord -l".

> The error i see when I play is "Sorry this player does not support this
> type of audio file android".

Is that on the Android device?  In that case, this has nothing to do
with ALSA.


Regards,
Clemens
