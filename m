From: Anssi Hannula <anssi.hannula@iki.fi>
Subject: Re: Duplicated/weird SND_CHMAP_xx positions
Date: Thu, 14 Nov 2013 02:56:12 +0200
Message-ID: <52841FAC.7030704@iki.fi>
References: <527FB20E.2010606@iki.fi> <s5hmwlarkiy.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from sinikuusama.dnainternet.net (sinikuusama.dnainternet.net
 [83.102.40.134])
 by alsa0.perex.cz (Postfix) with ESMTP id B57B626168C
 for <alsa-devel@alsa-project.org>; Thu, 14 Nov 2013 01:56:15 +0100 (CET)
In-Reply-To: <s5hmwlarkiy.wl%tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

11.11.2013 18:05, Takashi Iwai kirjoitti:
> At Sun, 10 Nov 2013 18:19:26 +0200,
> Anssi Hannula wrote:
[...]
>> We have also these:
>>         SND_CHMAP_BC,           /**< bottom center */
>>         SND_CHMAP_BLC,          /**< bottom left center */
>>         SND_CHMAP_BRC,          /**< bottom right center */
>>
>> I guess "bottom center" is "under the listener" (USB audio v2 spec
>> doesn't clarify, but clearly doesn't use the "Front" specifier as in
>> "front bottom center").
>>
>> However, the last two ones are weird. The descriptions do not make sense
>> to me (under the listener to the left? wouldn't that be "bottom side
>> left" instead?).
>>
>> It seems like they were added by mistake - the only user is the USB
>> audio driver which wrongly uses them for "back left/right center"
>> instead of correct RLC/RRC.
> 
> These are taken from gstreamer definitions.  I'm not quite sure about
> these distinctions, but added just for completeness in any future use
> case.  So, just keep these unused for now.

gst-1.0 has:
  GST_AUDIO_CHANNEL_POSITION_BOTTOM_FRONT_CENTER,
  GST_AUDIO_CHANNEL_POSITION_BOTTOM_FRONT_LEFT,
  GST_AUDIO_CHANNEL_POSITION_BOTTOM_FRONT_RIGHT,

So they are clearly labelled "front" and only the first one is "center".

Your gst patch (at least the ml version I saw) mapped them like this:
+  ITEM(BC, BOTTOM_FRONT_CENTER),
+  ITEM(BLC, BOTTOM_FRONT_LEFT),
+  ITEM(BRC, BOTTOM_FRONT_LEFT),

But I was under the assumption that BC is under the listener instead of
front center, since otherwise it would be "BFC", not "BC".
(though I don't find it unlikely at all that "bottom-center" got to the
USB spec by a mistake... but if it were just a case of missing "front"
specifier, one'd think the spec would have "bottom-front-left" and
"bottom-front-right" as well, which it does not)

Also, clearly BLC is not bottom front left, since the 'C' stands for
"center". Not to mention BRC being right, not left. ;)

So I guess the nonsensical BLC/BRC was just a mistake then... I guess we
can pretend they are between BC and BSL/BSR (bottom side left/right) or
something.

>> For reference, the complete current position list is:
>> /** channel positions */
>> enum snd_pcm_chmap_position {
>>         SND_CHMAP_UNKNOWN = 0,  /**< unspecified */
>>         SND_CHMAP_NA,           /**< N/A, silent */
>>         SND_CHMAP_MONO,         /**< mono stream */
>>         SND_CHMAP_FL,           /**< front left */
>>         SND_CHMAP_FR,           /**< front right */
>>         SND_CHMAP_RL,           /**< rear left */
>>         SND_CHMAP_RR,           /**< rear right */
>>         SND_CHMAP_FC,           /**< front center */
>>         SND_CHMAP_LFE,          /**< LFE */
>>         SND_CHMAP_SL,           /**< side left */
>>         SND_CHMAP_SR,           /**< side right */
>>         SND_CHMAP_RC,           /**< rear center */
>>         SND_CHMAP_FLC,          /**< front left center */
>>         SND_CHMAP_FRC,          /**< front right center */
>>         SND_CHMAP_RLC,          /**< rear left center */
>>         SND_CHMAP_RRC,          /**< rear right center */
>>         SND_CHMAP_FLW,          /**< front left wide */
>>         SND_CHMAP_FRW,          /**< front right wide */
>>         SND_CHMAP_FLH,          /**< front left high */
>>         SND_CHMAP_FCH,          /**< front center high */
>>         SND_CHMAP_FRH,          /**< front right high */
>>         SND_CHMAP_TC,           /**< top center */
>>         SND_CHMAP_TFL,          /**< top front left */
>>         SND_CHMAP_TFR,          /**< top front right */
>>         SND_CHMAP_TFC,          /**< top front center */
>>         SND_CHMAP_TRL,          /**< top rear left */
>>         SND_CHMAP_TRR,          /**< top rear right */
>>         SND_CHMAP_TRC,          /**< top rear center */
>>         SND_CHMAP_TFLC,         /**< top front left center */
>>         SND_CHMAP_TFRC,         /**< top front right center */
>>         SND_CHMAP_TSL,          /**< top side left */
>>         SND_CHMAP_TSR,          /**< top side right */
>>         SND_CHMAP_LLFE,         /**< left LFE */
>>         SND_CHMAP_RLFE,         /**< right LFE */
>>         SND_CHMAP_BC,           /**< bottom center */
>>         SND_CHMAP_BLC,          /**< bottom left center */
>>         SND_CHMAP_BRC,          /**< bottom right center */
>>         SND_CHMAP_LAST = SND_CHMAP_BRC,
>> };
>>
>>
>> -- 
>> Anssi Hannula
>>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 


-- 
Anssi Hannula
