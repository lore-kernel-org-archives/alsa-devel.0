From: Benny Sjostrand <gorm@cucumelo.org>
Subject: cs4630 SPDIF input  problem (Re: [PATCH] cs46xx SPDIF
 input && some cleanups && bug fixes)
Date: Wed, 14 Aug 2002 23:50:58 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D5AD0C2.6080107@cucumelo.org>
References: <27526.1029143696@www32.gmx.net>
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
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Friedrich.Ewaldt@gmx.de
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>
>
>SPDIF input works with my Terratec DMX XFire thanks to Benny's newest patch.
>(@Benny: Thanks for remailing the attachment)
>I've got only one minor problem:
>Switching around in alsamixer at the SPDIF controls for some time causes a
>high frequency tone to be played back all the time until I reboot. I'll have
>to do further examinations when this happens exactly.
>regards, fritz_e
>
Now I understand what you was refering to, as finally it has happen to 
me to -;) (... no reason to be happy)
This is yet another problem.

If you umute/mute the SPDIF input while you are playbacking something 
the hole DSP seems to hang, sending
a high frequency tone, probably course some garbage left in the HW FIFO.
So, just dont do that for the moment. Reloading the driver, (or 
rebooting if you want) helps when it happens.

Hopefully I've got a fix for this problem soon.

/Benny





-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
