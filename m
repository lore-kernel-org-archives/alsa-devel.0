From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/3] ALSA: pcm: add IEC958 channel status
	update
Date: Thu, 3 Dec 2015 11:13:04 +0000
Message-ID: <20151203111304.GL8644@n2100.arm.linux.org.uk>
References: <1449066126-19431-1-git-send-email-moise.gergaud@st.com>
 <1449066126-19431-2-git-send-email-moise.gergaud@st.com>
 <20151202190036.GD8644@n2100.arm.linux.org.uk>
 <56602046.8070307@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from pandora.arm.linux.org.uk (pandora.arm.linux.org.uk
 [78.32.30.218]) by alsa0.perex.cz (Postfix) with ESMTP id 1B0D8265325
 for <alsa-devel@alsa-project.org>; Thu,  3 Dec 2015 12:13:18 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <56602046.8070307@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Moise Gergaud <moise.gergaud@st.com>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, broonie@kernel.org, arnaud.pouliquen@st.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Thu, Dec 03, 2015 at 11:58:14AM +0100, Moise Gergaud wrote:
> On 12/02/2015 08:00 PM, Russell King - ARM Linux wrote:
> >Again, I'm not happy with this change.  The intention here is that we
> >validate all arguments before we change anything.  This breaks that
> >principle.
> >
> We propose this change for compressed mode (IEC61937/non linear PCM).
> In case of compressed mode, iec958 channel status byte 0 bit1 = 1, then we
> cannot use snd_pcm_create_iec958_consumer.

Why can you not use snd_pcm_create_iec958_consumer() for this case?  You
are allowed to modify the values you get afterwards in order to handle
this case if you so wish to toggle this bit.

However, if you are using data mode, you really should be using the AES
bytes passed by the application through alsalib and into the kernel via
the IEC958 controls.  There are three controls specified for this:

SNDRV_CTL_NAME_IEC958("", PLAYBACK, CON_MASK) - the bits which can be
changed for consumer mode.
SNDRV_CTL_NAME_IEC958("", PLAYBACK, PRO_MASK) - the bits which can be
changed for professional mode.
SNDRV_CTL_NAME_IEC958("", PLAYBACK, DEFAULT) - the value of the changable
bits.

When using this, it is userspace's responsibility to set the sample rate
appropriately for the stream.

The only case to use snd_pcm_create_iec958_consumer() is to generate the
status bytes for PCM audio, where the userspace API doesn't facilitiate
generating and/or passing the AES status bytes.

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
