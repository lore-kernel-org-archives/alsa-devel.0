From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [RFC 3/4] OMAP3: McBSP: Add interface for transmit
 FIFO state query
Date: Wed, 3 Mar 2010 16:18:42 +0200
Message-ID: <20100303161842.7b82ea8c.jhnikula@gmail.com>
References: <1267537191-25254-1-git-send-email-peter.ujfalusi@nokia.com>
	<1267596472.24345.16.camel@eenurkka-desktop>
	<20100303090324.83d076b6.jhnikula@gmail.com>
	<201003031202.48598.peter.ujfalusi@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.149])
	by alsa0.perex.cz (Postfix) with ESMTP id DBACF1037F8
	for <alsa-devel@alsa-project.org>; Wed,  3 Mar 2010 15:17:54 +0100 (CET)
Received: by ey-out-1920.google.com with SMTP id 26so277950eyw.16
	for <alsa-devel@alsa-project.org>; Wed, 03 Mar 2010 06:17:54 -0800 (PST)
In-Reply-To: <201003031202.48598.peter.ujfalusi@nokia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "Nurkkala Eero.An (EXT-Offcode/Oulu)" <ext-Eero.Nurkkala@nokia.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Wed, 3 Mar 2010 12:02:48 +0200
Peter Ujfalusi <peter.ujfalusi@nokia.com> wrote:

> The command for test:
> aplay -fdat -d 1 /dev/urandom
> 
I recommend to use /dev/zero instead since urandom takes CPU time.

> [   96.290924] XBUFFSTAT: 0
> [   96.293487] XBUFFSTAT: 0
> [   96.296020] XBUFFSTAT: 0
> [   96.299774] XBUFFSTAT: 1
> 
> So the buffer is kept full in element mode, as it is expected.
> 
I was expecting to see more variations. IRCC, the DMA in OMAP is doing
transfers over the memory bus using some small bursts but I'm not
completely sure. I'm thinking if that could explain the Eero's and
Liam's observations?

> So according to XBUFSTAT we have played out 289 samples.
> based on the time we actually played 288.528 samples.
> 
> I would say this is really close to what we would expect to have?
> 
Sounds accurate enough.

> Note: I have used printk for these, which pretty much alters the behavior a bit 
> in timing wise...
> 
BTW: There is OMAP3 port in LTTng.


-- 
Jarkko
