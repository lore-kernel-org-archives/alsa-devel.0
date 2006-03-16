From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Re: Couple of questions
Date: Thu, 16 Mar 2006 21:08:36 +0000
Message-ID: <1142543316.9236.1.camel@localhost.localdomain>
References: <1142467271.9298.7.camel@localhost.localdomain>
	 <s5hirqer7r5.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sc-outsmtp2.homechoice.co.uk (sc-outsmtp2.homechoice.co.uk [81.1.65.36])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 111AD1B6
	for <alsa-devel@alsa-project.org>; Thu, 16 Mar 2006 22:08:45 +0100 (MET)
In-Reply-To: <s5hirqer7r5.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2006-03-16 at 11:42 +0100, Takashi Iwai wrote:
> At Thu, 16 Mar 2006 00:01:11 +0000,
> Adrian McMenamin wrote:
> > 
> > If my driver declares this:
> > 
> > 	.info = (SNDRV_PCM_INFO_NONINTERLEAVED),
> > 
> > Can I expect samples to come in all left followed by all right, or how?
> 
> Yes.  It's the non-interleaved format (LLLLLLLL....RRRRRR.....).
> 
> > And will cat somefile.wav > /dev/dsp using oss emulation respect that?
> 
> Yes.
> 
> > And what default frequency can I expect cat to use in the above?
> 
> ALSA has no default frequency.  OSS assumes 8kHz for /dev/audio.
> /dev/dsp has no default, IIRC, but practically 44.1kHz.
> 
> So "cat some > /dev/dsp" is not a good way for testing at all...
> It's usable for checking that "something" works at least, but not for
> checking the detailed functionality.


Thanks. My problem is I cannot get the alsa utilities to compile/work
(they compile but seg fault on use). Is there a good OSS only app I can
use to test the basic play stuff?



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
