From: Raymond <rayau@netvigator.com>
Subject: Re: [ALSA - driver 0001138]: errors when installing au8820 modules
Date: Fri, 26 Aug 2005 17:01:05 +0800
Message-ID: <430EDA51.4060401@netvigator.com>
References: <add360993204c8039097fe7085524651@bugtrack.alsa-project.org> <200508232340.46629.alien999999999@users.sourceforge.net> <430DFC0D.1010502@netvigator.com> <200508251943.10332.alien999999999@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200508251943.10332.alien999999999@users.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alien <alien999999999@users.sourceforge.net>
Cc: alsa-devel@lists.sourceforge.net, Manuel Jander <manuel.jander@gmail.com>
List-Id: alsa-devel@alsa-project.org

Alien wrote:
> Op donderdag 25 augustus 2005 19:12, schreef Raymond:
> 
>>Alien wrote:
>>
>>>anyway, i really need to do the latest tests, i have way too many adb
>>>failures lately.
>>
>>What do you means when you say "adb failures" ? ( any message in system
>>log )
> 
> 
> found one:
> Aug 22 21:55:45 queen kernel: Vortex: vortex_fifo_setadbctrl fail
> 
> after that, i have to restart alsa
> 
> but this is only partly the problem, it's only lately that i see that error 
> when there are problems, before i never saw anything in logs and it still had 
> the same problem
> 
> there is one thing though, i haven't gotten the error where snd-au8810 has 210 
> dependencies anymore.
> 
> if i now have an error with sound, i only have to kill all appl using alsa, 
> and restart alsa (when that dep error was there, i had to reboot to have 
> sound + ps aux crashed the console and lotsa other things, applications using 
> alsa had weird statusses etc...)
> 
> 

We cannot change NR_ADB of au8810 from 16 to 32 or change NR_ADB of 
au8830 from 32 to 16.

http://savannah.nongnu.org/support/?func=detailitem&item_id=102951

This means hw:0,0 of au8810, au8820, au8830 behave differently even they 
have 16 SRC



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
