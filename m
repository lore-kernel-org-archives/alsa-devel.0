From: Paul Davis <pbd@Op.Net>
Subject: Re: latency timer
Date: Tue, 26 Feb 2002 18:14:52 -0500
Message-ID: <200202262315.SAA07930@renoir.op.net>
In-reply-to: Your message of "Wed, 27 Feb 2002 00:01:42 +0100."
             <000d01c1bf19$96361960$0300a8c0@wgilmenau>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Robert Br ckmann <robert.brueckmann@stud.tu-ilmenau.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>if I set the latency timer to 0x30, I am able to stream 48 channels of data
>to a speed-optimized raid system. However this is not the point. The arecord
>command was just an example, the computer has severe problems to record and
>play data with 48 channels in realtime if I don't increase the latency timer
>(even without streaming to disk, but only to memory). Do you know what the
>pci-latency timer does actually?

for the BX or GX chipsets, it defines the number of PCI clocks a PCI
master (like the hammerfall) can own on the bus after the PCI central
arbiter removes the grant signal. recommended setting on my MB is 64.

>My system locks too often when doing that. I posted the code I used several
>days before, but there was no answer. I just want to know, if other
>programmers would do it the same way, or if I'm missing an important point.

well, you posted a chunk of code, not the whole thing. 

look, i've been recording huge chunks of data from a hammerfall for a
couple of years, and my code is all out there for people to look
at. i've even written JACK (with some help) to simplify the issue of
writing such applications. no, i wouldn't do what you're doing. i
wouldn't use the read/write API, for a start.

i have never used the ALSA "multi" PCM devices, so i can't comment on
how well they will work either. its possible that they add some
additional performance penalty that affects you.

i've never recorded more than 26 channels, but i've done that *to
disk* using less than 30% of the available CPU with no xruns in sight
at the lowest period size. i also regularly run jackd in
all-input-monitor mode, copying data for all 26 channels, and that
doesn't consume more than 10-15% of the available CPU. this is on a
dual PII-450.

there is absolutely no reason to be messing around with the PCI bus
settings to do multitrack recording.

--p


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
