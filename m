From: Thorsten Haas <thorsten.haas@gmx.de>
Subject: Re: Re: USB recording - repetitive peaks
Date: Thu, 4 Jul 2002 20:59:10 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200207042059.10950.thorsten.haas@gmx.de>
References: <3D208C5C.36649172@ladisch.de> <s5hpty5ry0y.wl@alsa2.suse.de> <3D247676.8090309@boosthardware.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3D247676.8090309@boosthardware.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Patrick, I'll checkout cvs tomorrow morning, compile and test around a bit 
with a rc-generator and the oscilloscope. I'll send the results to the list.

Am Donnerstag, 4. Juli 2002 18:23 schrieb Patrick Shirkey:
> Takashi Iwai wrote:
>  >the hang-up at capture close was at least fixed on cvs.
>  >it was due to the combination of ASYNC_UNLINK and complete callbacks.
>  >
>  >not sure whether the bug with jack is fixed, too, but i think it was
>  >caused by the same reason.  please update the cvs tree.
>
> I can now record successfully using arecord without hanging the system
> but now I get an instant lock up while starting ardour. :( I have a
> suspicion that it happens when ardour registers with jackd and asks for
> the available input devices.  (I'm not sure about the sound quality. I
> will see if I can generate a test tone to use instead of actual music).
>
> The only way to get out of it is reboot using sysreq.
>
> I will check some more. Please note this wasn't happening so quickly
> yesterday.
>
> I'm not sure about the sound quality it is definitely better. I will see
> if I can generate a test tone to use instead of actual music.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Caffeinated soap. No kidding.
http://thinkgeek.com/sf
