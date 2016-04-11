From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] checkpatch: Improve missing break for
	switch/case tests
Date: Sun, 10 Apr 2016 22:04:10 -0700
Message-ID: <1460351050.1800.69.camel@perches.com>
References: <D32C47F6.1E2FD%ryan.harvey@cirrus.com>
 <s5hfuuvcfsr.wl-tiwai@suse.de> <570928CC.6030404@metafoo.de>
 <1460341582.1800.66.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtprelay.hostedemail.com (smtprelay0195.hostedemail.com
 [216.40.44.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 1707326153A
 for <alsa-devel@alsa-project.org>; Mon, 11 Apr 2016 07:04:13 +0200 (CEST)
In-Reply-To: <1460341582.1800.66.camel@perches.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andrew Morton <akpm@linux-foundation.org>, Andy Whitcroft <apw@shadowen.org>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, LKML <linux-kernel@vger.kernel.org>, "Harvey, Ryan" <Ryan.Harvey@cirrus.com>
List-Id: alsa-devel@alsa-project.org

On Sun, 2016-04-10 at 19:26 -0700, Joe Perches wrote:
> The current switch/case test doesn't handle ... case labels like:
> 
> 	switch (foo) {
> 	case bar ... baz:
> 		etc...
> 	}
> 
> Add a specific regex for that form and the default label.
> Use the regex where a case label is tested.

Please ignore, the patch is defective as
it has too many false positives.
