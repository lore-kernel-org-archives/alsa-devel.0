From: Kay Sievers <kay.sievers@vrfy.org>
Subject: Re: Jack event API - decision needed
Date: Mon, 20 Jun 2011 16:19:51 +0200
Message-ID: <BANLkTin7K_qO3ejJhOswjSjrLVh0cN2_Wg@mail.gmail.com>
References: <csg7ltyo2ntnnwkjy445wvqj.1308577935731@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id B3F7C1037FB
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Jun 2011 16:20:07 +0200 (CEST)
Received: by gyc15 with SMTP id 15so476629gyc.38
	for <alsa-devel@alsa-project.org>; Mon, 20 Jun 2011 07:20:06 -0700 (PDT)
In-Reply-To: <csg7ltyo2ntnnwkjy445wvqj.1308577935731@email.android.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Lennart Poettering <lennart@poettering.net>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

On Mon, Jun 20, 2011 at 15:56, Mark Brown
<broonie@opensource.wolfsonmicro.com> wrote:
> Sorry about the top posting, but as I wasn't involved in any of the discussions and am on a mobile device right now and your mail isn't directly legible it would be enormously helpful if you could summarize the issues you're trying to address, your proposed solution and the problems Kay had.

Domain-specific events should not be 'faked' as 'input' devices. No
non-input subsystem should do that if it can be avoided. That 'input'
supports nice and easy events to userspace should not be a reason to
misuse it for pretty much unrelated things.

There are patches to have the ALSA control device emit these ALSA
related events natively. That's would be just better, simpler and more
correct than any additionally created input device.

If Takashi can make that possible in a reasonable time frame, we
should not even start handling the (currently not handled) input
devices in upstream projects like udev and PulseAudio, and focus right
away on the native ALSA control events.

If we can't have the native ALSA events anytime soon for some reason,
we might need to merge the input device support, but I would like to
avoid that.

Kay
