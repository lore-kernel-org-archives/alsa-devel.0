From: Friedrich Ewaldt <friedrich.ewaldt@gmx.de>
Subject: Re: [PATCH] cs46xx some few corrections
Date: Tue, 10 Dec 2002 14:13:20 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DF5E870.4040806@gmx.de>
References: <3DF5A135.4090008@cucumelo.org>
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
To: Benny Sjostrand <gorm@cucumelo.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Benny!

Many thanks for this new patch! Now the xrun problems I reported are 
gone (great!), the SPDIF volume slider works correctly and SPDIF input 
basically works again.
There seems to remain one problem with SPDIF input that wasn't there 
with rc6: With rc6, SPDIF input got out of sync sometimes. 
Muting+unmuting SPDIF input solved this problem. With the newest 
driver+last 2 patches, the SPDIF input sound is very distorted. After 
loading the alsa driver it sounds very 'robotic' (don't know how to 
describe it :-)) and high frequency components are missing. After 
muting+unmuting SPDIF input approx. 10 times SPDIF input gets into 
another state and there are many high frequency distortions. These 
distortions (not this pure high freq tone, I don't get this anymore) 
remain whenever I switch on SPDIF input. I didn't manage to get 
undistorted SPDIF input (which was possible with rc6). 
Dis-/reconnetcting the SPDIF input cable didn't help either.
Another issue regarding SPDIF: Digital input works sometimes when I 
reboot, sometimes it doesn't (restarting alsa doesn't help then) and I 
have to reboot once again (I don't see a pattern why it does/-not work 
sometimes). SPDIF input always works when I do a soft reboot from win98, 
i.e. the card seems to be initialized by the win driver somehow (would 
some /proc/asound dumps help solving this problem?). Do you have similar 
problems with your card? Maybe that's terratec xfire specific. Anyone 
out there with a xfire who can report about SPDIF input with this card?

Again, many thanks for your work on this driver!
fe

Benny Sjostrand schrieb:

> Hi!
>
> If the SPDIF input worked with rc6 it should work now with this patch, 
> the SPDIF input "Source Rate Converter"-SCB
> was muted all the time and that should fixed by now.
> I discovered that AC3 almost works but get very easily out of sync in 
> some how (got no solution for this yet)
> Restarting the application about ~ 10 times, eg. with xine press 
> PLAY-STOP PLAY-STOP ... until you get
> sound.
> There was/is actually a ring buffer problem in the cs46xx driver 
> giving this kind of outputs (see my previous mail):
> "Dec 8 13:40:16 cactus kernel: ALSA ../alsa-kernel/core/pcm_lib.c:176: 
> BUG: stream = 0, pos = 0x4000, buffer size = 0x4000, period size = 0x200"
> That should actually be fixed this patch, I hope it's correct.
>
> Sumary of changes:
> - Some volume bug fixes
> - SPDIF input fix.
> - Clear sample buffer after closing IEC958 stream.
> - Ring buffer fix (see my previous mail)
> - Some other misses, corrections ....
>
> /Benny
>





-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
