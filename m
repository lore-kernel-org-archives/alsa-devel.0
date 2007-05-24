From: "Ash Willis" <ashwillis@programmer.net>
Subject: Re: [PATCH] Add support for Cyrix/NatSemi Geode CS5530
 (VSA1)
Date: Thu, 24 May 2007 14:27:11 -0500
Message-ID: <20070524192711.C45281BF258@ws1-1.us4.outblaze.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webmail-outgoing.us4.outblaze.com
	(webmail-outgoing.us4.outblaze.com [205.158.62.67])
	by alsa0.perex.cz (Postfix) with ESMTP id A65C224355
	for <alsa-devel@alsa-project.org>;
	Thu, 24 May 2007 21:39:42 +0200 (CEST)
Received: from unknown (unknown [192.168.8.90])
	by webmail-outgoing.us4.outblaze.com (Postfix) with QMQP id
	5A8E01800D94
	for <alsa-devel@alsa-project.org>; Thu, 24 May 2007 19:40:01 +0000 (GMT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

> Thanks.  Now committed to HG tree.
> 
> One more possible fix is about the build of snd-sb16-dsp and dependent
> modules.  We don't need snd-sb16 itself.
> 
> Could you try the patch below (both for alsa-driver and alsa-kernel)?
> It introduces the intermediate configs for snd-sb16-dsp, snd-sb8-dsp
> and snd-sb-common modules.
> 

Yeah, that makes more sense...and it works fine.

Thanks,
Ash

=
