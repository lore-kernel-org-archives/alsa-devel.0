From: Paul Davis <pbd@Op.Net>
Subject: Re: latency timer
Date: Tue, 26 Feb 2002 17:27:01 -0500
Message-ID: <200202262227.RAA00414@renoir.op.net>
In-reply-to: Your message of "Tue, 26 Feb 2002 23:06:38 +0100."
             <002601c1bf11$e23a37e0$0300a8c0@wgilmenau>
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

>I wanted to use two RME hammerfalls to record 48 channels of audio via adat,
>do some signal processing and play them back again. But I experienced a very
>poor performance of my computer (dual pentium III 1.3GHz, 512MB RAM). It
>wasn't even able to record 48 channels without xruns.
>
>I modified aplay/arecord that it plays/records more than 32 channels (btw:
>why did the developers insert such a silly check which didn't allow more
>than 32 channels???), but arecord gave many xruns while recording (aplay
>worked fine):

arecord *CANNOT* do this. it is not designed to do serious multitrack
recording. you will never get it to work unless you have a disk
subsystem with unbelievable seek and sustained i/o performance. if
arecord could do this, the work that i've put into ardour over the
last couple of years would be (partly) a waste of time. you can't
stream that much data to disk in real time without a multithreaded
design, which arecord does not have.

i doubt that arecord could go much above 12 channels with its
single-threaded design, certainly if using 32 bit samples.

>BTW: Might the low latency check help with my problem?

i presume you are referring to the low latency patch. it is only of
critical if you are using low period sizes, which for recording 48
tracks is not the optimal setting. however, it can help any audio
program, even xmms and the like.

--p


_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
