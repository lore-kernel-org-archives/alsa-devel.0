From: =?gb2312?q?=C0=EE=20=B3=AC?= <flyingwalter@yahoo.com.cn>
Subject: Mute Record Problem!
Date: Sat, 4 Dec 2004 10:20:58 +0800 (CST)
Message-ID: <20041204022058.41207.qmail@web15805.mail.cnb.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,
  I want to mute the Mic's capture switch, but it
seemts that the snd_mixer_selem_set_capture_switch()
only mute the Mic's playback switch. How can I mute
the capture switch if the simple control also has
playback switch?
  The Info of the Mic control produced by amixer is:
	Simple mixer control 'Mic',0
	  Capabilities: pvolume pvolume-joined pswitch
pswitch-joined cswitch cswitch-joined
cswitch-exclusive
	  Capture exclusive group: 0
	  Playback channels: Mono
	  Capture channels: Front Left - Front Right 
	  Limits: Playback 0 - 31 
	  Mono: Playback 10 [32%] [on] 
	  Front Left: Capture [on] 
	  Front Right: Capture [on] 
Regards,
Walter  

=====
Walter Lee

_________________________________________________________
Do You Yahoo!?
150万曲MP3疯狂搜，带您闯入音乐殿堂
http://music.yisou.com/
美女明星应有尽有，搜遍美图、艳图和酷图
http://image.yisou.com
1G就是1000兆，雅虎电邮自助扩容！
http://cn.rd.yahoo.com/mail_cn/tag/1g/*http://cn.mail.yahoo.com/event/mail_1g/


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
