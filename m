From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: PCM format restrict dilema
Date: Tue, 16 Sep 2003 20:23:30 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F676332.1000503@superbug.demon.co.uk>
References: <200309161847.h8GIlKtn014678@oud>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200309161847.h8GIlKtn014678@oud>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: Takashi Iwai <tiwai@suse.de>, manuel.jander@mat.utfsm.cl, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Paul Davis wrote:
>>I want to try and aim at 8 periods per buffer.
>>Common sense would tell me that one should be able to set the buffer 
>>size first, and then try to set the period size to buffer_size/8. But I 
> 
> 
> why don't you set the sizes based on frame counts, not time? i suspect
> you're more likely to get better results.

If the api for setting based on time it present, I would expect to be 
able to use it.

> 
> 
>>should be able to use the set_period_size_near call so that it selects 
>>the next closest value, so that I achieve a result as close as possible 
>>to what I want. This seems to fail with the current setup on some sound 
>>cards, but works with other sound cards.
> 
> 
> i hope you handle the failure to get buffer_size/8 properly ... you
> need to be willing to go all the way to buffer_size/2 before
> concluding that you can't configure the device.

I would expect to be able to use the "set_period_size_near" with 
direction +1, so if period_size=buffer_size/8 did not work, the alsa-lib 
would automatically select the next best one, even if it is 
buffer_size/2, but this seems to fail as well.

> 
> --p
> 
> 
> 

Cheers
James



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
