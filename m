From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Re: [Alsa-user] AD1985 full-duplex(?)
Date: Mon, 27 Sep 2004 16:14:56 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200409272014.i8RKEu2i019062@localhost.localdomain>
References: <4157B56F.9000905@pg.gda.pl>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Mon, 27 Sep 2004 08:38:39 +0200."
             <4157B56F.9000905@pg.gda.pl>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: =?UTF-8?B?QWRhbSBUbGHFgmth?= <atlka@pg.gda.pl>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>> no, thats not the type of wrapping that matters. suppose the h/w
>> buffer is 4096 frames in size. suppose that a rogue PCI driver or
>> device prevents receipt of an interrupt for an entire buffer's worth
>> of time, maybe even longer. looking at the value of the h/w ptr by
>> itself doesn't tell you anything about whether there is an xrun. you
>> have to constantly monitor the *expected* time of the next interrupt
>> along with the *expected* position of the h/w ptr in order to
>> establish if there was an xrun or not (at least for the class of xruns
>> caused by this kind of delay).
>NO NO NO - look at the OSS man page. GETOPTR call returns also bytes 
>value which represents a number of bytes processed since opening the 
>device. So I can easily detect xruns just by comparing two returned
>bytes values - a previous and a current one. There is also a blocks 
>value which represents number of fragments transitions (hw periods 
>transfers) since the previous call to this ioctl - reset to 0 after each 
>call. I am not monitoring hw-ptr difference but count of data processed 
>be a device. 

you're simply wrong about this. if an interrupt is blocked for longer
than the buffer size, GETOPTR can't help you.


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
