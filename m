From: Benny Sjostrand <gorm@cucumelo.org>
Subject: Re: [BUG ?] Crash in the cs46xx driver when using alsaplayer
Date: Mon, 12 Aug 2002 21:42:16 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D580F98.60902@cucumelo.org>
References: <Pine.LNX.4.33.0208122106500.1463-100000@pnote.perex-int.cz>
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
To: Jaroslav Kysela <perex@suse.cz>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

>
>
>>Where is BUG ?, or  in cs46xx driver or in the ALSA PCM core somewhere ?,
>>well, it's easy fixed in snd_cs46xx_playback_copy(...) doing a check.
>>Then why it only happen with the alsaplayer, just no idea ....
>>
>>suggestions ... ?? comments .... ??
>>
>
>playback_copy shouldn't be called after hw_free. I don't see any error in 
>PCM core. The additional check would be dead code. It would be better to 
>determine the real problem. Do you know the order of syscalls?
>
That's exactly my thought.
Adding a check in snd_cs46xx_playback_copy(...) works fine however
it may not be the right solution to the problem.

It only happens to me with the "alsaplayer", so probably the alsaplayer 
is doing something special.
The alsaplayer seems to have various threads:
10826 pts/1    S      0:00 alsaplayer -f 2048
10827 pts/1    S      0:00 alsaplayer -f 2048
10828 pts/1    S      0:00 alsaplayer -f 2048
10830 pts/1    S      0:00 alsaplayer -f 2048
10831 pts/1    S      0:02 alsaplayer -f 2048
10832 pts/1    S      0:00 alsaplayer -f 2048
10834 pts/1    RN     0:00 alsaplayer -f 2048
10835 pts/1    RN     0:00 alsaplayer -f 2048
Maybe the problem is some race condition, just a theory ....

Is there way to debug the PCM core finding out what happens ??

/Benny



-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
