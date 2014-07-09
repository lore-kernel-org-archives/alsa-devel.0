From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH - alsa-utils 5/5] The amidicat program
 itself, better late than never
Date: Wed, 09 Jul 2014 09:54:10 +0200
Message-ID: <53BCF522.2080609@ladisch.de>
References: <1404118503-22921-1-git-send-email-alsa@krellan.com>
 <1404118503-22921-6-git-send-email-alsa@krellan.com>
 <1404863718.378573458@f135.i.mail.ru> <53BCD277.3040908@krellan.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 128E2261B31
 for <alsa-devel@alsa-project.org>; Wed,  9 Jul 2014 09:54:13 +0200 (CEST)
In-Reply-To: <53BCD277.3040908@krellan.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Josh Lehan <alsa@krellan.com>, Sergey <sergemp@mail.ru>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Josh Lehan wrote:
> Somehow, the aseqdump program overcomes this limitation, though!  I need
> to figure out how it does that.  I think it has something to do with how
> the connection is made: simultaneously acting as both a direct
> connection and a subscription connection at the same time.

Have a look at how aseqdump decides what PORT_CAP bits to set.

> Also, what about ALSA permissions that amidicat itself advertises?  To
> make a long story short, I think I have this backwards.

These bits specify what _other_ clients can do with the port.

> Multiple copies of aseqdump can be
> ran at the same time, and everything still works (ALSA correctly
> multiplexes the output of vkeybd to all interested subscribers).
>
> However, this doesn't work for amidicat, and that's a bug.  When
> amidicat is running, ALSA blocks delivery of vkeybd events to the
> aseqdump clients.  When amidicat exits, this blockage clears, and all
> the blocked events are suddenly delivered to aseqdump (that's why you
> get the flood of output in aseqdump when amidicat exits).  Obviously,
> amidicat is doing something wrong, and confusing ALSA.

Does the thread actually read the delivered events from the kernel
buffer?

> Also, try "amidicat --list", which will give you output similar to
> "aplaymidi -l" but include more devices (unlike aplaymidi, amidicat does
> no filtering, it shows you everything, even including itself in the list).

It should list only those ports it can use, i.e., connect from/to.


Regards,
Clemens
