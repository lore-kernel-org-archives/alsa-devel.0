From: John Rigg <ad@sound-man.co.uk>
Subject: Re: Re: [OT] ALSA userspace API complexity
Date: Tue, 10 Jan 2006 01:02:35 +0000
Message-ID: <20060110010235.GA5224__7318.19881261817$1136854399$gmane$org@localhost.localdomain>
References: <20050726150837.GT3160@stusta.de> <200601091405.23939.rene@exactcode.de> <Pine.LNX.4.61.0601091637570.21552@zeus.compusonic.fi> <200601091812.55943.rene@exactcode.de> <Pine.LNX.4.62.0601091355541.4005@qynat.qvtvafvgr.pbz> <20060109232043.GA5013@localhost.localdomain> <Pine.LNX.4.62.0601091515570.4005@qynat.qvtvafvgr.pbz> <20060110001617.GA5154@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail3.uklinux.net (mail3.uklinux.net [80.84.72.33])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 641EE135
	for <alsa-devel@alsa-project.org>; Tue, 10 Jan 2006 01:52:19 +0100 (MET)
Content-Disposition: inline
In-Reply-To: <20060110001617.GA5154@localhost.localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
Cc: John Rigg <ad@sound-man.co.uk>, David Lang <dlang@digitalinsight.com>, =?iso-8859-1?Q?Ren=E9?= Rebe <rene@exactcode.de>, Hannu Savolainen <hannu@opensound.com>, Jaroslav Kysela <perex@suse.cz>, Takashi Iwai <tiwai@suse.de>, linux-sound@vger.kernel.org, ALSA development <alsa-devel@alsa-project.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 10, 2006 at 12:16:17AM +0000, John Rigg wrote:
> On Mon, Jan 09, 2006 at 03:21:21PM -0800, David Lang wrote:
> > does the CPU touch the data for these, or do you DMA directly from 
> > userspace (i.e. "zero-copy")?
> 
> The cards I mentioned use DMA. RME actually advertises that some of their
> cards can handle 52 channels with zero CPU load. Their onboard DSPs can
> also do routing and mixing, again without touching the CPU.

Of course I should also mention that the sound cards deal with PCM audio
samples in integer format, but audio apps like jackd and its clients use
floating point, so in practice the CPU is still processing audio data much
of the time.

John


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
