From: Benny Sjostrand <gorm@cucumelo.org>
Subject: Re: General CS46xx spdif question
Date: Wed, 09 Oct 2002 21:51:14 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DA488B2.8070505@cucumelo.org>
References: <A1C093A67286D511A159000629E2AAA00B9BED@CCSMAIL>
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
To: =?ISO-8859-1?Q?B=F6ttcher_Marcel?= <MBoettcher@ccsonline.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>
>
>If I unmute the spdif in should the audio automaticaly transfered to the
>speakers if a spdif source is connected or is there a need for a logic
>transfering the data?How can I figure out if the copyright , copy etc flags
>are set?Does it automatically synchronize to the input sample rate?
>  
>
For the moment only 48Khz Stereo is supported by SPDIF input,
and it's not  possible to check the additional bits, copyright, etc. 
with the current driver,
however it's supported by the DSP, just not implemented, and so on, any
fancy thing like Surround 5.1 is not implemented either (yet)

There are currenlty some problems with the SPDIF input parts, the sound
sometimes get's distorcionated, left and right channel sometimes gets 
swapped.

/Benny



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
