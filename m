From: Liam Girdwood <lrg@slimlogic.co.uk>
Subject: Re: [RFC 3/4] OMAP3: McBSP: Add interface for transmit
 FIFO state query
Date: Tue, 02 Mar 2010 13:58:04 +0000
Message-ID: <1267538284.3201.15.camel@odin>
References: <1267537191-25254-1-git-send-email-peter.ujfalusi@nokia.com>
	<1267537191-25254-4-git-send-email-peter.ujfalusi@nokia.com>
	<1267537920.24345.7.camel@eenurkka-desktop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f220.google.com (mail-fx0-f220.google.com
	[209.85.220.220])
	by alsa0.perex.cz (Postfix) with ESMTP id 2FFE11038E3
	for <alsa-devel@alsa-project.org>; Tue,  2 Mar 2010 14:58:06 +0100 (CET)
Received: by fxm20 with SMTP id 20so722453fxm.32
	for <alsa-devel@alsa-project.org>; Tue, 02 Mar 2010 05:58:05 -0800 (PST)
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
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "Ujfalusi Peter (Nokia-D/Tampere)" <peter.ujfalusi@nokia.com>
List-Id: alsa-devel@alsa-project.org

On Tue, 2010-03-02 at 15:52 +0200, Eero Nurkkala wrote:
> On Tue, 2010-03-02 at 14:39 +0100, Ujfalusi Peter (Nokia-D/Tampere)
> wrote:
> > New function for reading the XBUFFSTAT register, which holds
> > the fill state of the transmit buffer on McBSP.
> > 
> > Signed-off-by: Peter Ujfalusi <peter.ujfalusi@nokia.com>
> > ---
> 
> Reading the XBUFFSTAT register is by no means accurate.
> IIRC, it reports the buffer status incorrectly about 1/50 times
> on average (@ 48000khz); with simple math, it may be read during the DMA
> burst. Or is it guaranteed not being read during DMA transfer / have
> you otherwise verified the behavior?

I agree, I've also seen XBUFFSTAT giving complete garbage with mcbsp3.

Liam 

-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
