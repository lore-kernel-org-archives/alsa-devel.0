From: David van Hoose <davidvh@cox.net>
Subject: Re: ALSA 0.9.3+ is not working
Date: Tue, 03 Jun 2003 11:54:58 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3EDCC4D2.9030404@cox.net>
References: <Pine.HPX.4.33n.0306030848370.24147-100000@studcom.urz.uni-halle.de>	<3EDC8E54.101@cox.net> <s5hhe77ny2o.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hhe77ny2o.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai wrote:
>>I never muted any of them. Also 0.9.2 works. Using it now in fact. My 
>>motherboard does not exchange jacks.
> 
> 
> please try the cvs version.  perhaps the pcm playback is muted but no
> control was available for c-media chips (it was removed mistakenly).
> right now i added it back.

This worked. Thank you. What files would I need to rip a patch from if I 
need to patch 0.9.4?

Thanks again,
David



-------------------------------------------------------
This SF.net email is sponsored by: eBay
Get office equipment for less on eBay!
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
