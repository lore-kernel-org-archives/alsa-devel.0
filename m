From: Niek van der Maas <webmaster@refstart.nl>
Subject: Re: Updated: via8233 driver -- testers wanted
Date: Fri, 31 May 2002 11:00:38 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200205311100.38402.webmaster@refstart.nl>
References: <004401c20880$5f095b40$6abc5f86@kermit>
Reply-To: webmaster@refstart.nl
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <004401c20880$5f095b40$6abc5f86@kermit>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: =?iso-8859-1?q?Ren=E9=20Kermis?= <kermis@gmx.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

I've exectly the same problem. When I use "cat /usr/kde/3/hare/sounds/pop=
=2Ewav=20
> /dev/dsp", I get a I/O write error. The only thing that works is playin=
g a=20
CD, I can mute/unmute, set the volume via alsamixer etc.
Bye,

Niek.

On Friday 31 May 2002 11:51, Ren=E9 Kermis wrote:
> Hi,
>
> I can't get the driver (cvs-version 1.18) running on a VT8233A (EPoX
> 8K3A+). I get the following error when trying to play a sound file with
> aplay:
>
> ALSA lib pcm_hw.c:413:(snd_pcm_hw_drain) SNDRV_PCM_IOCTL_DRAIN failed:
> Input/Output error
>
> dmesg-output:
>
> ALSA ../alsa-kernel/core/pcm_lib.c:1871: playback write error (DMA or I=
RQ
> trouble?)
> ...
> ALSA ../alsa-kernel/core/pcm_native.c:1093: playback drain error (DMA o=
r
> IRQ trouble?)
>
>
> Any suggestions?
> Ren=E9
>
>
> _______________________________________________________________
>
> Don't miss the 2002 Sprint PCS Application Developer's Conference
> August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel


_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
