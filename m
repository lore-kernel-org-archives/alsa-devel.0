From: Dan Tihelka <dtihelka@kky.zcu.cz>
Subject: Re: Build-in mixer
Date: Wed, 15 Oct 2003 14:10:30 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F8D3936.2080106@kky.zcu.cz>
References: <200310151124.h9FBOunu021717@oud>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200310151124.h9FBOunu021717@oud>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org



Paul Davis wrote:

>>	Starting to open device ....
>>	Opening user device: --default--
>>	Xlib: unexpected async reply (sequence 0x963)!
>>    
>>
>
>your program uses threads, right? or it forks at some point? and your
>alsa_error() function involves calls to GUI functions? this error is from
>Xlib, it has nothing to do with ALSA. its caused by having multiple
>threads/processes making GUI calls without user-space
>synchronization. most toolkits recommend that you do not do this, and
>instead use a single thread for all GUI calls. you also cannot share a
>connection to an X server between two processes.
>  
>
Well, i am not author of this program actually. It is xmms plugin 
allowing  to use ALSA for sound output (alsa-xmms-0.9). I only wanted to 
modify it, to be able to use dmix. I see, that it is out of my abilities 
:-(  and, so i will have to conctact the author of it and ask him to 
correct it. It is pitty, because it will take time (if they ever do it). 
I thought, that ALSA interface is not dependent on way, how it is opened 
(because the same code with "hw:0:0" instead of "default" worked 
perfectly) or did not i comprehend anything?. I would like to 
understant, why opening "hw:0:0" works and only replacing it by 
"default" does not. It seems to mee very dificult for developpers....

Thank you for all answers,

Dan




-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
SourceForge.net hosts over 70,000 Open Source Projects.
See the people who have HELPED US provide better services:
Click here: http://sourceforge.net/supporters.php
