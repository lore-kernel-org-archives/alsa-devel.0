From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: ALSA lib application compatibility [was] Re: mixer
 device
Date: Tue, 18 May 2004 15:49:22 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40AA2272.6060306@superbug.demon.co.uk>
References: <1084218706.31496.72.camel@shrek.bitfreak.net>	 <Pine.HPX.4.33n.0405121735410.26780-100000@studcom.urz.uni-halle.de>	 <20040513153457.GE6913@sunrise.pg.gda.pl>	 <Pine.LNX.4.58.0405181545510.13943@spring> <1084887054.1835.14.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1084887054.1835.14.camel@localhost>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: mjander@users.sourceforge.net
Cc: Alsa Devel list <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Manuel Jander wrote:
> 
> As the main author of the Aureal Vortex driver, its very stupid having
> to handle arbitrary period sizes, introducing a lot of overhead and
> complexity in the driver, while the hardware just is not designed to
> handle period sizes that are not powers of two, due to page boundary
> overlapping trouble. 

You don't have to handle arbitary period sizes in the alsa-driver.
Here is an example from the emu10k1 driver, that restricts what period 
sizes the application can use for caputure.

static unsigned int capture_period_sizes[31] = {
         384,    448,    512,    640,
         384*2,  448*2,  512*2,  640*2,
         384*4,  448*4,  512*4,  640*4,
         384*8,  448*8,  512*8,  640*8,
         384*16, 448*16, 512*16, 640*16,
         384*32, 448*32, 512*32, 640*32,
         384*64, 448*64, 512*64, 640*64,
         384*128,448*128,512*128
};

static snd_pcm_hw_constraint_list_t hw_constraints_capture_period_sizes = {
         .count = 31,
         .list = capture_period_sizes,
         .mask = 0
};

static int snd_emu10k1_capture_open(snd_pcm_substream_t * substream)
{
<snip>
snd_pcm_hw_constraint_list(runtime, 0, SNDRV_PCM_HW_PARAM_PERIOD_SIZE, 
&hw_constraints_capture_period_sizes);

<snip>

Has a driver writer, you have full control over these sorts of things.

Cheers
James


-------------------------------------------------------
This SF.Net email is sponsored by: SourceForge.net Broadband
Sign-up now for SourceForge Broadband and get the fastest
6.0/768 connection for only $19.95/mo for the first 3 months!
http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
