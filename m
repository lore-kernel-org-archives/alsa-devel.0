From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: hw_ptr_interrupt removal broke interrupt pointer
 updates
Date: Wed, 27 Jan 2010 15:12:56 +0100
Message-ID: <4B6049E8.5000401@ladisch.de>
References: <4B5EF09B.3040900@ladisch.de>
	<alpine.LNX.2.00.1001261713430.6542@eeebox2.perex-int.cz>
	<4B600C3E.6090208@ladisch.de>
	<alpine.LNX.2.00.1001271057160.6542@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 332811038E6
	for <alsa-devel@alsa-project.org>; Wed, 27 Jan 2010 15:12:59 +0100 (CET)
In-Reply-To: <alpine.LNX.2.00.1001271057160.6542@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> On Wed, 27 Jan 2010, Clemens Ladisch wrote:
> > A somewhat unrelated issue:  Both old and new code assume that
> > hw_ptr==0 is a period boundary, but that is not true if the boundary
> > is not an integer multiple of the period size, and the pointer wraps.
> > I'm not sure what happens then.
> 
> I'm not exactly sure what you're talking about. Where is the
> hw_ptr==0 assumption?

This code, which tries to align hw_ptr_interrupt to a period boundary:

	runtime->hw_ptr_interrupt = new_hw_ptr -
			(new_hw_ptr % runtime->period_size);


Best regards,
Clemens
