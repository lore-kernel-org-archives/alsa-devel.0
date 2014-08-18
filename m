From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH alsa-lib] Sync enum snd_hwdep_iface_t with
	include/asound/asound.h
Date: Mon, 18 Aug 2014 18:30:00 +0900
Message-ID: <53F1C798.6000801@sakamocchi.jp>
References: <1408264747-26357-1-git-send-email-o-takashi@sakamocchi.jp>
 <s5hegwew53h.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id EB3922654E0
 for <alsa-devel@alsa-project.org>; Mon, 18 Aug 2014 11:30:06 +0200 (CEST)
In-Reply-To: <s5hegwew53h.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Aug 18 2014 17:54, Takashi Iwai wrote:
>> diff --git a/include/hwdep.h b/include/hwdep.h
>> index ab12822..6ec421c 100644
>> --- a/include/hwdep.h
>> +++ b/include/hwdep.h
>> @@ -68,8 +68,13 @@ typedef enum _snd_hwdep_iface {
>>  	SND_HWDEP_IFACE_USX2Y_PCM,	/**< Tascam US122, US224 & US428 raw USB PCM */
>>  	SND_HWDEP_IFACE_PCXHR,		/**< Digigram PCXHR */
>>  	SND_HWDEP_IFACE_SB_RC,		/**< SB Extigy/Audigy2NX remote control */
>> -                
>> -	SND_HWDEP_IFACE_LAST = SND_HWDEP_IFACE_SB_RC  /**< last known hwdep interface */
>> +	SNDRV_HWDEP_IFACE_HDA,		/* HD-audio */
>> +	SNDRV_HWDEP_IFACE_USB_STREAM,	/* direct access to usb stream */
>> +	SNDRV_HWDEP_IFACE_FW_DICE,	/* TC DICE FireWire device */
>> +	SNDRV_HWDEP_IFACE_FW_FIREWORKS,	/* Echo Audio Fireworks based device */
>> +	SNDRV_HWDEP_IFACE_FW_BEBOB,	/* BridgeCo BeBoB based device */
> 
> These must be SND_ prefix.  And don't forget to have doxygen comments
> like others.  Please submit the fixed patch again.

Oh, indeed. I might lose enough notices when posted... Thanks for your
comment.


Regards

Takashi Sakamoto
o-takashi@sakamocchi.jp
