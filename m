From: Christian Esken <c.esken@cityweb.de>
Subject: Re: cs64xx distortion (GameTheater XP)
Date: Thu, 16 Jan 2003 20:27:56 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200301162027.57458.c.esken@cityweb.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

Takashi Iwai wrote:

>Christian Esken wrote:
>> 
>> I wonder what the status of the cs64xx distortion problem is.
>> I tested the 2003-01-14.tar.bz2 snapshot with my GameThaeter 7.1 XP
>> and it still shows those heavy distortions on analog output.
>                                
>well, it looks like you passed external_amp=1 option to the module,
>which you don't need usually.
>
>anyway, try the attached patch (and without external_amp=1 option).
>it will clean up the amplifier controls.

Tried it. Unfortunately the patch does not help. Probably the distortion
is slightly less, but still the soundcard is basically unusable.

I removed the external_amp=1 and reloaded the driver - and I sure that
actually the new driver got loaded.

Chris



-------------------------------------------------------
This SF.NET email is sponsored by: Thawte.com
Understand how to protect your customers personal information by implementing
SSL on your Apache Web Server. Click here to get our FREE Thawte Apache 
Guide: http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0029en
