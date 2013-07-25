From: Daniel Mack <zonque@gmail.com>
Subject: Re: Ambiguous DAPM widget names and DPCM
Date: Thu, 25 Jul 2013 14:24:54 +0200
Message-ID: <51F11916.1080002@gmail.com>
References: <51EE3F18.3030207@gmail.com> <20130723123017.GV9858@sirena.org.uk>
 <51EEA2A3.8030106@gmail.com> <20130723183038.GO9858@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f44.google.com (mail-bk0-f44.google.com
 [209.85.214.44])
 by alsa0.perex.cz (Postfix) with ESMTP id 756A6260840
 for <alsa-devel@alsa-project.org>; Thu, 25 Jul 2013 14:25:04 +0200 (CEST)
Received: by mail-bk0-f44.google.com with SMTP id 6so662850bkj.17
 for <alsa-devel@alsa-project.org>; Thu, 25 Jul 2013 05:25:01 -0700 (PDT)
In-Reply-To: <20130723183038.GO9858@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: ALSA development <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 23.07.2013 20:30, Mark Brown wrote:
> On Tue, Jul 23, 2013 at 05:34:59PM +0200, Daniel Mack wrote:

>> With printk() in snd_soc_dapm_new_control(), I see the following widgets
>> being created during boot (one pair for each Codec, and two pairs for
>> the platform dai):
> 
> OK, so the issue here is probably that you're overloading the single
> McASP object rather than anything else

Hmm, I'm not following. Isn't that the way things are supposed to work
with DPCM?

> Lookups are done first in the local DAPM context so so long as the thing
> that's setting up the links is doing so in the same context everything
> should be OK.  This is needed so you can have two of the same device in
> a system.

Hmm, but DPCM does not have such a local context, and just tries to look
up the widgets by name globally.

> The prefix mechanism is intended to address this; however it's only
> currently supported for CODECs.  If we move the prefixes to components
> then they should be usable for CPU DAIs.

But that's a static string as well. How can we distiguish between two
Codecs of the same type, or two McASP instances?

All of that might not have been a big issue so far maybe, but with DPMC,
we need to make the names unique, and add a way to uniquely identify
each widget along with its device identifier.

Liam, could you explain what you think makes sense here?


Thanks,
Daniel
