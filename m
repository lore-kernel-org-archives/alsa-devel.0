From: Tobin Davis <tdavis@dsl-only.net>
Subject: Re: Intel HDA pin-config values (patch_sigmatel.c)
	-	Dell Inspiron 1721 (also 1521?) mic
Date: Sat, 11 Aug 2007 09:28:17 -0700
Message-ID: <1186849698.5512.33.camel@razman.gruemaster.com>
References: <46BDD4B1.7030507@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from iron2.pdx.net (iron2.pdx.net [69.64.224.71])
	by alsa0.perex.cz (Postfix) with ESMTP id 9224510393B
	for <alsa-devel@alsa-project.org>;
	Sat, 11 Aug 2007 18:28:20 +0200 (CEST)
In-Reply-To: <46BDD4B1.7030507@gmx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Thorsten Riess <tcriess@gmx.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I have some spare time this weekend to review this.  Could you sent me
the output from
http://bulletproof.servebeer.com/alsa/scripts/alsa-info.sh ?  Let's take
this off-list and see if I can get it working for you.

For Sigmatel codecs, I usually get the pin configurations directly from
the Windows INI file for the driver.  Most of the time, this works very
well.

Tobin



On Sat, 2007-08-11 at 16:24 +0100, Thorsten Riess wrote:

> Hi,
> 
> I am wondering where the values of ref9205_pin_configs in patch_sigmatel
> come from. The SigmaTel documentation gives different reference values for
> the 9205.
> The set of values I use at the moment is
> static unsigned int ref9205_pin_configs[12] = {
> 	0x02214020, 0x02a19041, 0x40000100, 0x40000100,
> 	0x40000100, 0x40000100, 0x40000100, 0x40000100,
> 	0x10a000f0, 0x50a000f0, 0x01441030, 0x01c41030
> };
> (the first two are actually from the SigmaTel document, the other just mute
> the remaining in/outs)
> These numbers actually work quite well for the Dell Inspiron 1721 (and
> probably for the 1521), even the mic input works - although the quality
> could be better and the input levels have to be adjusted carefully.
> Can anybody confirm this?
> Thorsten.
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

-- 
Tobin Davis <tdavis@dsl-only.net>
