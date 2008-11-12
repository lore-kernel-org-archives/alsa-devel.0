From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: maximum tolerable sampling frequency difference
 for a	driver
Date: Wed, 12 Nov 2008 16:35:44 +0100
Message-ID: <491AF7D0.40806@ladisch.de>
References: <cabda6420811110817u42eafc74wfde36de113c98df1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out5.smtp.messagingengine.com (out5.smtp.messagingengine.com
	[66.111.4.29]) by alsa0.perex.cz (Postfix) with ESMTP id A8D1F24499
	for <alsa-devel@alsa-project.org>; Wed, 12 Nov 2008 16:35:34 +0100 (CET)
In-Reply-To: <cabda6420811110817u42eafc74wfde36de113c98df1@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: chri <chripell@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

chri wrote:
> Let's say that the driver cannot set the exact sampling frequency
> asked via hwparms ...

This never happens.

The driver tells the ALSA framework what frequencies it supports, either
by setting individual bits in the .rates field, or by installing a
constraint by calling snd_pcm_hw_constraint_list() or some other of the
constraint functions when the device is opened.  ALSA then makes sure
that the driver always gets values in hw_params that meet these
constraints.

When an application requests a frequency that is not supported by the
device, it is the application that must decide whether the actual
frequency is acceptable.


HTH
Clemens
