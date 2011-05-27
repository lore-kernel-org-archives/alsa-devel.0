From: "Soulard, MathieuX" <mathieux.soulard@intel.com>
Subject: Re: Suspecting a bug in plugin_ops.h
Date: Fri, 27 May 2011 08:41:40 +0100
Message-ID: <9F3EABD6E3419B4C81F34EAABB4D4018817731F2D4@irsmsx501.ger.corp.intel.com>
References: <9F3EABD6E3419B4C81F34EAABB4D4018817731F032@irsmsx501.ger.corp.intel.com>
	<4DDE694C.60700@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
	by alsa0.perex.cz (Postfix) with ESMTP id E6604103804
	for <alsa-devel@alsa-project.org>;
	Fri, 27 May 2011 09:42:34 +0200 (CEST)
In-Reply-To: <4DDE694C.60700@ladisch.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> > static inline u_int32_t sx24s(u_int32_t x)
> > {
> >         if(x&0x00008000)
> >                 return x|0x000000FF;
> >         return x&0xFFFFFF00;
> > }
> >
> > I think that 0x00008000 should be replaced by 0x00000800.
> 
> This function is indented to sign-extended a 24-bit value to 32 bits,
> operating in 'wrong' endianness.
> 
> Why do you think that the sign bit is in the highest bit of the second-
> highest nibble?

Well... because I think I made a mistake !
Actually I missed the endianness here, I thought about another format.

Thanks for your prompt response.


Thanks
Regards

Mathieu
