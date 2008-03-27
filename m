From: Daniel Mack <daniel@caiaq.de>
Subject: Re: ALSA driver for Native Instruments sound hardware
Date: Thu, 27 Mar 2008 08:43:46 +0800
Message-ID: <6129CBC3-C9C2-4635-A71E-200C73CB0964@caiaq.de>
References: 20070326161003.GB20122@ipxXXXXX <47E3B2F4.502@freemail.gr>
	<B0A4798E-638E-450B-A810-A966271FCD25@caiaq.de>
	<47EA8D7D.8090807@freemail.gr>
Mime-Version: 1.0 (Apple Message framework v919.2)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from buzzloop.caiaq.de (buzzloop.caiaq.de [212.112.241.133])
	by alsa0.perex.cz (Postfix) with ESMTP id 85D8F2417E
	for <alsa-devel@alsa-project.org>; Thu, 27 Mar 2008 01:43:57 +0100 (CET)
In-Reply-To: <47EA8D7D.8090807@freemail.gr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: kyr <corali@freemail.gr>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

On Mar 27, 2008, at 1:53 AM, kyr wrote:
> There is a xwax user with the audio8dj interface but he has some  
> trouble to get it work well with xwax.
> The device is working almost well with plughw:1,0,0 for the first  
> channel and plughw:1,0,1 for the second one.
> But with very high latency.

There was an update to the driver some weeks ago which allows setting  
a lot smaller buffers for the driver. Please install kernel version  
2.6.24 or manually cherry-pick commit 09189ac79dd7f and report again.

Thanks and best regards,
Daniel
