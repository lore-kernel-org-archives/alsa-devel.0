From: =?UTF-8?B?QWRhbSBUbGHFgmth?= <atlka@pg.gda.pl>
Subject: Re: Re: [Alsa-user] AD1985 full-duplex(?)
Date: Mon, 27 Sep 2004 08:38:39 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <4157B56F.9000905@pg.gda.pl>
References: <200409270300.i8R30Ro1016070@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200409270300.i8R30Ro1016070@localhost.localdomain>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> no, thats not the type of wrapping that matters. suppose the h/w
> buffer is 4096 frames in size. suppose that a rogue PCI driver or
> device prevents receipt of an interrupt for an entire buffer's worth
> of time, maybe even longer. looking at the value of the h/w ptr by
> itself doesn't tell you anything about whether there is an xrun. you
> have to constantly monitor the *expected* time of the next interrupt
> along with the *expected* position of the h/w ptr in order to
> establish if there was an xrun or not (at least for the class of xruns
> caused by this kind of delay).
NO NO NO - look at the OSS man page. GETOPTR call returns also bytes 
value which represents a number of bytes processed since opening the 
device. So I can easily detect xruns just by comparing two returned
bytes values - a previous and a current one. There is also a blocks 
value which represents number of fragments transitions (hw periods 
transfers) since the previous call to this ioctl - reset to 0 after each 
call. I am not monitoring hw-ptr difference but count of data processed 
be a device. I need hw-ptr only for correct mixing of data but not for 
xrun detection. Anyway if some hw device blocks hw handler of a sound 
card you will not detect xruns without counting interuppts and their 
time in the device driver. This situaction means badly designed system 
or hardware.

> user-space is not in a position to determine this, because the
> interrupt handler is the only place where the value of the h/w ptr can
> be reliably determined (even though on many cards, there are other
> ways and times as well).
I just need to obtain hw_ptr from a device driver in mmapped mode.
If there is a ioctl getting it that is good thing IMHO. In ALSA I must 
maintain my appl_ptr and call snd_pcm_delay or snd_pcm_avail_update and 
then calculate hw_ptr by myself. Of course I must be aware of boundary 
wrap to obtain the correct result.

> ALSA and the entire kernel development team have spent the last 5
> years moving things *out* of kernel space. forget ALSA - you will have
> a very, very hard time explaining to the kernel crew why this is
> actually a good idea.
Hmm, actually from my observation this approach (in lib mixing and 
effects) makes more problems and disadventages then doing this in a 
device manner and as a kernel RT thread. I tried to modify AOSS to use 
callbacks (works almost good but scheduling/swapping effects still 
there) but I found an app which disables SIGIO for example.
So now I in a dead end. I think that ALSA lib approach has serious 
compability limitations which could not be solved.

Regards

-- 
Adam Tla/lka      mailto:atlka@pg.gda.pl    ^v^ ^v^ ^v^
System  & Network Administration Group           ~~~~~~
Computer Center,  Gdansk University of Technology, Poland
PGP public key:   finger atlka@sunrise.pg.gda.pl


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
