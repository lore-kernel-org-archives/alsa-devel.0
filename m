From: "Chris Caudle" <chris@chriscaudle.org>
Subject: Getting started with new driver
Date: Sat, 9 Dec 2017 12:04:43 -0600
Message-ID: <d6783a01b45a018f65d1404ce812f1d6.squirrel@email.powweb.com>
Reply-To: chris@chriscaudle.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from walmailout09.yourhostingaccount.com
 (walmailout09.yourhostingaccount.com [65.254.253.73])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C4B4266E4B
 for <alsa-devel@alsa-project.org>; Sat,  9 Dec 2017 19:04:49 +0100 (CET)
Received: from walmailscan15.yourhostingaccount.com ([10.1.15.15]
 helo=walmailscan15.yourhostingaccount.com)
 by walmailout09.yourhostingaccount.com with esmtp (Exim)
 id 1eNjUV-0004K8-Td
 for alsa-devel@alsa-project.org; Sat, 09 Dec 2017 13:04:47 -0500
Received: from [10.114.3.33] (helo=walimpout13)
 by walmailscan15.yourhostingaccount.com with esmtp (Exim)
 id 1eNjUV-0004W7-9i
 for alsa-devel@alsa-project.org; Sat, 09 Dec 2017 13:04:47 -0500
Received: from [127.0.0.1] (helo=email.powweb.com)
 by walwebmail04.yourhostingaccount.com with esmtp (Exim)
 id 1eNjUR-0006Ke-Jr
 for alsa-devel@alsa-project.org; Sat, 09 Dec 2017 13:04:43 -0500
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

I am helping review a new network audio driver that is being developed as
an ALSA virtual sound card.
The developer is experienced in programming, but not much in interacting
with open source development.
I am out of practice in programming, but would like to help with community
interaction, so need some advice on getting started submitting a new
driver for review.

My first assumption is that since ALSA has been part of the kernel tree
for quite a while all the code should match the kernel style guide
(basically K&R style).  Is that correct?

There is some cleanup to do there, as well as some cleanup to match some
recent kernel API changes (e.g. is currently using tasklet timers, but I
think those are pulled out now so will need to switch to softirq timers).

Once I can help get the style and API usage cleaned up, how should a new
driver be submitted for review?  It is currently in a semi-private tree on
bitbucket.org. A series of patches as email?  One big email that contains
all of the driver source?  Some other way?  The alsa-project.org page
doesn't really have a "getting started on a new driver for newbies" page
that I could find.

thanks,
Chris Caudle
