From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: Envy24-VT1712 Interrupt by Input Lines
Date: Wed, 23 Apr 2003 14:33:05 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E198Ozh-0007uw-00@sc8-sf-list1.sourceforge.net>
References: <3EA6DA36.77BD0E0D@masirv.com>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Wed, 23 Apr 2003 11:23:50 PDT."
             <3EA6DA36.77BD0E0D@masirv.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Chien Lee <Chien.Lee@mascorp.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>I have a question regarding to how to find out which input line
>(PSDIN0-PSDIN3)
>is interrupting Envy24-VT1712 PCI Audio Controller.
>
>VT1712's Professional Multi-Track Control Register MT00 provides bit 1
>for
>Multi-track record interrupt status. It only shows that there is an
>interrupt occurred
>for recording. It does not indentify which input line is the source. If
>I am recording
>PSDIN1audio signal and there is signal present at PSDIN0, I would get
>interrupted
>and record a wrong signal from PSDIN0.
>
>Is there any way that I can find out which input line is interrupting
>the chip?

either there is something rather subtle about what you are asking, and
i have misunderstood your question, or you don't understand how an
audio interface like the envy24 works. 

if the latter: input lines are not the cause of interrupts. they are
the source of a signal. interrupts are generated when the audio
interface decides to do so, which is generally based on an interval of
time, measured either in audio frames or absolute time, since the last
interrupt. 

if the former: sorry for misunderstanding you.

--p



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
