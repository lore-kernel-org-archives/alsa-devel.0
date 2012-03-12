From: Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH 2/2] ASoC: DAPM - Make sure DAPM widget IO
 ops hold the component mutex.
Date: Mon, 12 Mar 2012 17:12:08 +0800
Message-ID: <20120312091206.GA19513@S2101-09.ap.freescale.net>
References: <1331057779-4630-1-git-send-email-lrg@ti.com>
	<1331057779-4630-2-git-send-email-lrg@ti.com>
	<CAOZdJXUy-hCOEk6beBrjv16iknsMWTHc+AxSyw-L8-hLEXQYSw@mail.gmail.com>
	<1331316853.3789.4.camel@odin> <4F5A55DE.8020609@freescale.com>
	<20120311125558.GG3233@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 5BAA524348
	for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2012 10:11:58 +0100 (CET)
Received: by iakh37 with SMTP id h37so7236411iak.38
	for <alsa-devel@alsa-project.org>; Mon, 12 Mar 2012 02:11:56 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20120311125558.GG3233@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Timur Tabi <b04825@freescale.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Sun, Mar 11, 2012 at 12:55:59PM +0000, Mark Brown wrote:
> On Fri, Mar 09, 2012 at 01:11:26PM -0600, Timur Tabi wrote:
> > Liam Girdwood wrote:
> 
> > > Can you switch on the mutex debugging kernel config here.  I've just had
> > > a quick look and the WM8776 and its not holding the codec mutex or
> > > calling snd_soc_update_bits_locked() so it must deadlock via another
> > > path.
> 
> > Enabling the debug options didn't reveal anything, unfortunately.
> 
> The major difference between your two boards is that CS4270 doesn't use
> DAPM while WM8776 does.  Though if one of them were going to break I'd
> really expect it to be the CS4270, obviously non-DAPM CODECs are a real
> corner case (to the point where I think you're the only active user of
> such a device) and certainly all Liam's TI reference systems have DAPM
> CODECs so this is really surprising...  I wonder if PowerPC mutexes are
> less forgiving here?

I'm not sure this is PowerPC specific.  I'm running ARM platform and
seeing this commit also breaks my imx-sgtl5000 (SGTL5000 codec) driver
that I'm submitting.

=============================================
[ INFO: possible recursive locking detected ]
3.3.0-rc4+ #159 Not tainted
---------------------------------------------
aplay/395 is trying to acquire lock:
 (&codec->mutex){+.+...}, at: [<802f7414>] soc_widget_update_bits_locked+0x88/0x
1a0

but task is already holding lock:
 (&codec->mutex){+.+...}, at: [<802f9df4>] snd_soc_dapm_stream_event+0x38/0xc0

-- 
Regards,
Shawn
