From: Thorsten Haas <thorsten.haas@gmx.de>
Subject: Re: quattro multi plugin.
Date: Sat, 20 Jul 2002 01:44:53 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200207200144.53693.thorsten.haas@gmx.de>
References: <3D37BBBA.7030308@boosthardware.com> <3D381A7F.4090708@boosthardware.com> <s5hd6tjr4g9.wl@alsa2.suse.de>
Reply-To: mail@thorstenhaas.de
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hd6tjr4g9.wl@alsa2.suse.de>
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

uhm, do I get you right; it is now possible to record from usb-quattro using 
FOUR channels simultanously?

Am Freitag, 19. Juli 2002 19:51 schrieb Takashi Iwai:
> At Fri, 19 Jul 2002 22:56:15 +0900,
>
> Patrick Shirkey wrote:
> > This is wierd. Using the exact same commands I cannot get jackd to load
> > now. The card still, ahem, works, cough, with a single pcm device.
>
> how about the asoundrc attached below?
> this will map hw:2,1 and hw:2,2 as 4 channels pcm.
> i thought that these two devices correspond to 96kHz, so you need to
> specify other frequency for jackd.
>
>
> Takashi

-- 
mailto:mail@thorstenhaas.de
http://www.thorstenhaas.de 


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
