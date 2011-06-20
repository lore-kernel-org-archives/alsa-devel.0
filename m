From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Jack event API - decision needed
Date: Mon, 20 Jun 2011 17:47:14 +0100
Message-ID: <20110620164713.GA32056@opensource.wolfsonmicro.com>
References: <csg7ltyo2ntnnwkjy445wvqj.1308577935731@email.android.com>
	<BANLkTin7K_qO3ejJhOswjSjrLVh0cN2_Wg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 036A824530
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Jun 2011 18:47:17 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <BANLkTin7K_qO3ejJhOswjSjrLVh0cN2_Wg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kay Sievers <kay.sievers@vrfy.org>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Lennart Poettering <lennart@poettering.net>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 20, 2011 at 04:19:51PM +0200, Kay Sievers wrote:

> Domain-specific events should not be 'faked' as 'input' devices. No
> non-input subsystem should do that if it can be avoided. That 'input'
> supports nice and easy events to userspace should not be a reason to
> misuse it for pretty much unrelated things.

OK, but since jacks aren't at all audio specific (the most obvious
additional thing that goes over them is video for cases like composite
out on mic and the modern digital standards like HDMI) that wouldn't
address the issue.  There's also things like docking stations which can
present very much like big fancy jacks.

> There are patches to have the ALSA control device emit these ALSA
> related events natively. That's would be just better, simpler and more
> correct than any additionally created input device.

That's not really terribly clever for the non-audio users, they'd have
to implement ALSA support.

> If we can't have the native ALSA events anytime soon for some reason,
> we might need to merge the input device support, but I would like to
> avoid that.

The input device usage has been present and in use in a basic form since
2.6.18, the ALSA integration of it since 2.6.27 so this isn't terribly
new.

It might be nice to have the information available via ALSA but it
doesn't seem reasonable to expect anything that might need the
information to have to go through ALSA.
