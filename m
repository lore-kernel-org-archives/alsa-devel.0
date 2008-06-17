From: Eliot Blennerhassett <linux@audioscience.com>
Subject: Re: What does snd_pcm_delay() actually return?
Date: Tue, 17 Jun 2008 12:53:59 +1200
Message-ID: <48570B27.2090403@audioscience.com>
References: <20080609190225.GA4534@tango.0pointer.de>
	<s5h1w333o7r.wl%tiwai@suse.de>
	<20080612205225.GB20818@tango.0pointer.de>
	<s5hd4mlhlau.wl%tiwai@suse.de>
	<Pine.LNX.4.61.0806130958000.1798@tm8103-a.perex-int.cz>
	<48524882.6050606@superbug.co.uk> <g2tq3q$969$1@ger.gmane.org>
	<Pine.LNX.4.61.0806131453280.1798@tm8103-a.perex-int.cz>
	<20080613144850.GE21255@tango.0pointer.de>
	<Pine.LNX.4.61.0806131654510.1798@tm8103-a.perex-int.cz>
	<s5hprqlqr29.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.clear.net.nz (smtp4.clear.net.nz [203.97.37.64])
	by alsa0.perex.cz (Postfix) with ESMTP id 3964824481
	for <alsa-devel@alsa-project.org>;
	Tue, 17 Jun 2008 02:54:09 +0200 (CEST)
Received: from [192.168.1.4]
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp4.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0K2L00GHG16217P2@smtp4.clear.net.nz> for
	alsa-devel@alsa-project.org; Tue, 17 Jun 2008 12:54:04 +1200 (NZST)
In-reply-to: <s5hprqlqr29.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
  > First off, it's not only about USB but for hardwares that require the
> own h/w queue.  There bunch of such hardwares, and we provide really
> poor support for them.  The above sounds like bandaiding on a bandaid 
> over a bandaid.

Hmm.  This thread will take some digesting...meanwhile here are my (not 
particularly coherent) thoughts from the POV of driver developer for 
cards that have large on-card FIFOs. (asihpi)

The period-based refresh makes it hard to use the fifo effectively.  If 
the card fifo is allowed to 'suck' all the data from the ringbuffer then 
it makes it look like an underrun. Also it makes time appear to run fast 
until the fifo is filled up.

The 'fast time' creates problems for ALSA on playback start, because 
alsa assumes that it will take a whole period for a period of data to be 
consumed, while the driver is capable of consuming multiple periods 
almost instantly.  In my driver I have to throttle the rate that data is 
transferred to the card fifos.

Just as in the network case, where it is desirable to get data across 
the network as early as possible to allow secure playback, we want to 
fill the oncard fifo as early and as much as possible.

Only if both ringbuffer and fifo are empty (playback) or full (record) 
is a true xrun occuring.

Our underlying API returns the following info
* Size of host ringbuffer
* Amount of unread data in host ringbuffer
* Amount of unread data in card fifo
* Frames output at the DAC/input at ADC since stream start
Plus info about granularity and latency of the above info.

I suspect that a byte-stream approach would be a better match to our cards.

regards

Eliot Blennerhassett
