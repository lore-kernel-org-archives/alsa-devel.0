From: Bruce Paterson <bruce@tele-ip.com>
Subject: Half Speed on rc6 ?
Date: Mon, 25 Nov 2002 18:36:57 +1100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DE1D319.5040308@tele-ip.com>
References: <3DDC2F86.70102@tele-ip.com> <1037844408.18971.12.camel@saturn> <3DDC7711.1000804@tele-ip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa development <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Bruce Paterson wrote:
> Thanks for your reply Daniel.
> 
> Daniel Haus wrote:
> 
>>> Behaviour:
>>> The output sound is perfect for about 2 minutes. After that every now 
>>> and then I get "distortion" in the audio. No xruns or errors are 
>>> reported in the software. It sounds like only part of the output 
>>> buffer is correct (the general gist is right, but there's crap and 
>>> warbles there as well).
>>
>>
>>
>> this might not be caused by your app, this could be an alsa-problem.
>> i did not do any more testing, but about 24 hours ago i upgraded to
>> 0.9.0-rc6 and had no problems since then, but that might not mean
>> anything ...

I have now tried 0.9.0rc6 and something VERY weird has happened. 
Suddenly the sample rate appears to have halved. A previous 600Hz tone
now is 300Hz and everything takes twices the time to output.
Surely this is a bug that has crept in.

Has anyone else at all used rc6 on the EWS88 and had it work ok ?

Distortion still appears on subsequent runs, but seems to have changed 
its nature a bit. It now sounds like "sand sprinkled on the speaker" 
coming & going. It never happens during the 1st run.

-----------------------------------------------------------------------
Message History:
I have a simple alsa application I have developed that isn't behaving 
quite properly. I mentioned this before, but I have since upgraded to
alsa 0.9.0rc5. Similar problem !

Please let me know if I'm sending thist to the wrong place and where it 
should go instead.

There are mutterings about the place about reverting to a Windows 
development (but frankly it was far worse in other ways). Please help 
save me !  I have run out of ideas how to proceed (gdb is not going to 
help with a random problem like this).

My setup:
alsa 0.9.0rc6
mandrake 8.1
no realtime extensions (no xruns so not required)
ice1712 module with EWS88 sound card
direct hw:0,0 interface (no plugin)
output on 2 channels, input on 4 direct to/from memory
sample rate 96k, buffer size maximum EWS88, period size = buffersize/8
32 bits
interleaved to non-interleaved done by my code since plug-in didn't 
behave originally (this may be historical now).

Behaviour:
The output sound is perfect for about 2 minutes. After that every now 
and then I get "distortion" in the audio. No xruns or errors are 
reported in the software. It sounds like only part of the output buffer 
is correct (the general gist is right, but there's crap and warbles 
there as well).

It makes no difference whether I stop the soundcard and restart or 
whether I keep the soundcard going continueously (feed it 0's whilst
I'm restarting my user buffers), the distortion always starts 
happeneing. Even restarting the application makes no difference which 
leads me to suspect some ememory in the alsa driver.

Waiting about 1 minute before starting again fixes the problem for the 
~2 minutes again.

Playing back to back WAV files with aplay doesn't result in the 
distortion (it is something unique to my application...therefore I'm 
using the API incorrectly somehow !)

[Source code snippet in original email]

-- 
Cheers,
Bruce
-------------------------------------------------------------------
This email and any files transmitted with it are confidential and
intended solely for the use of the individual or entity to whom
they are addressed. If you have received this email in error please
notify the system manager.

     /\\\/\\\/\\\    /   /      Bruce Paterson
    /  \\\ \\\ \\\  /   /    Senior Design Engineer
   /   /\\\/\\\/\\\/   /   87 Peters Ave, Mulgrave, Vic, 3170
  /   /  \\\ \\\ \\\  /  PO Box 4112, Mulgrave, Vic, 3170, Australia
/   /    \\\/\\\ \\\/   Ph: +61 3 8561 4232   Fax: +61 3 9560 9055
       Tele-IP Ltd.      Email: bruce@tele-ip.com    Icq: #32015991
                         WWW:   http://www.tele-ip.com       VK3TJN
-------------------------------------------------------------------




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
