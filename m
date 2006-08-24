From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Subject: Re: [PATCH] sparc dbri: hardware constrains added
Date: Thu, 24 Aug 2006 08:14:20 +0200
Message-ID: <44ed43bc99399@wp.pl>
References: <44eb445108302@wp.pl>
Content-Type: multipart/mixed; boundary="===============1295162755=="
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

--===============1295162755==

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
X-User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; pl; rv:1.8.0.6) Gecko/20060728 Firefox/1.5.0.6
X-WP-IP: 83.17.101.58
X-WP-AV: skaner antywirusowy poczty Wirtualnej Polski S. A.
X-WP-SPAM: NO AS1=NO AS2=NO(0.500016) AS3=NO AS4=NO AS5=NO                                                             



Dnia 23-08-2006 o godz. 20:18 Takashi Iwai napisa³(a):
> Perhaps the PCM middle layer detected XRUN (e.g. due to invalid DMA
> pointer) and automatically restarted? 

I will chekc this. The returned values I saw were 0 or the 1
period length (much smaller then the buffer size).


> Is prepare called between the frequent triggers?
> 

Yes, it is called between triggers.

Regards,
Krzysztof


----------------------------------------------------
Za³ó¿ konto. Przelewy - 0z³. Darmowe konto oszczêdno¶ciowe - 3,25%!
Sprawd¼ i wygraj Toyotê Aygo! >> Kliknij:
http://klik.wp.pl/?adr=http%3A%2F%2Fadv.reklama.wp.pl%2Fas%2Fing22.html&sid=854




--===============1295162755==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1295162755==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1295162755==--
