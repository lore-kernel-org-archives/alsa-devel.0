From: Martin Langer <martin-langer@gmx.de>
Subject: a bug in cs4281.c?
Date: Thu, 16 May 2002 21:35:46 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020516193546.GA1600@localhost>
Reply-To: martin-langer@gmx.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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


Hi,

this is the interesting part in cs4281.c:

static snd_pcm_hardware_t snd_cs4281_capture 
[...]
	formats:		SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S8 |
				SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S16_LE |
				SNDRV_PCM_FMTBIT_S16_BE | SNDRV_PCM_FMTBIT_S16_BE |
				SNDRV_PCM_FMTBIT_S32_LE | SNDRV_PCM_FMTBIT_S32_LE |
				SNDRV_PCM_FMTBIT_S32_BE | SNDRV_PCM_FMTBIT_S32_BE,
	rates:			SNDRV_PCM_RATE_CONTINUOUS | SNDRV_PCM_RATE_8000_48000,
[...]


on the other hand the playback section looks wonderful:

	formats:		SNDRV_PCM_FMTBIT_U8 | SNDRV_PCM_FMTBIT_S8 |
				SNDRV_PCM_FMTBIT_U16_LE | SNDRV_PCM_FMTBIT_S16_LE |
				SNDRV_PCM_FMTBIT_U16_BE | SNDRV_PCM_FMTBIT_S16_BE |
				SNDRV_PCM_FMTBIT_U32_LE | SNDRV_PCM_FMTBIT_S32_LE |
				SNDRV_PCM_FMTBIT_U32_BE | SNDRV_PCM_FMTBIT_S32_BE,


One "U" is better than "S" two times in the capture function, or?
... looks like a cut-and-paste-bug;-)



martin



-- 

    /"\
    \ /    ASCII RIBBON CAMPAIGN - AGAINST HTML MAIL
     X                           - AGAINST MS ATTACHMENTS
    / \


_______________________________________________________________

Have big pipes? SourceForge.net is looking for download mirrors. We supply
the hardware. You get the recognition. Email Us: bandwidth@sourceforge.net
