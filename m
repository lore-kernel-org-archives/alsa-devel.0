From: dustin@seznam.cz
Subject: EMU 1212 - 16 capture channels - patch
Date: Thu, 31 May 2007 23:10:22 +0200 (CEST)
Message-ID: <10237.25995-1467-1914262165-1180645822@seznam.cz>
References: <s5hhcq6p3us.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="MessagePart:1354368814.0-1467-1634406703-1180645822"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mxh.seznam.cz (mxhn.seznam.cz [212.80.76.26])
	by alsa0.perex.cz (Postfix) with SMTP id 06D4C24613
	for <alsa-devel@alsa-project.org>;
	Thu, 31 May 2007 23:10:24 +0200 (CEST)
In-Reply-To: <s5hhcq6p3us.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?us-ascii?Q?Takashi=20Iwai?= <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--MessagePart:1354368814.0-1467-1634406703-1180645822
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset="us-ascii"

Hello,

Here is the patch increasing number of capture channels from 8 to 16. In this patch the unused PCMs are not removed yet, I have not been able to test thoroughly to confirm they are 100% sure useless.

As a next project, I would like to try to raise playback resolution from the current 16bits to 24 (32) bits, using audigy DSP instructions, inversion of the convert32to2x16 function. I would really appreciate comments and suggestions from experts on this card regarding feasibility and possible caveats.

Patch description:

* adding 8 more 32-bit capture channels (total of 16) for emu1010 cards
* adding some code comments and card details description

Signed-off-by: Pavel Hofman <dustin@seznam.cz>


Thans a lot,

Pavel.

>  > I am working together with Ctirad on supporting more capture
>  > channels in E-MU1212. So far we have managed to increase the number
>  > of channels from the default of 8 to 16 (A_FXWC2 = 0xffffffff, added
>  > new snd_emu10k1_audigy_dsp_convert_32_to_2x16 calls in
>  > emufx.c). There is still a number of issues to solve but the 16
>  > channel capture already works fine. 
>  > 
>  > I would like to get your opinion on the form of adding this support
>  > to the module. The options are either hard-coding the 16 capture
>  > channels into the code, assuming that users would prefer as many
>  > channels as possible and do the routing in jack, or introducing a
>  > module parameter emu1010-capture-channels (range e.g. 1 to 16 -
>  > untested yet) and leaving the default number at the existing 8. 
>  
>  I'm for the fixed number 16, as Lee already suggested.
>  It's simpler, and no one would complain that he has too many :)
>  
>  > Furthermore, the PCMs other than efx seem to be of no use for the
>  > EMU-1x1x models, probably fairly confusing for new users. Would you
>  > find it OK, if they were removed for this specific card (if
>  > (emu->card_capabilities->emu1010)), keeping only the playback and
>  > capture PCM id 2?
>  
>  I think it's OK to remove them if they are really useless.
>  But, make sure to change the card->driver name if you do this.
>  Otherwise the same configuration as Audigy2 or whatever will be used
>  and it may result in accessing non-existing devices.
>  
>  > Thanks a lot for your suggestions. Based on them, I will prepare the
>  > patch (with comments on what we found out about the card - it is a
>  > pitty that the driver has almost no big-picture comments on the
>  > supported cards' specifics, making new developers spend a number of
>  > long nights going through the nontrivial code and guessing). 
>  
>  The patches will be definitely appreciated.
>  
>  
>  thanks,
>  
>  Takashi
>  _______________________________________________
>  Alsa-devel mailing list
>  Alsa-devel@alsa-project.org
>  http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>  
>  
>  
--MessagePart:1354368814.0-1467-1634406703-1180645822
Content-Transfer-Encoding: base64
Content-Type: application/gzip;
	name="=?us-ascii?Q?emu1010=2Epatch=2Egz?=";
	charset="us-ascii"
Content-Disposition: attachment;
	filename="=?us-ascii?Q?emu1010=2Epatch=2Egz?="

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

--MessagePart:1354368814.0-1467-1634406703-1180645822
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--MessagePart:1354368814.0-1467-1634406703-1180645822--
