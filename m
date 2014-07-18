From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: ALSA SOC Driver (mxs-wm8753)
Date: Fri, 18 Jul 2014 09:44:15 +0100
Message-ID: <20140718084415.GA12049@opensource.wolfsonmicro.com>
References: <3c1cd0154ea542b992e00dce1cfc0a9a@DB4PR07MB252.eurprd07.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 090A52655D5
 for <alsa-devel@alsa-project.org>; Fri, 18 Jul 2014 10:44:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <3c1cd0154ea542b992e00dce1cfc0a9a@DB4PR07MB252.eurprd07.prod.outlook.com>
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

On Tue, Jul 15, 2014 at 09:14:31AM +0000, Kevin Startup wrote:
> Hi there
> 
> I am attempting to configure a Wolfson WM8753 on a Ka-Ro TX28S, I was wondering if you had any success managing this and if you could give me some pointers.  Currently, I think my device tree may be wrong.  I am getting this message on bootup:
> 
> mxs-wm8753 sounds.12: ASoC: CODEC DAI wm8753 not registered
> 

It does indeed sound like your DT is wrong. "wm8753" is not the
name of any of the DAIs on the device. The two DAIs are called
"wm8753-hifi" and "wm8753-voice".

Thanks,
Charles
