From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: non-blocking mode example
Date: Tue, 15 Aug 2017 14:49:16 +0200
Message-ID: <f811f743-3433-2b1a-f932-677290d5d562@ladisch.de>
References: <86b4d23e-d214-ccbc-33b3-4f7d2de9600f@t-online.de>
 <a9bcf062-f4cf-1466-dbfa-90e67148fb13@ladisch.de>
 <e6600808-5f98-335f-9b58-bce7b15f6c63@t-online.de>
 <693e0d31-9b74-3ccf-e4a5-aac3b94ee4da@ladisch.de>
 <2a3cecc4-730c-208b-0674-68bbbe5d72d4@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 211C7267440
 for <alsa-devel@alsa-project.org>; Tue, 15 Aug 2017 14:49:16 +0200 (CEST)
Received: from [10.1.2.4] (unknown [94.101.37.79])
 by webclient5.webclient5.de (Postfix) with ESMTPSA id 313065581313
 for <alsa-devel@alsa-project.org>; Tue, 15 Aug 2017 14:49:16 +0200 (CEST)
In-Reply-To: <2a3cecc4-730c-208b-0674-68bbbe5d72d4@t-online.de>
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

ThomasJF wrote:
> Now I have a do-while loop with select.

Better use poll(); select() is cumbersome with the ALSA's API.

> To get the tcp-commands for stop/pause:
>
> 1.) Do I have to adapt the tcp-commands inside this loop or...
>
> 2.) Do I have to work with any poll descriptors (which?)

These function allow to wait for multiple file descriptors to become
ready.  So wait for all the fds from the ALSA device _and_ the fd of
the socket.


Regards,
Clemens
