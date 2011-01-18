From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: Re: [PATCH - [hdspm] 0/3] Support for RME RayDAT and
	AIO
Date: Tue, 18 Jan 2011 18:06:00 +0100
Message-ID: <4D35C878.8050507@drcomp.erfurt.thur.de>
References: <1295359939-14673-1-git-send-email-adi@drcomp.erfurt.thur.de>
	<s5hoc7egtxi.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ltw.loris.tv (ltw.loris.tv [85.14.220.160])
	by alsa0.perex.cz (Postfix) with ESMTP id C1CB3103850
	for <alsa-devel@alsa-project.org>; Tue, 18 Jan 2011 18:06:30 +0100 (CET)
Received: from localhost (ltw.loris.tv [127.0.0.1])
	by ltw.loris.tv (Postfix) with ESMTP id 82CBE1AC631
	for <alsa-devel@alsa-project.org>; Tue, 18 Jan 2011 18:06:18 +0100 (CET)
Received: from ltw.loris.tv ([127.0.0.1])
	by localhost (ltw.loris.tv [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id RsL9hl6crliR for <alsa-devel@alsa-project.org>;
	Tue, 18 Jan 2011 18:06:01 +0100 (CET)
Received: from [IPv6:2001:638:906:2:216:17ff:fe47:deab] (hex.inf-ra.uni-jena.de
	[IPv6:2001:638:906:2:216:17ff:fe47:deab])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by ltw.loris.tv (Postfix) with ESMTPSA id E0EC77B4188
	for <alsa-devel@alsa-project.org>; Tue, 18 Jan 2011 18:06:00 +0100 (CET)
In-Reply-To: <s5hoc7egtxi.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 01/18/11 15:36, Takashi Iwai wrote:

Hi!

> Basically one patch should contain the changes that are build-clean,
> i.e. you can build cleanly after patching.  Thus changing a header
> and *.c in separate patches doesn't work well.

Ok. Better luck next time. ;) Speaking of which: should I resend
everything as a whole-in-one patch?

I could also provide a download link (given we're talking 170+kb here)

> Also, please use the generic variable types as much as possible
> for ioctl structs. Avoid use of enum or such, especially ones that
> are typedef'ed. In general, avoid typedefs in the kernel code as much
> as possible. Defining each enum type is no-go.

If've dropped all the new typedefs and only kept the existing ones now.
However, it still reads "enum foo something" in the structs for some
ioctls.

Is this acceptable or do I have to change this to int? If so, would I
manually add a couple of #defines? I somehow feel losing the semantic
connection to the enum is bad, but this might OTOH be intended, e.g. for
the sake of a stable interface.

> Second, don't define arrays in the header file. They must be in the
> body, not included headers.

Cross-checked with hdspmixer and moved to .c, except for the channel
mappings as they're included from userspace. (channel_map*)

> Also, remember checkpatch.pl is your friend.

It already was for the very last days. But I'm more excited about my new
friend Lindent. ;)


Cheers
