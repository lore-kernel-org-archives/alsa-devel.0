From: Pedro Lopez-Cabanillas <plcl@telefonica.net>
Subject: Re: ALSA 1.0.5
Date: Mon, 31 May 2004 12:58:53 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200405311258.53199.plcl@telefonica.net>
References: <E1BUbHW-0005Wg-PQ@sc8-sf-list2.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E1BUbHW-0005Wg-PQ@sc8-sf-list2.sourceforge.net>
Content-Disposition: inline
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

On Monday 31 May 2004 03:07, I wrote:
> My Gigabyte motherboard's integrated sound interface used to work with this
> driver, but it doesn't with 1.0.5
>
> Any program (amixer info, alsactl restore, alsamixer ...) trying to use the
> control interface hardly hangs, and it is impossible to kill it at all.  
> Modprobe/rmmod works, and doesn't report any problem. No error or debug
> messages at syslog.

The reported problem is solved now, in the CVS.

> Mobo: Gigabyte 7VT600 with chipset VIA KT600
> Sound: Integrated Realtek ALC655 AC97 codec
> http://tw.giga-byte.com/MotherBoard/Products/Products_Spec_GA-7VT600.htm

Anybody using the same hardware should avoid the 1.0.5 driver, IMO. Relevant 
sources are ac97_codec.c and ac97_patch.c. The problem was related to a mutex 
deadlock.

Regards,
Pedro



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
