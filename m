From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [Fwd: Re: [PATCH] cs46xx DAC volume's mechanism
 rewrite, minor bugfixes]
Date: Mon, 11 Nov 2002 18:07:07 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0211111759320.521-100000@pnote.perex-int.cz>
References: <Pine.LNX.4.33L2.0211111327340.14846-100000@cactus>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.33L2.0211111327340.14846-100000@cactus>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Benny Sjostrand <gorm@cucumelo.org>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Mon, 11 Nov 2002, Benny Sjostrand wrote:

> > > Then maybe someone knows what xine uses the
> > > AES0=0x6,AES1=0x82,AES2=0x0,AES3=0x2 values to,
> > > do they need to interfaces to the lowlevel driver ???
> >
> > It's first 32-bits to setup the channel status block in the S/PDIF
> > stream. The main job is to tell the remote receiver, that data are
> > 'non-audio' (bit 1 = 1).
> 
> My first guess, how is this values interfaced to the lowlevel driver ?
> I believe that I dont need to have any "AC3 Mode" switch in the
> mixer if there already is way to know if application is opening
> the IEC958 port for AC3/raw-data.

It's better to have one PCM device dedicated to a raw S/PDIF stream. Then
we have controls to obtain available channel status block bits and 
global / PCM settings:

  IEC958 [...] [Playback|Capture] Default       /* default or global value - read/write */
  IEC958 [...] [Playback|Capture] Mask          /* consumer and professional mask */
  IEC958 [...] [Playback|Capture] Con Mask      /* consumer mask */
  IEC958 [...] [Playback|Capture] Pro Mask      /* professional mask */
  IEC958 [...] [Playback|Capture] PCM Stream    /* the settings assigned to a PCM stream */

The behaviour implemented in drivers is:

- initialize IEC958 channel status block with value SNDRV_PCM_DEFAULT_CON_SPDIF
- raw S/PDIF open: copy default settings to local PCM settings
- (application optional: modify PCM settings - 'IEC958 Playback PCM Stream')
- raw S/PDIF close: return back the global settings

It seems quite complicated, but with many hardware we have 'mixed mode' 
when we need to output a final (mixed from many resources) stream with 
some IEC958 setup and do also ac3-forward (send raw S/PDIF stream). The 
settings for ac3-forward is valid only for one session (open/close) of 
course.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
