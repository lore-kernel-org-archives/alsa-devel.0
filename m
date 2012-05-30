From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Help requested: new HSS1394 MIDI back-end
Date: Wed, 30 May 2012 06:51:52 +0200
Message-ID: <38538c62-f01e-4743-be92-aea79d61085e@email.android.com>
References: <94aa86f3-5257-402a-a094-f58fccdeb846@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id B1634244D3
	for <alsa-devel@alsa-project.org>;
	Wed, 30 May 2012 06:51:55 +0200 (CEST)
In-Reply-To: <94aa86f3-5257-402a-a094-f58fccdeb846@email.android.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Sean M. Pappalardo - D.J. Pegasus" <spappalardo@mixxx.org>
Cc: alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Sean M. Pappalardo - D.J. Pegasus wrote:
>It works perfectly with the SCS.1m!! The .1d works, but some of 
>the non-standard data it sends appears to be getting corrupted. In 
>particular, the device sends four-byte platter messages that start with
>0xF9 and the remaining three can range from 0x00 to 0xFF.

This is not MIDI. Into what MIDI messages should
the driver convert this?
Is this documented anywhere?


Regards,
Clemens
