From: Joachim Blaabjerg <styx@gentoo.org>
Subject: Re: VIA8233/8235 testers wanted
Date: Fri, 10 Jan 2003 11:09:32 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200301101109.32329.styx@gentoo.org>
References: <s5h7kde8dfm.wl@alsa2.suse.de> <200301101013.58151.styx@gentoo.org> <s5hznq973t7.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hznq973t7.wl@alsa2.suse.de>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Friday 10 January 2003 10:27, you wrote:
> there are small bugs regarding the calculation of hw-pointer.
> i hope now this choppy sounds fixed.  could you try to grab via82xx.c
> again from the same url?

Yes, works great! Everything I use my card for works 100% now, for the first 
time I can remember. On my previous box, I had an Aureal card that didn't 
really have any good drivers either. 

> also, there is the secondary pcm device (hw:0,1) for the multi-channel
> playback, i.e. 4 and 6-channel playback.  if your board has rear or
> center/lfe jacks, please give a try.
> i guess this is exclusive with the first device, but not sure.  please
> check whether both twos can play at the same time.

Unfortunately, my board hasn't got that (to my knowledge).

> ah, one more thing.  via8235 has the secondary capture device.  it's
> assigned to hw:0,1.  it would be helpful if you can check both hw:0,0
> and hw:0,1 can capture properly, or whether only one of them works.

I'll check this out if I can get my hands on a proper microphone. I guess I 
could try that headphone trick, but I'd rather try getting a mic first. In a 
couple of days, perhaps?

Regards,


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
