From: fmoraes74@netzero.net
Subject: Re: Emu10k1x driver
Date: Fri, 14 May 2004 17:02:07 GMT
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040514.100218.20413.200910@webmail21.nyc.untd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: tiwai@suse.de
Cc: fmoraes74@netzero.com, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


> i noticed that you set the irq mask IPR_CH_0_LOOP|IPR_CH_0_HALF_LOOP.
> does it mean that the chip generates interrupts twice per buffer?
> if yes, what we need is to limit the number of periods to 2.

The hardware can generate an interrupt at the beginning or the period (ptr = 0) and the middle of the period (halfway through the buffer). I didn't much time trying to understand all the internals of ALSA, so I submitted what worked. This latest version has alsaplayer working and the pcm test in alsa-lib.

I've two channels playback but the third one cannot be heard (there seems to be no mixer control for it), so we probably need the specs to figure that one out.

> the attached patch includes some fixes by me for the latest cvs, and
> changes the periods to 2.  I'll apply it to cvs now.

Thanks,

Francisco


________________________________________________________________
The best thing to hit the Internet in years - NetZero HiSpeed!
Surf the Web up to FIVE TIMES FASTER!
Only $14.95/ month -visit www.netzero.com to sign up today!


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
