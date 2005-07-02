From: James Courtier-Dutton <James@superbug.co.uk>
Subject: A suggestion to solve the ALSA resampling problem.
Date: Sat, 02 Jul 2005 13:23:42 +0100
Message-ID: <42C6874E.9060301@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,

There are essentually 2 problems to solve. I will take the alsa code in
the game doom3 as a way to demonstrate the problems.

doom3 uses a sample rate of 44100. Most sound cards now work at 48000 in
hardware, so one needs to sample rate convert between 44100 to 48000 in
software in order to get games like doom3 to play well.
doom3 also opens the buffers at 1024 frames per period, and 4096 frames
per buffer. It then writes 1024 frames at a time to the buffer. If the
complete write fails, it complains and the sound sounds really bad.
This approach is fine in the sound card can do periods of 1024 frames,
but not all sound card hardware can, so we need to find an abstraction
layer in order to deliver these period and buffer sizes to the
application, while also serving the different period and buffer sizes of
the hardware.

So, how about this.
The application can select any buffer size and period size they like.
For simplicity, we might impose that number_of_periods is an integer.

So, the 44100 application buffer is 4096(buffer size),1024(period size)
The hardware 48000 buffer is 2048(buffer size), 512(period size)

We add an intermediate buffer at 48000. This buffer size must be >=
4096*48000/44100. period size must be >= 1024*48000/44100.
If we round up, we get:
intermediate buffer: 4458.23 -> 4459
intermediate period: 1114.56 -> 1115

For ease of transfer between the intermediate buffer and the hardware,
we should really make the intermediate buffer_size = n*hardware period_size.
So, we have the following equations to satify:
intermediate_buffer_size = n * hardware_period_size.
intermediate_buffer_size >=
application_buffer*hardware_rate/application_rate.
intermediate_period_size = hardware_period_size.

This results in the:
intermediate_buffer_size = 4608 (9 * 512)
intermediate_period_size = 512


Each time the sound card hardware interrupts (every 512 frames), alsa
copies the next period from the intermediate buffer to the hardware
buffer. This essentually allows for any sound card hardware to have as
many periods as they wish, and thus as larger buffer size as they like.
With the expense of one extra memcpy.

Each time the application writes to the application buffer, alsa-lib
sample rate converts the number of frames in the snd_pcm_write()
operation, and also writes those to the intermediate buffer.

Add to that some careful handling of position and avail pointers in each
of the buffers. This should result in reliable sample rate/buffer size
converted audio.

The next thing to consider is whether some applications can get sound to
the pcm buffer without using snd_pcm_write(). For example memcpy for
mmap applications. We would need some way to track these memcpy writes,
so that the sample rate converter could take the new samples, and sample
rate convert them into the intermediate buffer.

Does anyone have any ideas regarding this last point? If this last point
never happens in alsa, then I will go ahead and start writing a patch
for alsa to do all this.

James




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
