From: Jose Alberto Reguero <jareguero@telefonica.net>
Subject: Re: Re: VIA 8237 AD1980 Surround 5.1
Date: Sat, 6 Nov 2004 09:01:58 +0100
Message-ID: <200411060901.58167.jareguero@telefonica.net>
References: <200411050906.50688.jareguero@telefonica.net> <200411052154.05985.jareguero@telefonica.net> <yw1x4qk4q6zw.fsf@ford.inprovide.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <yw1x4qk4q6zw.fsf@ford.inprovide.com>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
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

El Viernes, 5 de Noviembre de 2004 23:13, M=E5ns Rullg=E5rd escribi=F3:
> Jose Alberto Reguero <jareguero@telefonica.net> writes:
> > El Viernes, 5 de Noviembre de 2004 11:06, M=E5ns Rullg=E5rd escribi=F3:
> >> Jose Alberto Reguero <jareguero@telefonica.net> writes:
> >> > MB: K8V SE Deluxe
> >> > CPU: AMD64
> >> > Asla driver from cvs.
> >> > Alsa lib from cvs.
> >> > The channel center and LFE ar swapped in surround 5.1.
> >>
> >> What's the magic to get 5.1 in the at all?  I can't seem to get
> >> anything but "ALSA lib pcm_hw.c:408:(snd_pcm_hw_channel_info)
> >> SNDRV_PCM_IOCTL_CHANNEL_INFO failed: Inappropriate ioctl for device"
> >> when running speaker-test.
> >
> > I yust try whith -Dplug:surround51 or -Dsurround51 and in the mixer
> > "Surround JACK as Input" off and "Center/LFE Jack as Input" off and
> > Exchange Front/Surround" off and "Spread Front to Surround and
> > Center/LFE" off.  It works for me with speaker-test and with xine
> > (DVDS).
>
> That's exactly my settings.  The strange thing it that 6-channel
> playback works with -Dsurround40, but the rear and center/lfe are
> swapped. 4-channel playback is correct.
If you have the same sound card (VIA8237) you need the latest cvs drivers a=
nd=20
alsa-lib to recognize de chip properly.
With 1.0.7rc2 don't work well.


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
