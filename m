From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Re: RFC: OSS driver removal, a
	slightly	different	approach
Date: Fri, 20 Jan 2006 13:14:58 +0000
Message-ID: <1137762898.24161.13.camel@localhost.localdomain>
References: <20060119174600.GT19398@stusta.de>
	 <1137694944.32195.1.camel@mindpipe> <20060119182859.GW19398@stusta.de>
	 <1137696885.32195.12.camel@mindpipe> <s5hk6cw9h07.wl%tiwai@suse.de>
	 <1137697269.32195.14.camel@mindpipe>
	 <1137708573.8471.65.camel@localhost.localdomain>
	 <s5hd5in9p5v.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from gate.perex.cz (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4C4E2156
	for <alsa-devel@alsa-project.org>; Fri, 20 Jan 2006 14:15:02 +0100 (MET)
Received: from lxorguk.ukuu.org.uk (unknown [81.2.110.250])
	by gate.perex.cz (Perex's E-mail Delivery System) with ESMTP id C100899273
	for <alsa-devel@alsa-project.org>; Fri, 20 Jan 2006 14:15:01 +0100 (MET)
In-Reply-To: <s5hd5in9p5v.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Lee Revell <rlrevell@joe-job.com>, Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

On Gwe, 2006-01-20 at 11:20 +0100, Takashi Iwai wrote:
> BTW, I remember that there was a driver for native geode audio support
> at the time of ALSA 0.5.x or earlier.  I must have the code somewhere
> in my storage.  The porting would be much much harder than kaulha (sb 
> emulation), though.

The two drivers cover different versions of the Kahlua firmware. VSA1
was the original (at least AFAIK) firmware block. It provides SB16
emulation but has no hooks for drivers to 'take over' properly as you
really want to hook into SMI. VSA2 (the next gen firmware) had various
changes and differences and Cyrix long ago released a rather icky but
working 'native' driver for that.

I have the Cyrix public and most of the earlier NDA documentation if
there are questions but I can't redistribute it.

Alan



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
