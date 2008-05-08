From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Subject: Re: Embedded I2S / 192khz
Date: Thu, 08 May 2008 15:09:15 +0100
Message-ID: <1210255755.20475.9.camel@odin>
References: <76366b180805080650p615851afi272602115ca1660a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D74FB1037EA
	for <alsa-devel@alsa-project.org>;
	Thu,  8 May 2008 16:09:16 +0200 (CEST)
In-Reply-To: <76366b180805080650p615851afi272602115ca1660a@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Andrew Paprocki <andrew@ishiboo.com>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, 2008-05-08 at 09:50 -0400, Andrew Paprocki wrote:
> Is anyone aware of a Linux/ALSA capable chip that can drive 192khz
> I2S? 

Quite a few codecs can run at 192kHz, although I'm not aware of many SoC
CPU's that will support 192kHz I2S. Your best bet is using a SoC CPU
with a multi-function port (that also does I2S) as they tend to support
faster transfer rates (e.g. SSP on pxa, SSI on i.MX).

> I poked through the ASoC code and could only see 96khz
> capability.
> 

I guess 192kHz is missing from ASoC atm because there is no supported
codec hardware that needs it. Trivial to add.

Liam 
