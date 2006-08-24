From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Subject: Re: [PATCH] sparc dbri: hardware constrains added
Date: Thu, 24 Aug 2006 21:05:37 +0200
Message-ID: <44edf881a7bf1@wp.pl>
References: <44eb445108302@wp.pl>
Content-Type: multipart/mixed; boundary="===============1958279788=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

--===============1958279788==

<s5hhd03ssdo.wl%tiwai@suse.de>
<44ec33bc0f4e0@wp.pl> <s5hhd03wc1p.wl%tiwai@suse.de>
In-reply-to: <44eb445108302@wp.pl>
<s5hhd03ssdo.wl%tiwai@suse.de>
<44ec33bc0f4e0@wp.pl> <s5hhd03wc1p.wl%tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
X-Mailer: Interfejs WWW poczty Wirtualnej Polski
Organization: Poczta Wirtualnej Polski S.A. http://www.wp.pl/
X-User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.4a) Gecko/20030401
X-WP-IP: 213.76.88.67
X-WP-AV: skaner antywirusowy poczty Wirtualnej Polski S. A.
X-WP-SPAM: NO AS1=NO AS2=NO(0.500004) AS3=NO AS4=NO AS5=NO                                                             



Dnia 23-08-2006 o godz. 20:18 Takashi Iwai napisa³(a):
> At Wed, 23 Aug 2006 12:53:48 +0200,
> Krzysztof Helt wrote:
> > I started testing the OSS layer and it does not work on sparc32.
> > Is it something broken in the OSS layer for sparc or it is likely
> > a driver issue?
> > 
> > Before my series of patches, I got no sound through the OSS
> > layer. With the patches I got sound but it is played too fast and
> > deformed (random jumps in music play).  I found the OSS layer
> > works by continously starting and stoping sound after each block
> > to send. Is it normal behaviour?
> 
> Doesn't look so.
> 
> Perhaps the PCM middle layer detected XRUN (e.g. due to invalid DMA
> pointer) and automatically restarted? 
> Is prepare called between the frequent triggers?
> 
> 
With the patch I have posted today it is easy to find the pattern
with OSS layer:
1. prepare is called.
2. sound start trigger is called.
3. The driver issues a proper command to a DMA controller.
4. The intterrupt comes which says that DMA controller processed
the sent command.
5. pointer is called and return 0
6. sound stop trigger is called
7. The driver issues a command to stop the DMA controller.
8. The step 1 repeats.

The only difference using the aplay command is that it ignores 0
pointer returned in step 5 and a moment later an interrupt comes
which reports the first period sent by the DMA controller.

Any thoughts whats is wrong with the OSS layer or driver?

Regards,
Krzysztof


----------------------------------------------------
Najlepsze siatkarki pla¿owe ¶wiata w Warszawie!
Miêdzynarodowy turniej GE Money Bank Warsaw Open 2006 
Agrykola 30.08-03.09.2006 -> Wstêp wolny -> Szczegó³y:
http://klik.wp.pl/?adr=www.warsaw-beachvolley.pl&sid=850




--===============1958279788==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1958279788==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1958279788==--
