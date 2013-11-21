From: Bill Pringlemeir <bpringlemeir@nbsps.com>
Subject: Re: [PATCHv2 3/8] ARM: dts: Enables SAI ALSA SoC DAI
	device for Vybrid VF610 TOWER board.
Date: Thu, 21 Nov 2013 09:55:20 -0500
Message-ID: <87wqk1hkiv.fsf@nbsps.com>
References: <1383289495-24523-1-git-send-email-Li.Xiubo@freescale.com>
 <1383289495-24523-4-git-send-email-Li.Xiubo@freescale.com>
 <87bo1hk2i7.fsf@nbsps.com>
 <1DD289F6464F0949A2FCA5AA6DC23F828AD451@039-SN2MPN1-012.039d.mgd.msft.net>
 <87hab7hxfx.fsf@nbsps.com>
 <1DD289F6464F0949A2FCA5AA6DC23F828B5046@039-SN2MPN1-012.039d.mgd.msft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nsa.nbspaymentsolutions.com
 (71-19-161-253.dedicated.allstream.net [71.19.161.253])
 by alsa0.perex.cz (Postfix) with ESMTP id 41FE8260320
 for <alsa-devel@alsa-project.org>; Thu, 21 Nov 2013 16:00:26 +0100 (CET)
In-Reply-To: <1DD289F6464F0949A2FCA5AA6DC23F828B5046@039-SN2MPN1-012.039d.mgd.msft.net>
 (Li Xiubo's message of "Thu, 21 Nov 2013 02:58:22 +0000")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Li Xiubo <Li.Xiubo@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On 20 Nov 2013, Li.Xiubo@freescale.com wrote:

>> I agree.  I guess the patch set 6 makes more sense.  Also, you might
>> consider adding a printk in the 'fsl_sgtl5000_probe()'.  I guess that
>> devm_snd_soc_register_card() will fail if the board is not present?  

> Yes, you are right.
> The logs:
> +++++++++++
> vf610-sgtl5000 sound.3: ASoC: CODEC (null) not registered
> vf610-sgtl5000 sound.3: register soc sound card failed :-517
> -----------

>> +	ret = devm_snd_soc_register_card(&pdev->dev, &fsl_sgt1500_card);
>> +	if (ret) {
>> + dev_err(&pdev->dev, "register soc sound card failed :%d\n"
>> +                               "TWR-AUDIO-SGTL board required.\n",
>> +				ret);
>> +		return ret;
>> +	}

>> Especially, you can make one kernel that handles both cases w/wo TWR-
>> AUDIO-SGTL board attached.

> Yes, it looks nicer.

> Well, as one log about the CODEC already exists? Should the "TWR-AUDIO-SGTL
> 	board required.\n" log is still needed here ?

I think that people will understand,

> vf610-sgtl5000 sound.3: ASoC: CODEC (null) not registered
> vf610-sgtl5000 sound.3: TWR-AUDIO-SGTL board required.

As oppose to the typical 'dev_err()' of "register soc sound card failed
:XXX".  This message looks like something abnormal went wrong.  At least
'dev_err()' maybe the wrong level?

With just the error code, people will have to look through code to
diagnose this and may just think that something is wrong with the
driver.  It will be a very common case that a user will not have this
board.  I just think the message could be more explicit to avoid
confusion.  I am not sure if the numeric '-517' will always return in
this case; if so, the message could be conditional.

That is just a suggestion.  I know when I booted the TimeSys version of
Linux and before I looked at the schematic, I didn't know why the codec
failed to register and I thought I had a u-boot issue and/or the code
was not working for my board.

Fwiw,
Bill Pringlemeir.

PS: For those not familiar with the tower.  The VF610-TWR has riser
cards at the sides and different boards can be connected.  The
TWR-AUDIO-SGTL is another board that needs to be plugged in.
