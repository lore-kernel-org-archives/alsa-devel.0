From: Benny Sjostrand <gorm@cucumelo.org>
Subject: Re: [PATCH] cs46xx some few corrections
Date: Wed, 11 Dec 2002 22:50:05 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DF7B30D.7000408@cucumelo.org>
References: <3DF5A135.4090008@cucumelo.org> <3DF5E870.4040806@gmx.de>
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
To: Friedrich Ewaldt <friedrich.ewaldt@gmx.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> Many thanks for this new patch! Now the xrun problems I reported are 
> gone (great!), the SPDIF volume slider works correctly and SPDIF input 
> basically works again.
> There seems to remain one problem with SPDIF input that wasn't there 
> with rc6: With rc6, SPDIF input got out of sync sometimes. 
> Muting+unmuting SPDIF input solved this problem. With the newest 
> driver+last 2 patches, the SPDIF input sound is very distorted. After 
> loading the alsa driver it sounds very 'robotic' (don't know how to 
> describe it :-)) and high frequency components are missing. After 
> muting+unmuting SPDIF input approx. 10 times SPDIF input gets into 
> another state and there are many high frequency distortions. These 
> distortions (not this pure high freq tone, I don't get this anymore) 
> remain whenever I switch on SPDIF input. I didn't manage to get 
> undistorted SPDIF input (which was possible with rc6). 
> Dis-/reconnetcting the SPDIF input cable didn't help either.
> Another issue regarding SPDIF: Digital input works sometimes when I 
> reboot, sometimes it doesn't (restarting alsa doesn't help then) and I 
> have to reboot once again (I don't see a pattern why it does/-not work 
> sometimes). SPDIF input always works when I do a soft reboot from 
> win98, i.e. the card seems to be initialized by the win driver somehow 
> (would some /proc/asound dumps help solving this problem?). Do you 
> have similar problems with your card? Maybe that's terratec xfire 
> specific. Anyone out there with a xfire who can report about SPDIF 
> input with this card?

The SPDIF input problems are known (at least to me) and not specific to 
the xfire card. The main problem is that I dont have enough of technical 
info about to implement the SPDIF input part. The only answer I got from 
a developer at Cirrus regarding the SPDIF input part was something like: 
"yeahh, the SPDIF input needs some special treatments but in this moment 
I dont remember exactly what" now several months has passed and I have 
not heard a single word from Cirrus (got no responses to my mails at all 
anymore ...)

So, so i am afraid that it wont be better than that for the moment ...

/Benny




-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
