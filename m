From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: X-Fi Titanium S/PDIF output sample rate
Date: Mon, 07 Mar 2011 18:05:07 +0100
Message-ID: <4D751043.4060303@ladisch.de>
References: <4D75089A.3020609@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 39AA9244D0
	for <alsa-devel@alsa-project.org>; Mon,  7 Mar 2011 18:03:43 +0100 (CET)
In-Reply-To: <4D75089A.3020609@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "S. Christian Collins" <s.chriscollins@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

S. Christian Collins wrote:
> I'm looking for a way to change the S/PDIF output sample rate on the
> X-Fi to 48 KHz.

All I/Os run at the same frequency, the master sample rate.

Creative has implemented only a subset of the hardware's features in
the Linux driver, but this setting is available, if only as module
parameters; see "modinfo snd-ctxfi".


Regards,
Clemens
