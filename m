From: Benny Sjostrand <gorm@cucumelo.org>
Subject: Re: SPDIF output finally working properly with CS4630
Date: Wed, 24 Jul 2002 21:59:12 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D3F0710.1060307@cucumelo.org>
References: <3D3DBDA2.10602@cucumelo.org> <20020724013400.GA5214@porky> <3D3E2D08.3070800@cucumelo.org> <20020724181919.GC1681@porky> <3D3EF4CA.1090504@cucumelo.org> <20020724201201.GI1681@porky>
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
To: Peter Heatwole <peter599@gotnet.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>    It's different than your included output, but it's not zero's. And 
> yes,
> I unmuted both entries "IEC958" and "IEC 958" with alsamixer.

The "IEC958" controll is probably there course my incorrect changes in 
ac97_codec.c that should not
be there. The "ICE 958 output" control is the one from cs46xx_lib.c.
Then how does the /proc/asound/card0/dsp_sample looks like when you
playing a .WAV file ?

If your IEC958 is optical and you see a red light it's a good sign.

/Benny



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
