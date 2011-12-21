From: David Henningsson <david.henningsson@canonical.com>
Subject: Re: [PATCH] hda - add ALC889 quick id for Intel Los
 Lunas 2 desktop reference board
Date: Wed, 21 Dec 2011 09:09:36 +0100
Message-ID: <4EF19440.10801@canonical.com>
References: <20111221022020.GA20195@localhost> <s5hy5u6pgl3.wl%tiwai@suse.de>
	<20111221072314.GA10669@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
	[91.189.89.112])
	by alsa0.perex.cz (Postfix) with ESMTP id 310F2103902
	for <alsa-devel@alsa-project.org>; Wed, 21 Dec 2011 09:09:35 +0100 (CET)
In-Reply-To: <20111221072314.GA10669@localhost>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Wu Fengguang <fengguang.wu@intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 12/21/2011 08:23 AM, Wu Fengguang wrote:
> On Wed, Dec 21, 2011 at 02:46:32PM +0800, Takashi Iwai wrote:
>> I'm in the process removing all these model quirks.
>
> Doesn't that risk introducing many regressions? What would be the
> problem if we switch to the generic HDA driver for *new* boards and
> leave the old working quicks/models untouched?

For me, it's the other way around. Whenever we try to improve the 
generic behaviour of the codec driver, e g by adding configurable 
auto-mute, jack detection notification etc, these old models get left 
behind because the new stuff depends on information we get out of the 
autoparser(s).

By removing the model quirks, these machines can benefit from the new 
functionality as well.

-- 
David Henningsson, Canonical Ltd.
http://launchpad.net/~diwic
