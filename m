From: Christian Esken <c.esken@cityweb.de>
Subject: Re: [PATCH] cs46xx, SPDIF output fixes, AC3 through IEC958 should work OK
Date: Wed, 5 Mar 2003 01:58:22 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200303050153.10471.c.esken@cityweb.de>
References: <3E62AEEF.7090109@cucumelo.org> <s5hof4slm55.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hof4slm55.wl@alsa2.suse.de>
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

Am Montag, 3. M=E4rz 2003 12:33 schrieb Takashi Iwai:
> At Mon, 03 Mar 2003 02:25:03 +0100,
>
> Benny Sjostrand wrote:
> > - Added the cwcdma DSP firmware module
> > - Fixed a minor bug in cs46xx_iec958_pre_open(...)
> > - in cs46xx_dsp_enable_spdif_hw(...), disable SPDIF hw
> >  before enabling, this seems to help solving the synchronization issu=
e
> > - Some changes in cs46xx_dsp_create_pcm_channel(...)  and
> > cs46xx_dsp_create_src_task_scb(...) to adapt to the new DSP firmware.
> >
> > Well, with the new firmware module I would consider this patch a litt=
le
> > bit experimental ;)
>
> thanks, applied to cvs.
> it's working fine on my DMX x-fire 1024.

Confirmed. It works with my Hercules GameTheater XP7.1
I tried it with xine and option "a52 passthrough". Nice work.

Chris

PS: The only small issue is when pausing the playback. After resuming I h=
ear
scratching noises (the typical ugly SPDIF-out-of-sync noises).
The good news is that the digital out is automatically resynced shortly a=
fter
(about 200ms).




-------------------------------------------------------
This SF.net email is sponsored by: Etnus, makers of TotalView, The debugger 
for complex code. Debugging C/C++ programs can leave you feeling lost and 
disoriented. TotalView can help you find your way. Available on major UNIX 
and Linux platforms. Try it free. www.etnus.com
