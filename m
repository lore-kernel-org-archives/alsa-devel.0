From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: alsa driver, repeat playback of buffer contents
Date: Mon, 14 Mar 2005 16:45:20 -0500
Message-ID: <1110836720.15088.3.camel@mindpipe>
References: <200503141530.20339.random.bits@rogers.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <200503141530.20339.random.bits@rogers.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "random.bits" <random.bits@rogers.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 2005-03-14 at 15:30 -0500, random.bits wrote:
> I have been reading up on the alsa driver. I would like 
> to have the alsa driver play a small pcm sound bite 
> over and over without have to re-write it to the 
> device.
> 
> By small, I mean 1.9K in length. I have followed the 
> examples enough to get it to play the sound bite once, 
> but I cannot figure out how to get it to play it 
> multiple times without having to make another call to 
> snd_pcm_writei() again.

Why in the heck are you using write() instead of mmap()?

Lee



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
