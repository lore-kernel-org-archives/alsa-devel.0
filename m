From: Markus Grabner <grabner@icg.tu-graz.ac.at>
Subject: Re: sample rate conversion
Date: Sat, 4 Sep 2004 02:14:22 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200409040214.22987.grabner@icg.tu-graz.ac.at>
References: <200409021953.57939.grabner@icg.tu-graz.ac.at> <Pine.LNX.4.58.0409031710210.21405@linux.local> <413898A7.7090502@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <413898A7.7090502@superbug.demon.co.uk>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: Jaroslav Kysela <perex@suse.cz>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Am Friday 03 September 2004 18:15 schrieb James Courtier-Dutton:
> Jaroslav Kysela wrote:
> > On Thu, 2 Sep 2004, Markus Grabner wrote:
> >>    I am working on a Linux driver for a weird device that only accepts
> >>24bit input at 39062.5Hz (PODxt Pro by Line6), so for this driver to be
>
> The current resamplers only handle 16bit or less samples.
This is not really a problem since most audio files are also <=16bit.

> >>able to play regular audio files, the built-in sample rate conversion
> >>(via plughw:n)  has to be used. I noticed that the resampler improved a
> >>lot since ALSA-1.0.4, but it still has some problems. The sound quality
> >>is significantly reduced compared to a file that is resampled offline
> >>(e.g., by the resampler included in "sox"). It sounds like additional
> >>noise when high frequencies occur (aliasing?). It should be technically
> >>possible to use the "sox" algorithm in the ALSA libraries, but before I
> >>dive into the code, I wanted to ask if anybody else is aware of this
> >>problem or maybe even works on a solution!
> >
> > We are using only poor but very fast linear interpolation in our
> > resampling algorithm.
> >
> > There are several problems to implement another algorithm with filters:
> >
> > 1) algorithm state depending on the previous samples
> >    - we can move back in the stream (rewind)
> >    - we can also skip some samples in the stream (forward)
> > 2) fixed size input and output chunks (input and output period size)
>
> I think this point is the most problematic for sample rate conversion.
> The pcm_rate.c plugin can store state, so can store previous chunks if
> needed, the real problem is that the resampling is done in chunks, and
> the application(input) chunk size does not aways equal an integer number
> of hardware(output) chunk size. e.g. input rate=44100, output
> rate=48000, output chunk size=1024, input chunk size should = 940.8
> I have thought of several ideas about how to fix this problem, but they
> result is rather complicated solutions. e.g. If someone calls the
> snd_pcm_writei() we could do high quality resampling like sox does, but
> it would not work if the application is using direct audio buffer
> accesses, or if the application was trying to write one period at a
> time. So, there is not nice simple method that will work in all cases.
> I recently did modifications to the alsa-lib resamplers, to fix a
> problems where it was accidentally inserting 0 samples (quiet) into the
> stream as it played or captured. It is just a simple resampler
> (interpolator) so it adds aliases, so users at least get some sound out,
> but the quality of the sound will be quite bad, although some people
> might not notice.
Would it be feasible to round the input chunk size to the nearest integer, 
i.e., 941 in the above example? This would then play a ~47989.8Hz stream on a 
48000Hz device, i.e., the "A" note would be played at 440.09Hz instead of 
440Hz. This amounts to a detune of 0.37 Cent, which is beneath the resolution 
of most digital tuning devices and certainly less distracting than aliasing.
(Linear) downsampling would be rather trivial then, and upsampling would just 
require the first frame of the next period to be estimated. Again referring 
to the above example, a five minute song would be 64ms too short. Would this 
cause severe timing problems?

> Resampling is generally quite CPU intensive, and also adds latency, so
> it is better if the application does the resampling using a polyphase
> filter. (I.e. I agree with Jaroslav)
>
> > In other words, it's much easier to do rate conversion in the application
> > code where samples are processed in a stream.
The point is (I think I read a similar discussion elsewhere) that I would like 
to support a device that is practically useless without sample rate 
conversion, so the conversion has to happen at either kernel, library, or 
application level. The application level is out of question if existing 
programs without built-in rate conversion should be supported, and I think 
the library level is still more appropriate than the kernel level.
Actually, I didn't even try sox' nonlinear interpolation since I was 
completely satisfied with the linear one without filtering ("resample" 
effect), just using the "-r" option.

BTW, the driver code for the device I am talking about is available at 
http://www.tanzband-scream.at/line6.

	Kind regards,
		Markus


-- 
Markus Grabner - Computer Graphics and Vision
Graz University of Technology, Inffeldgasse 16/II, 8010 Graz, Austria
Phone: +43/316/873-5041, Fax: +43/316/873-5050
Email: grabner@icg.tu-graz.ac.at, WWW: http://www.icg.tu-graz.ac.at/~grabner


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
