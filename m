From: Raymond <rayau@netvigator.com>
Subject: Re: au88x0 - Replace spdif frequency control by IEC958
 control
Date: Wed, 23 Feb 2005 10:19:58 +0800
Message-ID: <421BE84E.8030201@netvigator.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: openvortex-dev@nongnu.org
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>> 1) What is the difference between Consumer mode and Professional mode ?

> A different set of status bits.  See, for example, ALSA"s asoundef.h,
> but it doesn"t have many explanations.
>
> The main difference is that only consumer mode has the copyright bit
> so that devices can automatically disable copying.


The parameter 'spdif_mode' in the routine 
vortex_spdif_init(vortex,spdif_sr,spdif_mode) in au88x0_core.c seems to 
control AC3 passthrough.

However the two memory mapped I/O VORTEX_SPDIF_CFG0 and 
VORTEX_SPDIF_CFG1 seem to be write-only, return zero when read.

The value of memory mapped I/O VORTEX_SPDIF_FLAGS are changing between 
00138014 and 00138015

1) Which bit in the IEC958 control is related to AC3 passthrough ?

As vortex_spdif_init() only handle changing SPDIF sample rate.

2) Do the driver need to initialise vortex->spdif_sr to 48000 or just 
let alsactl restore the value from /etc/asound.state ?

3) Is it correct to return the following value in 
snd_vortex_spdif_mask_get() ?
ucontrol->value.iec958.status[3] = IEC958_AES3_CON_FS;

4) Is it correct to return the following value in 
snd_vortex_spdif_default_get() ?
ucontrol->value.iec958.status[1] =IEC958_AES1_CON_ORIGINAL | 
IEC958_AES1_CON_DIGDIGCONV_ID;

5) What additional kcontrol and routine are needed for SPDIF IN ?








-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
