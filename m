From: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH 2/2] gpio: include linux/gpio.h where needed
Date: Wed, 15 Jun 2011 10:59:01 -0700
Message-ID: <4DF8F2E5.4090705@oracle.com>
References: <4DDB3AFF.9030006@oracle.com>	<20110524075248.GB19734@sirena.org.uk>	<20110527074552.GA907@ponder.secretlab.ca>	<4DDFE391.2030507@oracle.com>	<20110527201201.GA6645@ponder.secretlab.ca>	<BANLkTin-KSVcG2cQfRM3Ys0_g_uJVruDMw@mail.gmail.com>	<20110603171837.GA9918@opensource.wolfsonmicro.com>	<BANLkTi=oko_C8_46Y8p5O1Qvw1KEn-1PjA@mail.gmail.com>	<4DEC4D67.6010506@oracle.com>	<20110614091211.465553de.randy.dunlap@oracle.com>	<20110614161357.GB1839@ponder.secretlab.ca>	<20110614170602.7a51b1af.randy.dunlap@oracle.com> <20110615103420.1578eb5c.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20110615103420.1578eb5c.sfr@canb.auug.org.au>
Sender: linux-next-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Grant Likely <grant.likely@secretlab.ca>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Dmitry Artamonow <mad_soft@inbox.ru>, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, linux-next@vger.kernel.org, Harald Welte <laforge@gnufiish.org>
List-Id: alsa-devel@alsa-project.org

On 06/14/11 17:34, Stephen Rothwell wrote:
> Hi Randy,
> 
> On Tue, 14 Jun 2011 17:06:02 -0700 Randy Dunlap <randy.dunlap@oracle.com> wrote:
>>
>> From: Randy Dunlap <randy.dunlap@oracle.com>
>>
>> Some files use GPIOF_ macros but don't include the header file
>> for them.  These macros are being moved to <linux/gpio.h>, so add
>> includes for <linux/gpio.h> where needed.
> 
> Shouldn't these patches be in the other order to avoid bisection problems?

Hm, I suppose so.

Grant, can you apply these with patch 2/2 first or do I need to resend
the patches?

thanks,
-- 
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
