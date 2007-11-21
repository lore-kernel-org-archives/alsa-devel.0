From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Broken playback
Date: Wed, 21 Nov 2007 12:36:02 +0100
Message-ID: <1195644962.10939.1222529331@webmail.messagingengine.com>
References: <BLU107-W438E9F5D7EFEF18ED543BDC1780@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 2089824BF5
	for <alsa-devel@alsa-project.org>; Wed, 21 Nov 2007 12:36:04 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <BLU107-W438E9F5D7EFEF18ED543BDC1780@phx.gbl>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Gabriele Melia <gabmelia84@msn.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Gabriele Melia wrote:
> How I can delay the palyback in order to accumulate some decoded buffers

You have to read and decode some data before you start playing.
Alternatively, you could play some silence before the first decoded data,
but this would desynchronize the audio and video streams.


HTH
Clemens
