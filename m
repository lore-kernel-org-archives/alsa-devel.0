From: Alan Horstmann <gineera@aspect135.co.uk>
Subject: Re: SALSA and aplay
Date: Tue, 17 Jul 2007 12:33:36 +0100
Message-ID: <200707171233.36222.gineera@aspect135.co.uk>
References: <200707161340.23503.gineera@aspect135.co.uk>
	<s5hzm1wwmxw.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.talktalk.net (wmsmtp.opaltelecom.net [62.24.128.253])
	by alsa0.perex.cz (Postfix) with ESMTP id 0CF6C1037F3
	for <alsa-devel@alsa-project.org>;
	Tue, 17 Jul 2007 13:12:14 +0200 (CEST)
In-Reply-To: <s5hzm1wwmxw.wl%tiwai@suse.de>
Content-Disposition: inline
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
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

On Monday 16 July 2007 13:30, you wrote:
> At Mon, 16 Jul 2007 13:40:23 +0100,
>
> Alan Horstmann wrote:
> > Quick questions:
> >
> > 1. Does SALSA provide everything needed by aplay?
>
> Most but not everything.  The missing features are:
> - snd_pcm_mmap_read*/write*() (corresponding to -M option)
> - device listing (namehint)

Thanks.  Presumably that explains 'undeclared' error for 'snd_devname_t' and 
'snd_config' when linking aplay code to salsa.  I commented out all 
applicable bits and it is OK.

Can salsa-lib be installed at the same time as alsa-lib?  There seems to be 
conflicts.  For now I have uninstalled and installed alternately.

I have very crudely hacked the aplay code and included it as a function in 
code to make a simple key-press play a set file.  Linking -lasound this seems 
to work fine.  However, linking -lsalsa results in the file playing too fast, 
but not as much as double.

As my experimental system has ice1712 card, I am having to use a 10 track WAV 
file S32_LE as I think that is the only format supported, the card working 
with 24-bits loose fitted in 32-bits.  Is that right?  Is there still 
something that alsa-lib is doing to the data that salsa doesn't?  My example 
wav file was recorded using standard  aplay, and has meaningful sound just on 
the first 4 tracks, which appear correctly in pcm out 1-4 (visible in 
envy24control), at the correct level, just too fast.  The included aplay 
correctly reports

	try3.wav' : Signed 32 bit Little Endian, Rate 44100 Hz, Channels 10

when begining to play.

Can you give any pointers to issues to investigate etc or things to consider?

Alan
