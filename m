From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/2] gpio: include linux/gpio.h where needed
Date: Wed, 15 Jun 2011 13:21:07 -0600
Message-ID: <BANLkTikJ8v-hhvfApJm4Pz0w7-ttiTYADw@mail.gmail.com>
References: <4DDB3AFF.9030006@oracle.com>
	<20110524075248.GB19734@sirena.org.uk>
	<20110527074552.GA907@ponder.secretlab.ca>
	<4DDFE391.2030507@oracle.com>
	<20110527201201.GA6645@ponder.secretlab.ca>
	<BANLkTin-KSVcG2cQfRM3Ys0_g_uJVruDMw@mail.gmail.com>
	<20110603171837.GA9918@opensource.wolfsonmicro.com>
	<BANLkTi=oko_C8_46Y8p5O1Qvw1KEn-1PjA@mail.gmail.com>
	<4DEC4D67.6010506@oracle.com>
	<20110614091211.465553de.randy.dunlap@oracle.com>
	<20110614161357.GB1839@ponder.secretlab.ca>
	<20110614170602.7a51b1af.randy.dunlap@oracle.com>
	<20110615103420.1578eb5c.sfr@canb.auug.org.au>
	<4DF8F2E5.4090705@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yi0-f51.google.com (mail-yi0-f51.google.com
	[209.85.218.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 04FC9103814
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Jun 2011 21:21:29 +0200 (CEST)
Received: by yib2 with SMTP id 2so528914yib.38
	for <alsa-devel@alsa-project.org>; Wed, 15 Jun 2011 12:21:27 -0700 (PDT)
In-Reply-To: <4DF8F2E5.4090705@oracle.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, alsa-devel@alsa-project.org, x86@kernel.org, Dmitry Artamonow <mad_soft@inbox.ru>, Mark Brown <broonie@opensource.wolfsonmicro.com>, LKML <linux-kernel@vger.kernel.org>, linux-next@vger.kernel.org, Harald Welte <laforge@gnufiish.org>
List-Id: alsa-devel@alsa-project.org

On Wed, Jun 15, 2011 at 11:59 AM, Randy Dunlap <randy.dunlap@oracle.com> wr=
ote:
> On 06/14/11 17:34, Stephen Rothwell wrote:
>> Hi Randy,
>>
>> On Tue, 14 Jun 2011 17:06:02 -0700 Randy Dunlap <randy.dunlap@oracle.com=
> wrote:
>>>
>>> From: Randy Dunlap <randy.dunlap@oracle.com>
>>>
>>> Some files use GPIOF_ macros but don't include the header file
>>> for them. =A0These macros are being moved to <linux/gpio.h>, so add
>>> includes for <linux/gpio.h> where needed.
>>
>> Shouldn't these patches be in the other order to avoid bisection problem=
s?
>
> Hm, I suppose so.
>
> Grant, can you apply these with patch 2/2 first or do I need to resend
> the patches?

You don't need to resend.  I'll apply them in the correct order.

g.
