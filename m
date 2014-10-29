From: "Wang, Yalin" <Yalin.Wang@sonymobile.com>
Subject: RE: [PATCH] 6fire: Convert byte_rev_table uses to bitrev8
Date: Wed, 29 Oct 2014 11:10:08 +0800
Message-ID: <35FD53F367049845BC99AC72306C23D103E010D1825E@CNBJMBX05.corpusers.net>
References: <35FD53F367049845BC99AC72306C23D103E010D18254@CNBJMBX05.corpusers.net>
	 <35FD53F367049845BC99AC72306C23D103E010D18257@CNBJMBX05.corpusers.net>
	 <1414392371.8884.2.camel@perches.com>
	 <1414531369.10912.14.camel@perches.com>
	 <35FD53F367049845BC99AC72306C23D103E010D1825C@CNBJMBX05.corpusers.net>
 <1414551974.10912.16.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1414551974.10912.16.camel@perches.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: 'Joe Perches' <joe@perches.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Russell King <linux@arm.linux.org.uk>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Will Deacon <Will.Deacon@arm.com>, Akinobu Mita <akinobu.mita@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, alsa-devel <alsa-devel@alsa-project.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

> From: Joe Perches [mailto:joe@perches.com]
> > I think the most safe way is change byte_rev_table[] to be satic, So
> > that no driver can access it directly, The build error can remind the
> > developer if they use byte_rev_table[] Directly .
> 
> You can do that with your later patch, but the existing uses _must_ be
> converted first so you don't break the build.
> 
> 
Yeah, I agree with you,
I will add this into my later patch.

Thanks
