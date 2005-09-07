From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: Converting OSS ioctl's to ALSA API
Date: Wed, 07 Sep 2005 23:29:39 +0100
Message-ID: <431F69D3.1060705@superbug.co.uk>
References: <33017.65.103.251.231.1125967798.squirrel@65.103.251.231>    <Pine.HPX.4.33n.0509060950330.11382-100000@studcom.urz.uni-halle.de> <52491.12.110.19.97.1126112946.squirrel@12.110.19.97>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <52491.12.110.19.97.1126112946.squirrel@12.110.19.97>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Bob Ingraham <bobi@netshel.net>
Cc: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Bob Ingraham wrote:

>Thank-you so much for ioctl mapping!
>
>May I ask one other architectural question?
>
>This video-conferencing app expected to use two half-duplex devices for
>simultaneous record-playback:
>
>/dev/dsp0 and /dev/dsp1 - these were expected to be configured as the
>separate playback and record channels of a single soundcard.
>
>However, on all of our target platforms (all running
>SuSE/Novell-Linux-Desktop,) there only appears to be a single, full-duplex
>device to use (plugwh:0,0) for both record and playback.
>
>So the (three-part) question is:
>
>1. Do I:
>
>  (a) Try to re-write this app to use full-duplex? or,
>
>  (b) Can I re-configure ALSA to split the default device (plughw:0,0)
>into two separate, half-duplex sub-devices (one for playback and one for
>record?
>
>
>2. Which approach makes more sense (i.e., more stable, reliable, etc.)?
>
>
>3. If 1a is the way to go, is there a tutorial or sample-doc on how to
>properly program full-duplex (simultaneous record & playback) operation
>under ALSA?
>
>
>Thanks,
>Bob
>  
>
ALSA provides an abstraction layer.
If you open plughw:0,0 for only playback, and then again for only 
capture it should work.
So, although the device name looks the same, device names for playback 
and capture are in fact in a different name space.
alsa-lib does all the difficult work for you.

Another alternative could be to use jackd. It is ideal for low latency 
applications, and VoIP is certainly ideal for that.

James



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
