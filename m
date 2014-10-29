From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] 6fire: Convert byte_rev_table uses to bitrev8
Date: Tue, 28 Oct 2014 20:06:14 -0700
Message-ID: <1414551974.10912.16.camel@perches.com>
References: <35FD53F367049845BC99AC72306C23D103E010D18254@CNBJMBX05.corpusers.net>
	 <35FD53F367049845BC99AC72306C23D103E010D18257@CNBJMBX05.corpusers.net>
	 <1414392371.8884.2.camel@perches.com>
	 <1414531369.10912.14.camel@perches.com>
	 <35FD53F367049845BC99AC72306C23D103E010D1825C@CNBJMBX05.corpusers.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <owner-linux-mm@kvack.org>
In-Reply-To: <35FD53F367049845BC99AC72306C23D103E010D1825C@CNBJMBX05.corpusers.net>
Sender: owner-linux-mm@kvack.org
To: "Wang, Yalin" <Yalin.Wang@sonymobile.com>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Russell King <linux@arm.linux.org.uk>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Will Deacon <Will.Deacon@arm.com>, Akinobu Mita <akinobu.mita@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, alsa-devel <alsa-devel@alsa-project.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 2014-10-29 at 10:42 +0800, Wang, Yalin wrote:
> > Use the inline function instead of directly indexing the array.
> > This allows some architectures with hardware instructions for bit reversals
> > to eliminate the array.
[]
> > On Sun, 2014-10-26 at 23:46 -0700, Joe Perches wrote:
> > > On Mon, 2014-10-27 at 14:37 +0800, Wang, Yalin wrote:
> > > > this change add CONFIG_HAVE_ARCH_BITREVERSE config option, so that
> > > > we can use arm/arm64 rbit instruction to do bitrev operation by
> > > > hardware.
[]
> I think the most safe way is change byte_rev_table[] to be satic,
> So that no driver can access it directly,
> The build error can remind the developer if they use byte_rev_table[]
> Directly .

You can do that with your later patch, but the
existing uses _must_ be converted first so you
don't break the build.



--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
