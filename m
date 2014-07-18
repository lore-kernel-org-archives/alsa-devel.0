From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: ALSA SOC Driver (mxs-wm8753)
Date: Fri, 18 Jul 2014 11:53:23 +0100
Message-ID: <20140718105323.GB12049@opensource.wolfsonmicro.com>
References: <3c1cd0154ea542b992e00dce1cfc0a9a@DB4PR07MB252.eurprd07.prod.outlook.com>
 <20140718084415.GA12049@opensource.wolfsonmicro.com>
 <d387ffb22ab74e87aff415badb8b4dca@DB4PR07MB252.eurprd07.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 8C1B726084D
 for <alsa-devel@alsa-project.org>; Fri, 18 Jul 2014 13:00:41 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <d387ffb22ab74e87aff415badb8b4dca@DB4PR07MB252.eurprd07.prod.outlook.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kevin Startup <kevin@awcsl.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 18, 2014 at 10:14:16AM +0000, Kevin Startup wrote:
> That's great info, thanks very much.  My DT looks like this, inside sound{} I have:
> 
> compatible = "fs,imx28-tx28-wm8753", "fsl,mxs-audio-wm8753";
> model = "wm8753";
> saif-controllers = <&saif0 &saif1>;
> audio-controllers = <&i2c0>;
> audio-code = <&wm8753>;
> 
> Inside i2c0{} I have:
> 
> wm8753: wm8753@1a {
>     Compatible = "wlf,wm8753";
>     reg = <0x1a>;
> 
> I have tried changing model to "wm8753-voice" but still get the same error.
> 
> Am I changing it in the wrong place?  Or do I need another setting?
> 
> I'm very much a beginner at this DT stiff and also configuring and using sound devices so any info you can supply will be of great help.

How exactly the DT needs to be specified depends on the machine
driver, as it will be what parses the sound node. I would assume
that you are writing this as well? Whatever in there is setting
the codec_dai_name on the dai_link seems to be setting the wrong
value.

Thanks,
Charles
