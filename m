From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: status pointer's problem with dmix.
Date: Thu, 18 Sep 2003 13:48:11 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F69A98B.5020106@superbug.demon.co.uk>
References: <3F68A8F9.6010605@superbug.demon.co.uk> <Pine.LNX.4.53.0309181144020.5983@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.53.0309181144020.5983@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> On Wed, 17 Sep 2003, James Courtier-Dutton wrote:
> 
> 
>>Output from sending stereo sound to the "dmix" device.
>>bash-2.05b# cat status
>>state: RUNNING
>>trigger_time: 1063822024.640173000
>>tstamp      : 1063822060.456968000
>>delay       : -1719463
>>avail       : 1731463
>>avail_max   : 1731463
>>-----
>>hw_ptr      : 1719463
>>appl_ptr    : 0
>>bash-2.05b#
>>
>>Output from sending stereo sound to the "front" device.
>>bash-2.05b# cat status
>>state: RUNNING
>>trigger_time: 1063823309.038609000
>>tstamp      : 1063823320.869677000
>>delay       : 14161
>>avail       : 2223
>>avail_max   : 3586
>>-----
>>hw_ptr      : 567983
>>appl_ptr    : 582144
>>
>>As you can see, the "front" device acts correctly, with all the pointers
>>acting as they should.
>>But with "dmix", all the pointers are wrong.
>>This is particularly problematic for me, as I need a properly
>>functioning "delay" value for my application.
>>
>>This is using alsa from 2.6test5 kernel.
> 
> 
> This is absolutely ok. The device is running in no-xrun mode, because
> multi-applications have access to it. The dmix plugin has own hw_ptr and
> appl_ptr for each instance and mangles the information from kernel to
> correct values to follow the ALSA API.
> 
> What is your problem? The resolution of the dmix plugin is always one
> period (to make things faster), but it's not a problem to add the slow
> calls.
> 
> 						Jaroslav
> 
> -----
> Jaroslav Kysela <perex@suse.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, SuSE Labs
> 
> 

The problem is that my application relies on a correct "delay" value, so 
that it can use it to keep sound/video in sync.

An example of more status output while playing a .wav file with aplay -D 
dmix. Each "cat status" is typed in quickly after each other.

bash-2.05b# cat status
state: RUNNING
trigger_time: 1063888806.325296000
tstamp      : 1063888809.954270000
delay       : -174225
avail       : 186225
avail_max   : 186225
-----
hw_ptr      : 174225
appl_ptr    : 0
bash-2.05b# cat status
state: RUNNING
trigger_time: 1063888806.325296000
tstamp      : 1063888810.491712000
delay       : -200026
avail       : 212026
avail_max   : 212026
-----
hw_ptr      : 200026
appl_ptr    : 0
bash-2.05b# cat status
state: RUNNING
trigger_time: 1063888806.325296000
tstamp      : 1063888811.036897000
delay       : -226198
avail       : 238198
avail_max   : 238198
-----
hw_ptr      : 226198
appl_ptr    : 0

As you can see, the sound is being played, and comes out of the 
speakers, and there are no xruns, because if there were I would hear them.
For the "dmix" device.
As the buffer size is 12000, avail/avail_max should never reach a value 
 > buffer_size.
delay should never reach a size > buffer_size (12000).

My guess is that delay = appl_ptr - hw_ptr, and thus the reason for it 
being negative.

Cheers
James



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
