From: Kovalyev Sergey <randoman@list.ru>
Subject: Re: Repost about fm801 tea575x_tuner in 2.6 kernels
Date: Tue, 15 Feb 2005 20:39:50 +0600
Message-ID: <421209B6.3090103@list.ru>
References: <4211C5E9.5010708@list.ru> <Pine.LNX.4.58.0502151115120.1756@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <Pine.LNX.4.58.0502151115120.1756@pnote.perex-int.cz>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:

>On Tue, 15 Feb 2005, Kovalyev Sergey wrote:
>
>  
>
>>Hello all!
>>
>>When I trying to do
>>
>>#modprobe snd_fm801 tea575x_tuner=1
>>
>>I see this thing in my syslog:
>>
>>kernel: videodev: "TEA5757 radio" has no release callback. Please fix 
>>your driver for proper sysfs
>>support, see http://lwn.net/Articles/36850/
>>
>>As far as I understand, this module is not compatible with linux-2.6 
>>kernels, so, how to fix this problem?
>>    
>>
>
>Nope. This message is only warning and completely harmless. The driver
>should work. This patch will remove the warning:
>
>  
>
Hm...
Under 2.4.x kernels I used this command:
modprobe snd_fm801 tea575x_tuner=2
Now, under 2.6, it says that "2" is invalid valut into syslog:
kernel: snd_fm801: `2' invalid for parameter `tea575x_tuner'
So, I trying to use
modprobe snd_fm801 tea575x_tuner=1.
Seems that all ok, even fm says that all ok,
but I hear nothing. Master and Aux channels are unmuted and set to 
maximum value...
(This situation is under 2.6.8.1 with built-in alsa drivers)




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
