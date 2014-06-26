From: Sinan Akman <sinan@writeme.com>
Subject: Re: Wandboard Quad - SPDIF issue, no sound
Date: Thu, 26 Jun 2014 15:07:57 -0400
Message-ID: <53AC6F8D.6020101@writeme.com>
References: <53A86CC5.2060204@dewberryfields.co.uk>
 <53A90D98.3050000@writeme.com> <53A991F4.9070905@dewberryfields.co.uk>
 <53AA0E8E.6030508@writeme.com> <53AAD9D3.2000107@dewberryfields.co.uk>
 <53AC2E59.1030601@dewberryfields.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from walmailout07.yourhostingaccount.com
 (mailout07.yourhostingaccount.com [65.254.254.77])
 by alsa0.perex.cz (Postfix) with ESMTP id 96053265122
 for <alsa-devel@alsa-project.org>; Thu, 26 Jun 2014 21:08:01 +0200 (CEST)
Received: from mailscan14.yourhostingaccount.com ([10.1.15.14]
 helo=walmailscan14.yourhostingaccount.com)
 by walmailout07.yourhostingaccount.com with esmtp (Exim)
 id 1X0F1c-0001xZ-L4
 for alsa-devel@alsa-project.org; Thu, 26 Jun 2014 15:08:00 -0400
In-Reply-To: <53AC2E59.1030601@dewberryfields.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Michael Howard <mike@dewberryfields.co.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


   Hi Mike, I just saw this after I sent my other e-mail.

> The volatges match the spec sheets, i.e. 5v for the Cubietruck and 3.3v
> for the Wandboard at VCC whether audio is playing or not.

   Yes, this might be the issue.

> So unless both my receivers have a problem with only 3.3v I'm at a loss.
> I can't find anything on the limited specs for the receivers relating to
> this.

   I think you can just test your receiver(s) with another 3.3v source
and if you see the same problem then they probably need 5v levels.

> I guess I'll just sideline the Wandboards and use proper kit instead.

   If it turns out that the voltage level is really the problem and
you need to use those receivers I guess this would be the case. I
am not electrical but you might be able to build a small adaptor to
change the voltage levels on the spdif output. This would be another
solution.

   Regards

   Sinan Akman
