From: Raymond <rayau@netvigator.com>
Subject: Re: Volume per voices [Feature Request]
Date: Mon, 01 Aug 2005 00:37:26 +0800
Message-ID: <42ECFE46.9070201@netvigator.com>
References: <s5hll3slj32.wl%tiwai@suse.de> <Pine.HPX.4.33n.0507271709230.25935-100000@studcom.urz.uni-halle.de> <42E889DD.2070808@netvigator.com> <Pine.LNX.4.61.0507281032400.8458@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.61.0507281032400.8458@tm8103.perex-int.cz>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> On Thu, 28 Jul 2005, Raymond wrote:
> 
> 
>>In theory, and sound cards with hardware mixing can support this kind of
>>volume control.
>>
> 
> Nope. Please, define the controls at the driver initialization phase and 
> make them inactive when the stream is not open. See emu10k1 or trident 
> driver for hints. You must also map the voice volume with substream 
> number.
> 

Beside volume control, Is it feasible to bind other controls (e.g.
Interaural Time Difference, Interaural Level Difference and SAMPLE RATE 
CONVERTOR - Doppler Effect ) to the substream ?


How can the alsa application access those controls
(SNDRV_CTL_ELEM_IFACE_PCM) using the handle return by snd_pcm_open() ?



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
