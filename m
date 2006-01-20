From: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: RFC: OSS driver removal, a slightly different
 approach
Date: Fri, 20 Jan 2006 17:30:40 +0100 (MET)
Message-ID: <Pine.LNX.4.61.0601201729370.10065@yvahk01.tjqt.qr>
References: <20060119174600.GT19398@stusta.de> <200601191947.20748.pzad@pobox.sk>
 <Pine.LNX.4.61.0601201524080.22940@yvahk01.tjqt.qr> <s5hmzhr7xsr.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from linux01.gwdg.de (linux01.gwdg.de [134.76.13.21])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 343D516B
	for <alsa-devel@alsa-project.org>; Fri, 20 Jan 2006 17:30:40 +0100 (MET)
In-Reply-To: <s5hmzhr7xsr.wl%tiwai@suse.de>
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
Cc: Peter Zubaj <pzad@pobox.sk>, alsa-devel@lists.sourceforge.net, Adrian Bunk <bunk@stusta.de>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, perex@suse.cz
List-Id: alsa-devel@alsa-project.org

>> >If I understand alsa - oss emulation correctly, I think, this will be not 
>> >fixed soon (my opinion - never). This is too much work for too little gain.
>> 
>> On that way, I'd like to inquiry something:
>> I have a card that works with the snd-cs46xx module.
>> With the OSS emulation (/dev/dsp), I can only output 2 channels, and the 
>> other two must be sent to /dev/adsp. Is this intended? Would not it be 
>> easier to make /dev/dsp allow receiving an ioctl setting 4 channels?
>
>This is exactly like the case of emu10k1.  The chip supports only
>2-channel stereo streams.  If you need a 4-channel interleaved stream,
>you have to merge the data in two individual streams to a single
>4-channel stream on software.  Currently, this isn't handled in ALSA
>kernel-space OSS emulation.

Ah, so http://alphagate.hopto.org/quad_dsp/ which I had created
is The Right Thing?


Jan Engelhardt
-- 


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
