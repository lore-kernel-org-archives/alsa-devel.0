From: Benny Sjostrand <gorm@cucumelo.org>
Subject: Re: [Alsa-user] cs46xx w/ alsa 0.9.0rc3 on RedHat 7.1 -sysloging
Date: Sat, 21 Sep 2002 15:02:42 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D8C6DF2.60201@cucumelo.org>
References: <3D8BC3F2.A0FB9ED7@cox.net>
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
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: "John E. A." <johnea@cox.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>
>
>Sep 20 17:32:48 JOHN-ANDREWS kernel: ALSA
>../../alsa-kernel/pci/cs46xx/cs46xx_lib.c:767: BUG? (cpcm->pcm_channel)
>(called from d087abc1)
>Sep 20 17:32:48 JOHN-ANDREWS kernel: ALSA
>../alsa-kernel/core/pcm_lib.c:176: BUG: stream = 0, pos = 0xfffffffa,
>buffer size = 0x400, period size = 0x200
>
>  
>
Have the cs46xx driver ever been tested without 
CONFIG_SND_CS46XX_NEW_DSP defined ?
I believe the the old cs46xx code is broken, i've never tested it my self.
The cs46xx_lib.c is becoming dificult to mantain with all #ifdef ... 
#endif, I would prefer
someday remove all the old stuff. Is there any known card that dont work 
with the
new DSP code ??

/Benny



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
