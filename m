From: Eliot Blennerhassett <linux@audioscience.com>
Subject: Re: [patch] ALSA: asihpi - off by one in
	asihpi_hpi_ioctl()
Date: Thu, 28 Jul 2011 09:45:22 +1200
Message-ID: <4E3086F2.80606@audioscience.com>
References: <20110727120226.GP3824@shale.localdomain>
	<1311771302.2125.7.camel@osiris>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.clear.net.nz (smtp4.clear.net.nz [203.97.37.64])
	by alsa0.perex.cz (Postfix) with ESMTP id DA5D4243F0
	for <alsa-devel@alsa-project.org>;
	Wed, 27 Jul 2011 23:45:26 +0200 (CEST)
Received: from [192.168.36.2]
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp4.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0LP000K9IHRMEP00@smtp4.clear.net.nz> for
	alsa-devel@alsa-project.org; Thu, 28 Jul 2011 09:45:23 +1200 (NZST)
In-reply-to: <1311771302.2125.7.camel@osiris>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Dan Rosenberg <drosenberg@vsecurity.com>
Cc: Takashi Iwai <tiwai@suse.de>, "open list:SOUND" <alsa-devel@alsa-project.org>, kernel-janitors@vger.kernel.org, Dan Carpenter <error27@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 28/07/11 00:55, Dan Rosenberg wrote:
> On Wed, 2011-07-27 at 15:02 +0300, Dan Carpenter wrote:
>> "adapter" is used as an array index in the adapters[] array so
>> the off by one would make us read past the end.
>>
> 
> Agreed. I also don't like the fact that the "pa" pointer can be set to
> an arbitrary address because the index isn't checked until after its
> assignment. Even though the fix to the check prevents this pointer from
> being dereferenced if it's out-of-bounds, it's still wrong.

:( I have to agree.
I'll submit another patch that avoids doing this.

> I agree.  This code seems to make assumptions in more than one place
> that the adapters array is fully populated with non-NULL elements.  At a
> glance, I can't see where such initialization occurs though.

It does, in void __init asihpi_init(void)
...	memset(adapters, 0, sizeof(adapters));

-- 
Eliot Blennerhassett
AudioScience Inc.
