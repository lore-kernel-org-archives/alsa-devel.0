From: =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Subject: Re: VIA 8237 AD1980 Surround 5.1
Date: Fri, 05 Nov 2004 18:30:49 +0100
Message-ID: <yw1xu0s4qk3a.fsf@ford.inprovide.com>
References: <200411050906.50688.jareguero@telefonica.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200411050906.50688.jareguero@telefonica.net> (Jose Alberto
 Reguero's message of "Fri, 5 Nov 2004 09:06:50 +0100")
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jose Alberto Reguero <jareguero@telefonica.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Jose Alberto Reguero <jareguero@telefonica.net> writes:

> MB: K8V SE Deluxe
> CPU: AMD64
> Asla driver from cvs.
> Alsa lib from cvs.
> The channel center and LFE ar swapped in surround 5.1.
> I apply the patch:
>         ttable.1.1 1
>         ttable.2.4 1
>         ttable.3.5 1
> -       ttable.4.2 1
> -       ttable.5.3 1
> +       ttable.4.3 1
> +       ttable.5.2 1
>         slave.pcm {
>                 type hooks
>                 slave.pcm {
> in the file:
> /etc/alsa/cards/VIA8237.conf
> and it works.
> Also the mixer controls Center an LFE ar swapped.

I'm playing with speaker-test, and device surround40 works with 4
channels.  Using device surround40 with 6 channels gives no errors,
but the speakers sounding don't match the messages.  The rear is
swapped with center/lfe.  Using device surround51 tells me "ALSA lib
pcm_hw.c:408:(snd_pcm_hw_channel_info) SNDRV_PCM_IOCTL_CHANNEL_INFO
failed: Inappropriate ioctl for device"

This is an Asus P4V8X-X MB.

--=20
M=E5ns Rullg=E5rd
mru@inprovide.com


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
