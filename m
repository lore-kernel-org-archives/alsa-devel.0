From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: Jack event API - decision needed
Date: Mon, 20 Jun 2011 16:11:40 +0200
Message-ID: <4DFF551C.6030006@canonical.com>
References: <csg7ltyo2ntnnwkjy445wvqj.1308577935731@email.android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from adelie.canonical.com (adelie.canonical.com [91.189.90.139])
	by alsa0.perex.cz (Postfix) with ESMTP id 447071037FB
	for <alsa-devel@alsa-project.org>;
	Mon, 20 Jun 2011 16:11:43 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Kay Sievers <kay.sievers@vrfy.org>, Lennart Poettering <lennart@poettering.net>
List-Id: alsa-devel@alsa-project.org

On 2011-06-20 15:56, Mark Brown wrote:
> Sorry about the top posting, but as I wasn't involved in any of the discussions and am on a mobile device right now and your mail isn't directly legible it would be enormously helpful if you could summarize the issues you're trying to address,your proposed solution and the problems Kay had.

This particular issue and the udev patch was about letting the current 
logged in user access the input devices, which are currently only 
accessible by root.

I'm sure there will be quite a few more issues before something that 
"just works" for the vast majority of people!

I'll leave it to Kay to explain what problems he had with accepting the 
patch.

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
