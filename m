From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: sample rate conversion
Date: Fri, 3 Sep 2004 17:14:29 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0409031710210.21405@linux.local>
References: <200409021953.57939.grabner@icg.tu-graz.ac.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200409021953.57939.grabner@icg.tu-graz.ac.at>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Markus Grabner <grabner@icg.tu-graz.ac.at>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 2 Sep 2004, Markus Grabner wrote:

>     I am working on a Linux driver for a weird device that only accepts
> 24bit input at 39062.5Hz (PODxt Pro by Line6), so for this driver to be
> able to play regular audio files, the built-in sample rate conversion
> (via plughw:n)  has to be used. I noticed that the resampler improved a
> lot since ALSA-1.0.4, but it still has some problems. The sound quality
> is significantly reduced compared to a file that is resampled offline
> (e.g., by the resampler included in "sox"). It sounds like additional
> noise when high frequencies occur (aliasing?). It should be technically
> possible to use the "sox" algorithm in the ALSA libraries, but before I
> dive into the code, I wanted to ask if anybody else is aware of this
> problem or maybe even works on a solution!

We are using only poor but very fast linear interpolation in our 
resampling algorithm.

There are several problems to implement another algorithm with filters:

1) algorithm state depending on the previous samples
   - we can move back in the stream (rewind)
   - we can also skip some samples in the stream (forward)
2) fixed size input and output chunks (input and output period size)

In other words, it's much easier to do rate conversion in the application 
code where samples are processed in a stream.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SUSE Labs


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
