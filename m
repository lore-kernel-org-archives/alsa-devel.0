From: Benny Sjostrand <gorm@cucumelo.org>
Subject: Re: es18xx - 1869 not working, debugging ALSA drivers
Date: Tue, 05 Nov 2002 22:56:30 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DC83E8E.1000703@cucumelo.org>
References: <200211052033.16712.kasper@303.nu>
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
To: kasper@303.nu
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>
>
>I've been trying to debug the driver, but it's not really my thing... Maybe 
>there are some handy tricks to debug ALSA drivers? Or is it just:
>1) change the source
>2) compile the source
>3) see if it works (by loading the module.. and playing some audio)
>4) if it doesn't work restart with 1)
>  
>
Yeah,.., I feel familiar with that method -:) I guess I'm not the only one
Probably you can add a point:
 3.5) If the computer totally freezes (course change to the source was 
very wrong and bad) restart computer, and go to 1) + (I hate ext2 
filesystems)

 I don't known any better method, maybe just yet another point:
1.5) review changes yet one more time and go back to 1 or 1.5 a couple 
of times
       to try prevent moment "3.5"

But, stuffs like the tool  "ksymoops", the alsa functions/macros:  
snd_assert(...),
snd_magic_cast(...), snd_printk(...), snd_printdd(...), etc. helps a lot!

/Benny





-------------------------------------------------------
This sf.net email is sponsored by: See the NEW Palm 
Tungsten T handheld. Power & Color in a compact size!
http://ads.sourceforge.net/cgi-bin/redirect.pl?palm0001en
