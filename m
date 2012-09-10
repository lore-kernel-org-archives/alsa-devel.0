From: Fengguang Wu <fengguang.wu@intel.com>
Subject: Re: [PATCH] HDA-Intel: Fix wrong CTLINDEX entries for
	HBR Passthrough
Date: Mon, 10 Sep 2012 11:46:01 +0800
Message-ID: <20120910034601.GA31239@localhost>
References: <1346898800-13951-1-git-send-email-xingchao.wang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 9851E264F15
 for <alsa-devel@alsa-project.org>; Mon, 10 Sep 2012 05:46:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1346898800-13951-1-git-send-email-xingchao.wang@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Wang Xingchao <xingchao.wang@intel.com>
Cc: tiwai@suse.de, anssi.hannula@iki.fi, alsa-devel@alsa-project.org, alanwww1@xbmc.org
List-Id: alsa-devel@alsa-project.org

On Thu, Sep 06, 2012 at 10:33:20AM +0800, Wang Xingchao wrote:
> >From Anssi Hannula:
> "The CTLINDEX=x values in /usr/share/alsa/cards/HDA-Intel.conf are off
> when you have S/PDIF output in the same card as HDMI, which is often the case
> on Intel.
> 
> The workaround is to bump all the CTLINDEX=x values one step up in the
> HDA-Intel.pcm.hdmi.foo entries, i.e.
> CTLINDEX=0 => CTLINDEX=1
> CTLINDEX=1 => CTLINDEX=2
> etc, in the /usr/share/alsa/cards/HDA-Intel.conf."

Hmm.. my T420 does not have SPDIF and could possibly be broken by this
change.

        wfg ~% amixer controls
        numid=2,iface=MIXER,name='Master Playback Switch'
        numid=1,iface=MIXER,name='Master Playback Volume'
        numid=23,iface=MIXER,name='PCM Playback Volume'
        numid=5,iface=MIXER,name='Capture Switch'
        numid=4,iface=MIXER,name='Capture Volume'
        numid=8,iface=MIXER,name='IEC958 Playback Con Mask'
        numid=13,iface=MIXER,name='IEC958 Playback Con Mask',index=1
        numid=18,iface=MIXER,name='IEC958 Playback Con Mask',index=2
        numid=9,iface=MIXER,name='IEC958 Playback Pro Mask'
        numid=14,iface=MIXER,name='IEC958 Playback Pro Mask',index=1
        numid=19,iface=MIXER,name='IEC958 Playback Pro Mask',index=2

==>     numid=10,iface=MIXER,name='IEC958 Playback Default'
==>     numid=15,iface=MIXER,name='IEC958 Playback Default',index=1
==>     numid=20,iface=MIXER,name='IEC958 Playback Default',index=2

        numid=11,iface=MIXER,name='IEC958 Playback Switch'
        numid=16,iface=MIXER,name='IEC958 Playback Switch',index=1
        numid=21,iface=MIXER,name='IEC958 Playback Switch',index=2
        numid=3,iface=MIXER,name='Analog Mic Boost Capture Enum'
        numid=7,iface=MIXER,name='Beep Playback Switch'
        numid=6,iface=MIXER,name='Beep Playback Volume'
        numid=24,iface=MIXER,name='Digital Capture Volume'
        numid=12,iface=PCM,name='ELD',device=3
        numid=17,iface=PCM,name='ELD',device=7
        numid=22,iface=PCM,name='ELD',device=8

Thanks,
Fengguang

> Signed-off-by: Wang Xingchao <xingchao.wang@intel.com>
> ---
>  src/conf/cards/HDA-Intel.conf |    8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/src/conf/cards/HDA-Intel.conf b/src/conf/cards/HDA-Intel.conf
> index d4f2667..7d6de8f 100644
> --- a/src/conf/cards/HDA-Intel.conf
> +++ b/src/conf/cards/HDA-Intel.conf
> @@ -211,7 +211,7 @@ HDA-Intel.pcm.hdmi.0 {
>  			"cards.HDA-Intel.pcm.hdmi.common:"
>  			"CARD=" $CARD ","
>  			"DEVICE=3,"
> -			"CTLINDEX=0,"
> +			"CTLINDEX=1,"
>  			"AES0=" $AES0 ","
>  			"AES1=" $AES1 ","
>  			"AES2=" $AES2 ","
> @@ -234,7 +234,7 @@ HDA-Intel.pcm.hdmi.1 {
>  			"cards.HDA-Intel.pcm.hdmi.common:"
>  			"CARD=" $CARD ","
>  			"DEVICE=7,"
> -			"CTLINDEX=1,"
> +			"CTLINDEX=2,"
>  			"AES0=" $AES0 ","
>  			"AES1=" $AES1 ","
>  			"AES2=" $AES2 ","
> @@ -257,7 +257,7 @@ HDA-Intel.pcm.hdmi.2 {
>  			"cards.HDA-Intel.pcm.hdmi.common:"
>  			"CARD=" $CARD ","
>  			"DEVICE=8,"
> -			"CTLINDEX=2,"
> +			"CTLINDEX=3,"
>  			"AES0=" $AES0 ","
>  			"AES1=" $AES1 ","
>  			"AES2=" $AES2 ","
> @@ -280,7 +280,7 @@ HDA-Intel.pcm.hdmi.3 {
>  			"cards.HDA-Intel.pcm.hdmi.common:"
>  			"CARD=" $CARD ","
>  			"DEVICE=9,"
> -			"CTLINDEX=3,"
> +			"CTLINDEX=4,"
>  			"AES0=" $AES0 ","
>  			"AES1=" $AES1 ","
>  			"AES2=" $AES2 ","
> -- 
> 1.7.9.5
