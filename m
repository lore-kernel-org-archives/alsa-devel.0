From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: PCM format restrict dilema
Date: Wed, 17 Sep 2003 14:48:44 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F68663C.4050401@superbug.demon.co.uk>
References: <200309161847.h8GIlKtn014678@oud> <3F676332.1000503@superbug.demon.co.uk> <Pine.LNX.4.53.0309170903550.5983@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.53.0309170903550.5983@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Paul Davis <paul@linuxaudiosystems.com>, Takashi Iwai <tiwai@suse.de>, manuel.jander@mat.utfsm.cl, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> On Tue, 16 Sep 2003, James Courtier-Dutton wrote:
> 
> 
>>I would expect to be able to use the "set_period_size_near" with
>>direction +1, so if period_size=buffer_size/8 did not work, the alsa-lib
>>would automatically select the next best one, even if it is
>>buffer_size/2, but this seems to fail as well.
> 
> 
> We found that it fails in the case when buffer_size cannot be divided by
> any value (buffer_size is odd). We cannot do anything to fix it at this
> moment.

Now that bit of infomation helps me a lot. I will therefore not use the 
buffer_time_near function any more, because it might decide on a 
buffer_size odd.

I can also not use buffer_size_near, because that might do the same.
So, I am reduced to using buffer_size together with application level 
retries to get a buffer size close to what I need. The trouble then, is 
that the application cannot access the contraints due to hardware, and 
thus, is really guessing in the dark.

I will also try the save state idea you gave in the last email, so I 
could try the buffer_time_near and period size functions, but it they 
fail use an alternative method. I could even have 3 methods, if method 1 
fails, try method 2, then try method 3. The different methods would 
consist of trying different functions/values based on an educated guess 
as to why the previous values did not work.

A possible solution to all this could be linking the period, periods, 
and buffer_size constraints.

So, the application does the following: -
1) I want there to be 8 periods or less, with a minimum of 2.
2) I want the buffer to be about 500ms long or less, with a minimum or 100ms
3) I want the period size to have a min value of x, and a max value or y.
4) Now calculate the actual sizes based on all the above information. 
(i.e. The buffer_size, and period_size values are not set until stage (4).
At this point, alsa-lib would use the contrains above, and calculate the 
best values for buffer_size and period size based on the above, and also 
what the hardware can do.

The reason I think it might help this way, is because period_size and 
buffer_size and number of periods are all closely linked, so we should 
not have to set them one at a time, but set them as a group.


> 
> 						Jaroslav
> 
> -----
> Jaroslav Kysela <perex@suse.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, SuSE Labs
> 
> 

Cheers
James



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
