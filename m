From: =?iso-8859-1?Q?Robert_Br=FCckmann?= <robert.brueckmann@stud.tu-ilmenau.de>
Subject: Re: latency timer
Date: Wed, 27 Feb 2002 00:01:42 +0100
Message-ID: <000d01c1bf19$96361960$0300a8c0@wgilmenau>
References: <200202262227.RAA00414@renoir.op.net>
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

Paul,

if I set the latency timer to 0x30, I am able to stream 48 channels of data
to a speed-optimized raid system. However this is not the point. The arecord
command was just an example, the computer has severe problems to record and
play data with 48 channels in realtime if I don't increase the latency timer
(even without streaming to disk, but only to memory). Do you know what the
pci-latency timer does actually?

My system locks too often when doing that. I posted the code I used several
days before, but there was no answer. I just want to know, if other
programmers would do it the same way, or if I'm missing an important point.

Robert


----- Original Message -----
From: "Paul Davis" <pbd@op.net>
To: "Robert Br ckmann" <robert.brueckmann@stud.tu-ilmenau.de>
Cc: <alsa-devel@lists.sourceforge.net>
Sent: Tuesday, February 26, 2002 11:27 PM
Subject: Re: [Alsa-devel] latency timer


> >I wanted to use two RME hammerfalls to record 48 channels of audio via
adat,
> >do some signal processing and play them back again. But I experienced a
very
> >poor performance of my computer (dual pentium III 1.3GHz, 512MB RAM). It
> >wasn't even able to record 48 channels without xruns.
> >
> >I modified aplay/arecord that it plays/records more than 32 channels
(btw:
> >why did the developers insert such a silly check which didn't allow more
> >than 32 channels???), but arecord gave many xruns while recording (aplay
> >worked fine):
>
> arecord *CANNOT* do this. it is not designed to do serious multitrack
> recording. you will never get it to work unless you have a disk
> subsystem with unbelievable seek and sustained i/o performance. if
> arecord could do this, the work that i've put into ardour over the
> last couple of years would be (partly) a waste of time. you can't
> stream that much data to disk in real time without a multithreaded
> design, which arecord does not have.
>
> i doubt that arecord could go much above 12 channels with its
> single-threaded design, certainly if using 32 bit samples.
>
> >BTW: Might the low latency check help with my problem?
>
> i presume you are referring to the low latency patch. it is only of
> critical if you are using low period sizes, which for recording 48
> tracks is not the optimal setting. however, it can help any audio
> program, even xmms and the like.
>
> --p
>
>


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
