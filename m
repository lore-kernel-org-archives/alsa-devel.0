From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Suspecting a bug in plugin_ops.h
Date: Thu, 26 May 2011 16:53:00 +0200
Message-ID: <4DDE694C.60700@ladisch.de>
References: <9F3EABD6E3419B4C81F34EAABB4D4018817731F032@irsmsx501.ger.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 00EFB103AB8
	for <alsa-devel@alsa-project.org>;
	Thu, 26 May 2011 16:50:48 +0200 (CEST)
In-Reply-To: <9F3EABD6E3419B4C81F34EAABB4D4018817731F032@irsmsx501.ger.corp.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Soulard, MathieuX" <mathieux.soulard@intel.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Soulard, MathieuX wrote:
> static inline u_int32_t sx24s(u_int32_t x)
> {
>         if(x&0x00008000)
>                 return x|0x000000FF;
>         return x&0xFFFFFF00;
> }
> 
> I think that 0x00008000 should be replaced by 0x00000800.

This function is indented to sign-extended a 24-bit value to 32 bits,
operating in 'wrong' endianness.

Why do you think that the sign bit is in the highest bit of the second-
highest nibble?


Regards,
Clemens
