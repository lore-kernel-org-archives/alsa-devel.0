From: Doug McLain <nostar@comcast.net>
Subject: API questions
Date: Fri, 19 Mar 2004 04:43:05 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <405AC0A9.6070902@comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sccrmhc11.comcast.net (sccrmhc11.comcast.net [204.127.202.55])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id KAA09337
	for <alsa-devel@alsa-project.org>; Fri, 19 Mar 2004 10:43:53 +0100
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I have posted my code in question here:

http://rafb.net/paste/results/nI811998.html

I have been studying the ALSA driver and lib API, and in doing so have 
written a simple raw pcm player.  I used the tutorials written by Dr 
Matthias Nagorni and Paul Davis as templates, along with alot of gdb 
sessions with aplay.  It is by no means intended for any real use, its 
purpose is to be used as a soft 'breadboard' so to speak; a simple tool 
for dropping functions in, examining hardware, etc.  When I feel I'm 
ready, the next step is to make a callback based version, as per the 
Davis howto.  Ultimately, I wish to "forget all of this" (jack).  I'm 
spending alot of time at the alsa level because I'm interested highly in 
the device driver api as well as applications.

I was able to get it working very easily on my laptop (ymfpci based) and 
was feeling pretty sexy at this point.  I started adding stuff like a 
getopt routine (originally i was changing the struct pm values and 
recompiling over and over), all kinds of info, hw_params_get and test 
functions, various debugging functions, throwing all kinds of hw_params 
at it (periods, period size/time buffer size/time, etc), to closely 
examine the inner workings of the driver, hardware, etc.  I was already 
starting to look into the jack API (which sent me directly to pthreads 
as a prerequisite). I'm also refreshing my areas of C that were rusty 
too, whence all the struct and pointer to struct usage (those were weak 
areas for me).  Then I moved to my desktops to find it fail on a few 
devices:  the ice1712 (delta 1010LT and EZ8) and the intel8x0.  It works 
on the ymfpci and the via82xx.  I noticed a problem with the output of 
snd_pcm_hw_params_dump showing RATE: NONE on my program.

aplay's call:
   snd_pcm_hw_params_set_rate_near(handle, params, &hwparams.rate, 0);

my pcmplay's call:
   snd_pcm_hw_params_set_rate_near(pcm_handle, hwparams, 
&(params->rate), &dir);

Changing arg4 in my program to 0 fixed the problem.  Looks like the 
recent change to this function bit me again.  I sent a post a while back 
about the return value and arg3, looks like arg4(int *dir) has changed 
as well. Confirmation?  Kinda weird that it works on some and not other 
devices though, that really thru me for a while.  Here is the link once 
again to the inaccurate documentation:

http://www.alsa-project.org/alsa-doc/alsa-lib/group___p_c_m___h_w___params.html#a58

This email was actually started to ask for help in finding that problem, 
which I found while writing it.  So now on to the questions that I had 
been developing before I got sidetracked by that bug, if I can remember 
them all:)

If I understand correctly, a hardware buffer is a chuck of ram in the 
audio device itself of a fixed size.  I think that the author of a 
device driver defines the max buffer size by referring to the hardware 
specs of the chip.  Is there more to it than this?  I ask because first, 
I can't seem to get a buffersize setting out of a ymfpci 744 of 256K no 
matter what hw_params I throw at it, anything higher that 64K (65536 
bytes) causes a set buffersize error.  I doublechecked to make sure I 
wasn't confusing bytes with frames, and I'm not. .  I got that value of 
256K from the driver code, show below.  I'm also curious about the 
comment.  Again, isn't this a hardware aspect, and not a question of 
enough or not?  Was it perhaps, that the author was guessing due to lack 
of specs at the time or something?

static snd_pcm_hardware_t snd_ymfpci_playback =
{
	.info =			(SNDRV_PCM_INFO_MMAP |
				 SNDRV_PCM_INFO_MMAP_VALID |
				 SNDRV_PCM_INFO_INTERLEAVED |
				 SNDRV_PCM_INFO_BLOCK_TRANSFER |
				 SNDRV_PCM_INFO_PAUSE |
				 SNDRV_PCM_INFO_RESUME),
	.formats =		SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S16_LE,
	.rates =		SNDRV_PCM_RATE_CONTINUOUS | SNDRV_PCM_RATE_8000_48000,
	.rate_min =		8000,
	.rate_max =		48000,
	.channels_min =		1,
	.channels_max =		2,
	.buffer_bytes_max =	256 * 1024, /* FIXME: enough? */
	.period_bytes_min =	64,
	.period_bytes_max =	256 * 1024, /* FIXME: enough? */
	.periods_min =		3,
	.periods_max =		1024,
	.fifo_size =		0,
};

I had lots more, but I think they were all based on confusion about that 
bug.  Guess it's back to the drawing board for now...

-- 
http://nostar.isa-geek.com/



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
