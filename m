From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [RFC 3/4] OMAP3: McBSP: Add interface for transmit
 FIFO state query
Date: Wed, 3 Mar 2010 09:03:24 +0200
Message-ID: <20100303090324.83d076b6.jhnikula@gmail.com>
References: <1267537191-25254-1-git-send-email-peter.ujfalusi@nokia.com>
	<1267537191-25254-4-git-send-email-peter.ujfalusi@nokia.com>
	<1267537920.24345.7.camel@eenurkka-desktop>
	<20100302160615.51cfbd64.jhnikula@gmail.com>
	<1267596472.24345.16.camel@eenurkka-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f216.google.com (mail-ew0-f216.google.com
	[209.85.219.216])
	by alsa0.perex.cz (Postfix) with ESMTP id 2BCA210381A
	for <alsa-devel@alsa-project.org>; Wed,  3 Mar 2010 08:02:34 +0100 (CET)
Received: by ewy8 with SMTP id 8so2181223ewy.32
	for <alsa-devel@alsa-project.org>; Tue, 02 Mar 2010 23:02:33 -0800 (PST)
In-Reply-To: <1267596472.24345.16.camel@eenurkka-desktop>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext-eero.nurkkala@nokia.com
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, 03 Mar 2010 08:07:52 +0200
Eero Nurkkala <ext-eero.nurkkala@nokia.com> wrote:

> Mostly the samples were good (49/50, @48khz, 2 channels, value polled
> from userpace), but the remaining 1/50 were garbage - and actually
> matched the probability of a simultaneous DMA burst. So the problem is -
> if you read at time t0, and the DMA burst is taking place at the same
> time - you get a value that looks rather random, as when (if) you poll
> the position @ t0 + n uS, the value is (after some usecs) a lot
> different. Or maybe the XBUFFSTAT just isn't reliable at all (regardless
> of DMA bursts etc).
> 
Yeah, that's interesting to find out are the XBUFFSTAT reading
differences inside the DMA burst size or distributed completely
randomly. I think the XBUFFSTAT should increase at the sample rate and
decrease or jump down fast when the DMA burst takes place.


-- 
Jarkko
