From: Paul Davis <pbd@op.net>
Subject: Re: do apps need to care for xfer_align ???
Date: Mon, 09 Sep 2002 10:28:19 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200209091425.QAA07243@alsa.alsa-project.org>
References: <Pine.LNX.4.21.0209091613540.10104-100000@gate.perex.cz>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from newmx1.fast.net (newmx1.fast.net [209.92.1.31])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id QAA07243
	for <alsa-devel@alsa-project.org>; Mon, 9 Sep 2002 16:25:26 +0200
In-reply-to: Your message of "Mon, 09 Sep 2002 16:14:39 +0200."
             <Pine.LNX.4.21.0209091613540.10104-100000@gate.perex.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Guilhem Tardy <guilhem_tardy@yahoo.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>On Fri, 6 Sep 2002, Guilhem Tardy wrote:
>
>> Hi all,
>> 
>> While trying to understand snd_pcm_lib_write1(), I found that
>> runtime->xfer_align is set to period_size in pcm_native.c, but wonder if it 
>is
>> just a default?
>> 
>> Paul Davis' example (at http://www.op.net/~pbd/alsa-audio.html#playex) doesn
>'t
>> check for a particular transfer size, and my card supports playout of less t
>han
>> 160 samples (i.e. the period size). Thus, I set to try playing out 512 bytes
> at
>> a time (i.e. 2048 samples of 2-bit ADPCM), which does NOT come to a multiple
> of
>> period size. The result is that only 1920 samples are played, and my app thi
>nks
>> an error has occured.
>> 
>> Is it a general requirement for apps to send only audio in multiple of the
>> period size?
>
>Nope, applications might modify xfer_align to satisfy their requirements.

jaroslav, since even i don't understand what xfer_align is for, or
even have an answer to the actual question, it might be good for you
to expand on this a little.

--p


-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390
