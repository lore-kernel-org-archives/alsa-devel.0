From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: New ALSA Driver
Date: Tue, 08 Mar 2005 15:59:02 -0500
Message-ID: <1110315542.5982.1.camel@mindpipe>
References: <200503082146.24634.k.fetscher@fetron.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <200503082146.24634.k.fetscher@fetron.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: K.Fetscher@t-online.de
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 2005-03-08 at 21:46 +0100, K.Fetscher@t-online.de wrote:
> When I start playing a song with aplay, ALSA calls hw_params(..), prepare(..)  
> and trigger(..) with command SNDRV_PCM_TRIGGER_START. After that, all stops 
> until I make a CTRL C (after that, it terminates with hw_free and close). Is 
> it correct, that runtime->dma_addr is 0 (runtime->size is 1000 and 
> runtime->period is 400) ?
> 

No.  It sounds like the DMA is not being properly started in the
trigger() callback.

Can you post a link to your code?  It's impossible to say what could be
wrong without seeing the source.

Lee



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
