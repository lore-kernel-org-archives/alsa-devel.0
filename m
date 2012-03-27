From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: M-audio fasttrack pro, input device index
Date: Tue, 27 Mar 2012 14:56:18 +0200
Message-ID: <4F71B8F2.9020800@ladisch.de>
References: <4F7160E4.8030506@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 388DB24B1F
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Mar 2012 14:52:57 +0200 (CEST)
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 2023620817
	for <alsa-devel@alsa-project.org>; Tue, 27 Mar 2012 08:52:56 -0400 (EDT)
In-Reply-To: <4F7160E4.8030506@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: David Henningsson <david.henningsson@canonical.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

David Henningsson wrote:
> M-Audio fasttrack pro has two stereo outputs and one stereo input.

It has two stereo inputs, analog and digital, one of which is disabled
depending on the device_setup module parameter.

> It looks like the input sometimes shows up at device 0 and sometimes at
> device 1.

This looks like a side effect of that hack.


Regards,
Clemens
