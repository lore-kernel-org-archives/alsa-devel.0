From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Starting the device manually
Date: Mon, 24 Jul 2006 13:05:16 +0200
Message-ID: <20060724110516.GA12899@turing.informatik.uni-halle.de>
References: <44C494F4.6050301@graphics.cs.uni-sb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-reply-to: <44C494F4.6050301@graphics.cs.uni-sb.de>
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
> I'm a bit confused by the alsa documentation. I want to fill up a buffer
> of a alsa device with snd_pcm_writei and then if the buffer is full, I
> want to be able to start the playback manually. By looking to the
> documentation, I found the method snd_pcm_sw_params_set_start_threshold.
> In some other messages on this list there was the hint to set this
> threshhold larger than the max_buffer_size and then the device shouldn't
> start automatically. So I've done. But unfortunately the playback starts
> again automatically.

What are the contents of /proc/asound/card?/pcm0p/sub0/sw_params during
playback?

> /* calculating the number of frames of a buffer and a period */
> buffer_frames = buffer_time * sample_rate;
> period_frames = period_time * sample_rate;

Is this correct?  Aren't the xxx_time variables in microseconds?

> snd_pcm_sw_params_set_start_threshold(..., 2*buffer_frames)

This is OK, but it is common to use just the boundary value instead of
some explicitly calculated value.

> - I think, if I don't call snd_pcm_start there should be no output if
> the start threshold is larger than the max_buffer_size. Is this correct?

... if the start threshold is larger than the current buffer size, in
frames.  Yes.

> - Is it possible that the starting behaviour depends on the hardware I'm
> using?

No, the software parameters are hardware independent.


Regards,
Clemens

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
