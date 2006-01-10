From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Re: [OT] ALSA userspace API complexity
Date: Mon, 09 Jan 2006 20:56:21 -0500
Message-ID: <1136858181.2007.26.camel__15198.7382014797$1136858234$gmane$org@mindpipe>
References: <20050726150837.GT3160@stusta.de>
	 <200601091405.23939.rene@exactcode.de>
	 <Pine.LNX.4.61.0601091637570.21552@zeus.compusonic.fi>
	 <200601091812.55943.rene@exactcode.de>
	 <Pine.LNX.4.62.0601091355541.4005@qynat.qvtvafvgr.pbz>
	 <20060109232043.GA5013@localhost.localdomain>
	 <Pine.LNX.4.62.0601091515570.4005@qynat.qvtvafvgr.pbz>
	 <20060110001617.GA5154@localhost.localdomain>
	 <Pine.LNX.4.62.0601091628340.4005@qynat.qvtvafvgr.pbz>
	 <1136853898.12802.21.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mustang.oldcity.dca.net (mustang.oldcity.dca.net [216.158.38.3])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 74D5513D
	for <alsa-devel@alsa-project.org>; Tue, 10 Jan 2006 02:56:24 +0100 (MET)
In-Reply-To: <1136853898.12802.21.camel@localhost.localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David Lang <dlang@digitalinsight.com>, John Rigg <ad@sound-man.co.uk>, =?ISO-8859-1?Q?Ren=E9?= Rebe <rene@exactcode.de>, Hannu Savolainen <hannu@opensound.com>, Jaroslav Kysela <perex@suse.cz>, Takashi Iwai <tiwai@suse.de>, linux-sound@vger.kernel.org, ALSA development <alsa-devel@alsa-project.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 2006-01-10 at 00:44 +0000, Alan Cox wrote:
> On Llu, 2006-01-09 at 16:29 -0800, David Lang wrote:
> > I was under the (apparently mistaken) impression that you couldn't DMA 
> > from userspace (something to do with the possibility that the userspace 
> > memory pages could be swapped out in the middle of the DMA)
> 
> Drivers can choose to support this two different ways. One is to have a
> buffer of kernel memory mapped into user space and shared with the
> hardware (this is how OSS did it), the other is to use the 2.6
> get_user_pages API to get the physical address of a set of pages and
> lock them down so they don't wander off during DMA.
> 
> Both have advantages for different uses.

ALSA would appear to use the first method (get_user_pages does not
appear in the source), presumably because new ALSA versions still
support 2.4 (and 2.2, maybe even 2.0).

Lee



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
