From: Paul Davis <pbd@op.net>
Subject: Re: question about aplay code (v0.5.10)
Date: Thu, 04 Apr 2002 09:28:06 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200204041427.JAA12398@renoir.op.net>
References: <6380966D8BCFD5119C9300306E1C8487033619@clg-server7.clg.fja.de>
Received: from renoir.op.net (root@renoir.op.net [207.29.195.4])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id QAA16239
	for <alsa-devel@alsa-project.org>; Thu, 4 Apr 2002 16:28:02 +0200
In-Reply-To: Your message of "Thu, 04 Apr 2002 13:27:04 +0200."
             <6380966D8BCFD5119C9300306E1C8487033619@clg-server7.clg.fja.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: "Kuball, Martin" <Martin.Kuball@fja.com>
Cc: "'alsa-devel@alsa-project.org'" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>> Hi!
>>  
>> I tried to write some programs for sound processing recently. Most of it
>> went very well, but some questions about the aplay code (version 0.5.10),

please do not use ALSA 0.5.X anymore. it is old and no longer under
development. it has many design issues that are fixed in ALSA 0.9.X.

>> The first is: In the capture_go method a buffer is filled using
>> snd_pcm_plugin_read and than written directly to a wave file. The
>> documentation says that in block mode the driver returns the data for each
>> channel in a separate  part of the buffer. But wave files expect the
>> samples
>> to be interleaved.  As arecord does indeed work, some of my thoughts must
>> be
>> wrong. But which one is it?

these questions have no meaning in ALSA 0.9.X.

>> And the second one: Why is the size of a fragment choosen to be a power of
>> 2? Why not a multiple of os_page_size * number_of_voices? Is it just the
>> programers preference or is there a good reason for it?

because they are the sizes dictated by 99% of all audio hardware. you
cannot force the hardware to generate an interrupt at arbitrary points
in time during its traversal of its ringbuffer, and the vast majority
of audio interfaces can only do so at power-of-two sizes. similar
issues exist for the overall size of the buffer. there are 1 or 2
exceptions to this, but they are really quite strange in their own
ways and i'm not sure they are even manufactured anymore.

--p
