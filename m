From: Prince John <princejohnm@yahoo.com>
Subject: Playback/Record speed mismatch
Date: Wed, 17 Sep 2003 07:48:40 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030917144840.65581.qmail@web11701.mail.yahoo.com>
References: <200309171422.h8HEMUVi016116@oud>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200309171422.h8HEMUVi016116@oud>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,
I have a Hitachi SH4 based embedded system with AD1881
codec. I have developed an ALSA driver for it and it
is functional. Now there is a problem that, the .wav
files when played back with 'aplay' are played back in
twice the speed. i.e, a .wav file of 48000 sample rate
and S16_LE format playsback in twice the speed than
expected. But if I set the the AD1881 DAC rate to
24000, the playback is fine. For recording also, I
have noticed the same speed difference (2:1) when I
play back the recorded file on a Windows PC. This
speed mismatch is seen for all sample rates. I hope I
have to set the playback/record rate as the DAC/ADC
rate. If so, why is this mismatch in speed?

Also, the I get 'unaligned access', or system hangs
when I use rate 44100 for rec/playback with 'aplay'
application.

I use alsa release 0.9.1
Please help me with your valuable suggestions.

Thanks,
Prince


__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
