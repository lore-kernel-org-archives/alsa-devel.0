From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Re: (Fwd) ALSA related comments - please correct [wulfram-26284]
Date: Mon, 29 Dec 2003 12:58:46 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200312291758.hBTHwlc6015445@dhin.linuxaudiosystems.com>
References: <1072715435.1602.325.camel@renegade>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from out012.verizon.net (out012pub.verizon.net [206.46.170.137])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id SAA04489
	for <alsa-devel@alsa-project.org>; Mon, 29 Dec 2003 18:59:55 +0100
In-reply-to: Your message of "Mon, 29 Dec 2003 17:30:35 +0100."
             <1072715435.1602.325.camel@renegade>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ove Kaaven <ovek@transgaming.com>
Cc: Jaroslav Kysela <perex@suse.cz>, Peter Hunnisett <peter@transgaming.com>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>That kind of argument would just corroborate the TransGaming report that
>ALSA is no good overhead-wise, which is probably not what the ALSA
>developers wish to do here.

i wasn't talking about ALSA. i was talking about audio hardware and
programming models in general. ALSA will allow pretty much any
programming model.

>> but assuming
>> that you can access the h/w buffer directly and more - that you can
>> access all of it at any time, i don't believe that this is a good
>> model.
>
>It's not "at any time". It's only after it has locked the buffer or part
>of it (it must specify which area it wishes to lock and write to). Then
>it must unlock the locked part again. The unlock is then supposed to
>transfer the modified data to the sound device if necessary (like if the
>hardware buffer cannot be memory-mapped, and the buffer returned by the
>lock was just a copy in system memory). You can consider "lock" roughly
>equal to "mmap_begin" and "unlock" roughly equal to "mmap_commit",
>except that it's the game that says what part of the buffer to lock.

and that's what wrong. if you look at ASIO, you will see that your
access to the h/w buffer is limited to whatever ASIO tells you can
access. if a game used ASIO, it could not choose which part of the
buffer to access. however, games don't use ASIO - instead they appear
to use an API that encourages them to believe they have access to
other parts of the buffer as well.

now, if the programmers are avoiding this, and using a more ASIO-like
model where you can only access a part of the h/w buffer, things are
better, and its only the position of the ALSA application pointer that
is an issue. but in this case, things are so simple that i don't
understand the original question: ALSA provides a way to get the
address and size of a contiguous region of memory that can be accessed
as a raw memory buffer with no reference to any other ALSA data
structures necessary. this is certainly what JACK does - you can
scribble all over the buffer space corresponding to the period at any
time just using pointers, but you can't touch buffer space that does
not correspond to the period.

>That's how DirectSound does things, and I don't see a reason this model
>can't be implemented on pretty much any hardware.

it can be implemented on any hardware. it can't be implemented if the
application short-circuits the device driver by mmapping the hardware
buffer and then acts as if it "owns" the whole thing. this is why ALSA
provides the mmap_begin() and mmap_commit() calls, so that if mmap
access requires some level of "virtualization" because of limitations
with the underlying hardware, the driver can work around it. and btw,
there really is hardware like this - several early RME cards (as well
as those that were rebranded (Sek'd, Marian and others) have no DMA
buffer access at all. the "virtualization" also allows mmap mode to
work on "virtual" devices too.

>Speaking of which, does ALSA implement hw-buffer properties like 3D
>position on hardware that can support it (hw-accelerated HRTF)?

AFAIK, there is work going on to add this at the moment.

>Anyway, that's not something TransGaming need to like, it's the game
>programmers that write the games that does things the way they do, and
>how Microsoft tells them to do it, through their DirectX API.

i wish you knew what the people who wrote the audio part of DirectX
think of it :) i can't quote them personally for privacy reasons, but
lets just say that its not particularly positive.

--p


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
