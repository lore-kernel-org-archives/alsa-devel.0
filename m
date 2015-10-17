From: "Alexander E. Patrakov" <patrakov@gmail.com>
Subject: Re: Splitting out controls
Date: Sat, 17 Oct 2015 21:25:06 +0500
Message-ID: <56227662.3000000@gmail.com>
References: <1444657786.2528.78.camel@loki>
 <20151012205908.GA25971@us.netrek.org> <561CADA8.3040903@canonical.com>
 <1445009730.3536.18.camel@rf-debian.wolfsonmicro.main>
 <s5h1tcug5w2.wl-tiwai@suse.de> <56226F21.3040902@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f172.google.com (mail-wi0-f172.google.com
 [209.85.212.172])
 by alsa0.perex.cz (Postfix) with ESMTP id 33126260483
 for <alsa-devel@alsa-project.org>; Sat, 17 Oct 2015 18:25:12 +0200 (CEST)
Received: by wicll6 with SMTP id ll6so48165563wic.1
 for <alsa-devel@alsa-project.org>; Sat, 17 Oct 2015 09:25:11 -0700 (PDT)
In-Reply-To: <56226F21.3040902@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, James Cameron <quozl@laptop.org>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

17.10.2015 20:54, Pierre-Louis Bossart wrote:
> To say that a configuration is 'safe' requires a breadth of information
> from thermal, acoustic and mechanical design that is just not available
> to kernel contributors who work in parallel on different building blocks
> and different configurations. Adding a safeguard in the machine driver
> is not practical: it's not uncommon for manufacturers to swap out
> speakers to save a couple of cents on a specific production batch and a
> value set in stone in a driver would not work for all those different
> batches.

So, here is a strawman counterproposal.

Design some safe and hardware-agnostic form of bytecode. This bytecode 
should be able to access mixer controls by name or by index, get 
proposed values, and decide, using arithmetical and logical operations, 
whether the proposal is safe. Load this bytecode as firmware, just like 
we load various overrides in snd-hda-intel.

I.e. the mechanism remains in the kernel, but the policy becomes easily 
swappable by the board manufacturer.

-- 
Alexander E. Patrakov
