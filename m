From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH 00/38] Realtek HD-audio auto-parser
Date: Tue, 28 Feb 2012 09:33:21 +0100
Message-ID: <4F4C9151.6020205@canonical.com>
References: <1330101391-8788-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112]) by alsa0.perex.cz (Postfix) with ESMTP id 0D7F624521
	for <alsa-devel@alsa-project.org>; Tue, 28 Feb 2012 09:33:25 +0100 (CET)
In-Reply-To: <1330101391-8788-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 02/24/2012 05:35 PM, Takashi Iwai wrote:
> Hi,
>
> for 3.4 kernel, finally I got rid of all static quirks from HD-audio
> Realtek codec parser.  This means that the all necessary quirks have
> been converted to alc_fixup either the pin-config overrides, the
> additional verbs, or the extra init functions.
>
> Since some machines have really weird pin mappings, I introduced the
> new mechanism in the parser to evaluate the best DAC->pin
> connections, which is based on the badness calculation.  You won't
> notice on most of machines but some machines that have fewer DACs than
> necessary output pins will get different mappings by this change.
>
> The whole changes can be seen in sound git tree topic/hda branch, as
> usual.
>      git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git
>
> Now it's merged to main branch, so the snapshot tarball contains
> these changes, too.
>
> The rest of the thread will contain the changes in patch_realtek.c.
> It's just for refernces, and I omitted the other files.  For the
> complete changes, take a look at the git tree.

Hi Takashi,

I think this is a very good move. Unfortunately I don't have time to 
review all 38 patches thoroughly, but if there is anything in particular 
you would like a second pair of eyes on, let me know.

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
