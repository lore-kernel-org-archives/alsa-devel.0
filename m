From: pavelni@volny.cz
Subject: Help with LATENCY FULL DUPLEX AUDIO
Date: Fri, 26 Apr 2002 00:04:20 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <8d9365b00c929cc7d563e23ef033fea7@www1.mail.volny.cz>
Mime-Version: 1.0
Content-Type: TEXT/plain; charset=iso-8859-2
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello,
I am just working (finishing) on modular realtime effect procesor. It
is my thesis project. I would like to ask three questions:

1.
How can I calculate the latency in ms with OSS driver?

2.
My program do the effects on audio in realtime.
So I added recording the sound to hard disk.
This work ok. But when I play back the recorded sound (from HD), it
changes me buffer length that latency is very big. My solution to
this problem was to close device and
initalize same device one more time after playing the sound.
Is there better solution for me?

3.
Is there some advices how to set the lowest latency?

                      Thanks very for helpfull answer
                                 Pavel
                      http://home.vsb.cz/pn
