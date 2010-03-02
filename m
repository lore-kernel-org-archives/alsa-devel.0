From: Jarkko Nikula <jhnikula@gmail.com>
Subject: Re: [RFC 3/4] OMAP3: McBSP: Add interface for transmit
 FIFO state query
Date: Tue, 2 Mar 2010 16:06:15 +0200
Message-ID: <20100302160615.51cfbd64.jhnikula@gmail.com>
References: <1267537191-25254-1-git-send-email-peter.ujfalusi@nokia.com>
	<1267537191-25254-4-git-send-email-peter.ujfalusi@nokia.com>
	<1267537920.24345.7.camel@eenurkka-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ey-out-1920.google.com (ey-out-1920.google.com [74.125.78.148])
	by alsa0.perex.cz (Postfix) with ESMTP id 954951038E8
	for <alsa-devel@alsa-project.org>; Tue,  2 Mar 2010 15:05:27 +0100 (CET)
Received: by ey-out-1920.google.com with SMTP id 26so73723eyw.16
	for <alsa-devel@alsa-project.org>; Tue, 02 Mar 2010 06:05:27 -0800 (PST)
In-Reply-To: <1267537920.24345.7.camel@eenurkka-desktop>
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

On Tue, 02 Mar 2010 15:52:00 +0200
Eero Nurkkala <ext-eero.nurkkala@nokia.com> wrote:

> Reading the XBUFFSTAT register is by no means accurate.
> IIRC, it reports the buffer status incorrectly about 1/50 times
> on average (@ 48000khz); with simple math, it may be read during the DMA
> burst. Or is it guaranteed not being read during DMA transfer / have
> you otherwise verified the behavior?
> 
Do you remember how big was this variation? Was it near the burst size
or some arbitrary difference?


-- 
Jarkko
