From: Mauro Carvalho Chehab <mchehab@osg.samsung.com>
Subject: Re: [PATCH v3 01/22] [media] Docbook: media-types.xml: Add ALSA
 Media Controller Intf types
Date: Wed, 17 Feb 2016 10:19:41 -0200
Message-ID: <20160217101941.0b37ca98@recife.lan>
References: <cover.1455233150.git.shuahkh@osg.samsung.com>
	<363a459c08a1fcaf04052d7f2af05f1dd43de58e.1455233152.git.shuahkh@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <363a459c08a1fcaf04052d7f2af05f1dd43de58e.1455233152.git.shuahkh@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Shuah Khan <shuahkh@osg.samsung.com>, tiwai@suse.com
Cc: clemens@ladisch.de, hans.verkuil@cisco.com, laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com, javier@osg.samsung.com, pawel@osciak.com, m.szyprowski@samsung.com, kyungmin.park@samsung.com, perex@perex.cz, arnd@arndb.de, dan.carpenter@oracle.com, tvboxspy@gmail.com, crope@iki.fi, ruchandani.tina@gmail.com, corbet@lwn.net, chehabrafael@gmail.com, k.kozlowski@samsung.com, stefanr@s5r6.in-berlin.de, inki.dae@samsung.com, jh1009.sung@samsung.com, elfring@users.sourceforge.net, prabhakar.csengg@gmail.com, sw0312.kim@samsung.com, p.zabel@pengutronix.de, ricardo.ribalda@gmail.com, labbott@fedoraproject.org, pierre-louis.bossart@linux.intel.com, ricard.wanderlof@axis.com, julian@jusst.de, takamichiho@gmail.com, dominic.sacre@gmx.de, misterpib@gmail.com, daniel@zonque.org, gtmkramer@xs4all.nl, normalperson@yhbt.net, joe@oampo.co.uk, linuxbugs@vittgam.net, johan@ol
List-Id: alsa-devel@alsa-project.org

Em Thu, 11 Feb 2016 16:41:17 -0700
Shuah Khan <shuahkh@osg.samsung.com> escreveu:

> Add ALSA Media Controller Intf types
> 
> Signed-off-by: Shuah Khan <shuahkh@osg.samsung.com>
> ---
>  Documentation/DocBook/media/v4l/media-types.xml | 40 +++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
> 
> diff --git a/Documentation/DocBook/media/v4l/media-types.xml b/Documentation/DocBook/media/v4l/media-types.xml
> index 751c3d0..3730967 100644
> --- a/Documentation/DocBook/media/v4l/media-types.xml
> +++ b/Documentation/DocBook/media/v4l/media-types.xml
> @@ -193,6 +193,46 @@
>  	    <entry>Device node interface for Software Defined Radio (V4L)</entry>
>  	    <entry>typically, /dev/swradio?</entry>
>  	  </row>
> +	  <row>
> +	    <entry><constant>MEDIA_INTF_T_ALSA_PCM_CAPTURE</constant></entry>
> +	    <entry>Device node interface for ASLA PCM Capture</entry>
> +	    <entry>typically, /dev/snd/pcmC?D?c</entry>
> +	  </row>
> +	  <row>
> +	    <entry><constant>MEDIA_INTF_T_ALSA_PCM_PLAYBACK</constant></entry>
> +	    <entry>Device node interface for ASLA PCM Playback</entry>
> +	    <entry>typically, /dev/snd/pcmC?D?p</entry>
> +	  </row>
> +	  <row>
> +	    <entry><constant>MEDIA_INTF_T_ALSA_CONTROL</constant></entry>
> +	    <entry>Device node interface for ASLA Control</entry>
> +	    <entry>typically, /dev/snd/controlC?</entry>
> +	  </row>
> +	  <row>
> +	    <entry><constant>MEDIA_INTF_T_ALSA_COMPRESS</constant></entry>
> +	    <entry>Device node interface for ASLA Compress</entry>
> +	    <entry>typically, /dev/snd/compr?</entry>
> +	  </row>
> +	  <row>
> +	    <entry><constant>MEDIA_INTF_T_ALSA_RAWMIDI</constant></entry>
> +	    <entry>Device node interface for ASLA Raw MIDI</entry>
> +	    <entry>typically, /dev/snd/midi?</entry>
> +	  </row>
> +	  <row>
> +	    <entry><constant>MEDIA_INTF_T_ALSA_HWDEP</constant></entry>
> +	    <entry>Device node interface for ASLA Hardware Dependent</entry>
> +	    <entry>typically, /dev/snd/hwC?D?</entry>
> +	  </row>
> +	  <row>
> +	    <entry><constant>MEDIA_INTF_T_ALSA_SEQUENCER</constant></entry>
> +	    <entry>Device node interface for ASLA Sequencer</entry>
> +	    <entry>typically, /dev/snd/seq</entry>
> +	  </row>
> +	  <row>
> +	    <entry><constant>MEDIA_INTF_T_ALSA_TIMER</constant></entry>
> +	    <entry>Device node interface for ASLA Timer</entry>
> +	    <entry>typically, /dev/snd/timer</entry>

On all the above:
	s,ASLA,ALSA,

Except for that, patch looks OK for me.

Takashi,

If this is OK for you too, could you please ack?

Thanks,
Mauro
