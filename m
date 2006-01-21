From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: RFC: OSS driver removal, a slightly different
	approach
Date: Fri, 20 Jan 2006 21:27:10 -0500
Message-ID: <1137810430.3241.97.camel@mindpipe>
References: <20060119174600.GT19398@stusta.de>
	 <200601191947.20748.pzad@pobox.sk>
	 <Pine.LNX.4.61.0601201524080.22940@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from viper.oldcity.dca.net (viper.oldcity.dca.net [216.158.38.4])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id B62B818D
	for <alsa-devel@alsa-project.org>; Sat, 21 Jan 2006 03:27:13 +0100 (MET)
In-Reply-To: <Pine.LNX.4.61.0601201524080.22940@yvahk01.tjqt.qr>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Peter Zubaj <pzad@pobox.sk>, alsa-devel@lists.sourceforge.net, Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

On Fri, 2006-01-20 at 15:25 +0100, Jan Engelhardt wrote:
> >Hi,
> >
> >On Thursday 19 January 2006 18:46, Adrian Bunk wrote:
> >> SOUND_EMU10K1
> >> - ALSA #1735 (OSS emulation 4-channel mode rear channels not working)
> >
> >If I understand alsa - oss emulation correctly, I think, this will be not 
> >fixed soon (my opinion - never). This is too much work for too little gain.
> 
> On that way, I'd like to inquiry something:
> I have a card that works with the snd-cs46xx module.
> With the OSS emulation (/dev/dsp), I can only output 2 channels, and the 
> other two must be sent to /dev/adsp. Is this intended? Would not it be 
> easier to make /dev/dsp allow receiving an ioctl setting 4 channels?
> 

Why can't you just use aoss?

Lee



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
