From: Li Xiubo <Li.Xiubo@freescale.com>
Subject: Re: [PATCHv2 3/8] ARM: dts: Enables SAI ALSA SoC DAI
 device for Vybrid VF610 TOWER board.
Date: Fri, 22 Nov 2013 06:46:49 +0000
Message-ID: <1DD289F6464F0949A2FCA5AA6DC23F828C79F5@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1383289495-24523-1-git-send-email-Li.Xiubo@freescale.com>
 <1383289495-24523-4-git-send-email-Li.Xiubo@freescale.com>
 <87bo1hk2i7.fsf@nbsps.com>
 <1DD289F6464F0949A2FCA5AA6DC23F828AD451@039-SN2MPN1-012.039d.mgd.msft.net>
 <87hab7hxfx.fsf@nbsps.com>
 <1DD289F6464F0949A2FCA5AA6DC23F828B5046@039-SN2MPN1-012.039d.mgd.msft.net>
 <87wqk1hkiv.fsf@nbsps.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe004.messaging.microsoft.com [213.199.154.207])
 by alsa0.perex.cz (Postfix) with ESMTP id DB57D261646
 for <alsa-devel@alsa-project.org>; Fri, 22 Nov 2013 07:46:56 +0100 (CET)
In-Reply-To: <87wqk1hkiv.fsf@nbsps.com>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bill Pringlemeir <bpringlemeir@nbsps.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


> >> +	ret = devm_snd_soc_register_card(&pdev->dev, &fsl_sgt1500_card);
> >> +	if (ret) {
> >> + dev_err(&pdev->dev, "register soc sound card failed :%d\n"
> >> +                               "TWR-AUDIO-SGTL board required.\n",
> >> +				ret);
> >> +		return ret;
> >> +	}
> 
> >> Especially, you can make one kernel that handles both cases w/wo TWR-
> >> AUDIO-SGTL board attached.
> 
> > Yes, it looks nicer.
> 
> > Well, as one log about the CODEC already exists? Should the "TWR-AUDIO-
> SGTL
> > 	board required.\n" log is still needed here ?
> 
> I think that people will understand,
> 
> > vf610-sgtl5000 sound.3: ASoC: CODEC (null) not registered
> > vf610-sgtl5000 sound.3: TWR-AUDIO-SGTL board required.
> 
> As oppose to the typical 'dev_err()' of "register soc sound card
> failed :XXX".  This message looks like something abnormal went wrong.  At
> least 'dev_err()' maybe the wrong level?
> 
> With just the error code, people will have to look through code to
> diagnose this and may just think that something is wrong with the driver.
> It will be a very common case that a user will not have this board.  I
> just think the message could be more explicit to avoid confusion.
>

Yes, I agree.
Well, maybe it not very explicitly points out the actual failling message. And for the tower, the TWR-AUDIO-SGTL board maybe the most likely error case.

>From the ASoC subsystem, we can see that there are more than 2 situations that will return the numeric '-517', and before that there will be one explicit failing message printing out as we have seen.

How about putting this comment in the menuconfig ?

>
> I am not sure if the numeric '-517' will always return in this case; if so,
> the message could be conditional.
> 

The following logs are the situation:
1, Plug in the TWR-AUDIO-SGTL sub-board.
2, Enable the SGTL5000 driver.
3, Disable the CPU DAI driver, here it's the SAI driver.
++++++++++++
sgtl5000 0-000a: sgtl5000 revision 0x11
vf610-sgtl5000 sound.3: ASoC: CPU DAI (null) not registered
vf610-sgtl5000 sound.3: register soc sound card failed :-517
------------
 
And the failed numeric is '-517' too.



> That is just a suggestion.  I know when I booted the TimeSys version of
> Linux and before I looked at the schematic, I didn't know why the codec
> failed to register and I thought I had a u-boot issue and/or the code was
> not working for my board.
> 
> Fwiw,
> Bill Pringlemeir.
> 
> PS: For those not familiar with the tower.  The VF610-TWR has riser cards
> at the sides and different boards can be connected.  The TWR-AUDIO-SGTL
> is another board that needs to be plugged in.
