From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Re: (Fwd) ALSA related comments - please correct [wulfram-26284]
Date: Mon, 29 Dec 2003 10:07:58 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200312291508.hBTF7xdB022388@dhin.linuxaudiosystems.com>
References: <Pine.LNX.4.58.0312290957500.25504@pnote.perex-int.cz>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from out003.verizon.net (out003pub.verizon.net [206.46.170.103])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id QAA01398
	for <alsa-devel@alsa-project.org>; Mon, 29 Dec 2003 16:09:06 +0100
In-reply-to: Your message of "Mon, 29 Dec 2003 10:10:40 +0100."
             <Pine.LNX.4.58.0312290957500.25504@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Peter Hunnisett <peter@transgaming.com>, Ove Kaaven <ovek@transgaming.com>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>> We have been unable to find a way to tell ALSA, through 
>> snd_pcm_mmap_begin(), where we want to write data when using the mmap 
>> api. OSS doesn't have this restriction and this is the only documented 
>> way we can see to support sound engines which mix in new sounds using 
>> looping buffers and "randomly" writing ahead of the playing position. We 
>> have seen that there are undocumented ways to support this functionality 
>> and we are leery of using undocumented functionality since it could 
>> disappear or change. Can you suggest a documented way to achieve the 
>> desired effect or would you be in favour of modifications to the API?

although i agree that from a pragmatic perspective, it would be good
to understand how to use ALSA to do this.

however, this model of audio programming is not portable, and has
gotten people into trouble before, not just under Linux.

making the assumption that direct access at all times to the full
hardware buffer is not a valid assumption to make. there is a very
popular audio interface API (ASIO) that explicitly denies this
possibility, and there are audio interfaces out there that are not
designed in a way that makes it possible to do what you are trying to
do (i know that game programmers generally don't use ASIO).

its just my personal opinion of course, but i think it very
unfortunate that game programmers have fallen into this model. by all
means setup your *own* buffer and write anywhere into it. then
transfer the relevant parts of your buffer to the device at interrupt
time (i.e. when poll returns or when write is possible). but assuming
that you can access the h/w buffer directly and more - that you can
access all of it at any time, i don't believe that this is a good
model.

i can understand that you don't like having to sync to the audio
device interrupt. but not doing so leads to other problems as well.

just my $0.02, or perhaps less.

--p





-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
