From: "Men Muheim" <muheim@gmx.ch>
Subject: read time information
Date: Fri, 15 Nov 2002 11:28:53 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <001201c28c91$cc64f470$461d8481@profi>
References: <200201212159.QAA05738@renoir.op.net>
Reply-To: <men@ife.ee.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200201212159.QAA05738@renoir.op.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

For synchronization purpose I need the current time of my sound card
(information on the sample that is currently played out might be
sufficient / ADAT-Synch timecode) I did anticipate that the functions 

      snd_pcm_status_alloca(&status);
	snd_pcm_status_get_tstamp(status, timestamp);

do help me with this, but obviously they only call gettimeofday()
instead of returning a sound card time information (see
http://www.alsa-project.org/alsa-doc/alsa-lib/_2test_2latency_8c-example
.html#example_test_latency). From the API description I have found that 

snd_pcm_hwsynch(...)
snd_pcm_delay(...)

must be used to get the current sample positions of the DAC/ADC. But
these functions do not seem to work on my system (alsa-0.9.0rc5 and an
RME9652 sound card). Besides that I want to read the ADAT-Synch timecode
instead of the buffer relative sample offset.

Therefore I was looking for another solution to get the time. I tried to
use the ALSA timer interface
(http://www.alsa-project.org/alsa-doc/alsa-lib/_2test_2timer_8c-example.
html#example_test_timer). But unfortunately I am getting a "timer time
out!", which means that 

snd_timer_poll_descriptors(...)

did fail. Is the timer interface implemented for the By the RME9652? By
the way I do not understand how the sample number to the read time do
correlate with each other.

I would appreciate any help with this because if I cannot solve this
problem, I have to move to Windows ASIO (what a pitty!) ASIO provides
the functions

ASIOGetSamplePosition(...)
bufferSwitchTimeInfo(...) 

which do exactly what I need.

Regards,

Men



-------------------------------------------------------
This sf.net email is sponsored by: To learn the basics of securing 
your web site with SSL, click here to get a FREE TRIAL of a Thawte 
Server Certificate: http://www.gothawte.com/rd524.html
