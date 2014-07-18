From: Kevin Startup <kevin@awcsl.com>
Subject: Re: ALSA SOC Driver (mxs-wm8753)
Date: Fri, 18 Jul 2014 10:14:16 +0000
Message-ID: <d387ffb22ab74e87aff415badb8b4dca@DB4PR07MB252.eurprd07.prod.outlook.com>
References: <3c1cd0154ea542b992e00dce1cfc0a9a@DB4PR07MB252.eurprd07.prod.outlook.com>
 <20140718084415.GA12049@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from emea01-am1-obe.outbound.protection.outlook.com
 (mail-am1lp0016.outbound.protection.outlook.com [213.199.154.16])
 by alsa0.perex.cz (Postfix) with ESMTP id 143682655ED
 for <alsa-devel@alsa-project.org>; Fri, 18 Jul 2014 12:14:18 +0200 (CEST)
In-Reply-To: <20140718084415.GA12049@opensource.wolfsonmicro.com>
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
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

That's great info, thanks very much.  My DT looks like this, inside sound{} I have:

compatible = "fs,imx28-tx28-wm8753", "fsl,mxs-audio-wm8753";
model = "wm8753";
saif-controllers = <&saif0 &saif1>;
audio-controllers = <&i2c0>;
audio-code = <&wm8753>;

Inside i2c0{} I have:

wm8753: wm8753@1a {
    Compatible = "wlf,wm8753";
    reg = <0x1a>;

I have tried changing model to "wm8753-voice" but still get the same error.

Am I changing it in the wrong place?  Or do I need another setting?

I'm very much a beginner at this DT stiff and also configuring and using sound devices so any info you can supply will be of great help.

Many Thanks
Kevin Startup
A.W. Communication Systems Ltd. 
email: kevin@awcsl.com
Tel: +44(0)1697 748717
Fax: +44(0)1697 748778

A.W. Communication Systems Ltd
VAT No. GB 827 4389 00
Registered No. 4891652
Registered Office Crook Barn, The Crook, Roweltown, Carlisle, UK

-----Original Message-----
From: Charles Keepax [mailto:ckeepax@opensource.wolfsonmicro.com] 
Sent: 18 July 2014 09:44
To: Kevin Startup
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] ALSA SOC Driver (mxs-wm8753)

On Tue, Jul 15, 2014 at 09:14:31AM +0000, Kevin Startup wrote:
> Hi there
> 
> I am attempting to configure a Wolfson WM8753 on a Ka-Ro TX28S, I was wondering if you had any success managing this and if you could give me some pointers.  Currently, I think my device tree may be wrong.  I am getting this message on bootup:
> 
> mxs-wm8753 sounds.12: ASoC: CODEC DAI wm8753 not registered
> 

It does indeed sound like your DT is wrong. "wm8753" is not the name of any of the DAIs on the device. The two DAIs are called "wm8753-hifi" and "wm8753-voice".

Thanks,
Charles
