From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Starting the device manually
Date: Fri, 04 Aug 2006 18:44:50 +0200
Message-ID: <20060804164450.GA4743@turing.informatik.uni-halle.de>
References: <44C494F4.6050301@graphics.cs.uni-sb.de>
	<20060724110516.GA12899@turing.informatik.uni-halle.de>
	<44C4B1B9.6060705@graphics.cs.uni-sb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-reply-to: <44C4B1B9.6060705@graphics.cs.uni-sb.de>
Content-disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Eric Peters <epeters@graphics.cs.uni-sb.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Eric Peters wrote:
> Clemens Ladisch wrote:
> > Eric Peters wrote:
> >>In some other messages on this list there was the hint to set this
> >>threshhold larger than the max_buffer_size and then the device shouldn't
> >>start automatically. So I've done. But unfortunately the playback starts
> >>again automatically.
> > 
> > What are the contents of /proc/asound/card?/pcm0p/sub0/sw_params during
> > playback?
> 
> start_threshold: 2703204728

This is way too large.  In fact, it's so large that, as a signed value,
it's negative.

Just use the boundary value, which is appropriate for 'almost infinity'
values like this.

> >>/* calculating the number of frames of a buffer and a period */
> >>buffer_frames = buffer_time * sample_rate;
> >>period_frames = period_time * sample_rate;
> > 
> > Is this correct?  Aren't the xxx_time variables in microseconds?
> 
> I don't know. ;-)
> How is a frame defined?

It's the amount of data that is transferred in one sample period.  It's
more than one sample when there is more than one channel.

The buffer_time/period_time variables are in microseconds, while the
sample_rate uses seconds (Hz = 1/s), so you would have to divide by
1000000 for the calculation to make sense.

> > ..., but it is common to use just the boundary value instead of
> > some explicitly calculated value.
> 
> The boundary value in the output above? How can I determine this value 
> in my application?

snd_pcm_sw_params_get_boundary()


HTH
Clemens

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
