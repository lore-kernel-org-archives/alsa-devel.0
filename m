From: =?iso-8859-1?Q?Robert_Br=FCckmann?= <robert.brueckmann@stud.tu-ilmenau.de>
Subject: Re: latency timer
Date: Wed, 27 Feb 2002 08:45:39 +0100
Message-ID: <000f01c1bf62$c598a4e0$0300a8c0@wgilmenau>
References: <200202262315.SAA07930@renoir.op.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Paul Davis <pbd@op.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> look, i've been recording huge chunks of data from a hammerfall for a
> couple of years, and my code is all out there for people to look
> at. i've even written JACK (with some help) to simplify the issue of
> writing such applications. no, i wouldn't do what you're doing. i
> wouldn't use the read/write API, for a start.
>
> i have never used the ALSA "multi" PCM devices, so i can't comment on
> how well they will work either. its possible that they add some
> additional performance penalty that affects you.

So what do think I should use instead? I need all 48 channels in perfect
sync (sample-accurate). Do you think that's impossible? The CPU-load of my
application is (with signal processing) less than 30%, but still there are
xruns sometimes. It might be that the pci bus can't handle my data.

>
> i've never recorded more than 26 channels, but i've done that *to
> disk* using less than 30% of the available CPU with no xruns in sight
> at the lowest period size. i also regularly run jackd in
> all-input-monitor mode, copying data for all 26 channels, and that
> doesn't consume more than 10-15% of the available CPU. this is on a
> dual PII-450.
>

If I run my program with only one hammerfall, then the CPU load is less than
10%, no xruns at all. Maybe the problem is not the 48 channels but the
syncing of the two hammerfalls.

> there is absolutely no reason to be messing around with the PCI bus
> settings to do multitrack recording.
>

But if the pci-bus is overloaded with the data it has to handle? It's a fact
that it worked only since I increased the pci-latency timer in the BIOS. I
am used to have these pci-performance problems with hardware from creamware
(under win98 however, but it was hardware-related), these cards needed a lot
of pci-bandwidth, too.
I wonder if I'm the first one who wants to use two hammerfalls in linux for
recording and playback at the same time.
Anyone?

Robert


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
