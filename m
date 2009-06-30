From: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] alsa/soc: add locking to mpc5200-psc-ac97
	driver
Date: Tue, 30 Jun 2009 10:53:26 -0600
Message-ID: <fa686aa40906300953n28016d4v179a1c7ed3198399@mail.gmail.com>
References: <20090629234214.12670.9082.stgit@localhost.localdomain>
	<9e4733910906291726h5cd5bdf8ve7e946aef855ac07@mail.gmail.com>
	<20090630085917.GA13961@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f198.google.com (mail-pz0-f198.google.com
	[209.85.222.198])
	by alsa0.perex.cz (Postfix) with ESMTP id 51C0824341
	for <alsa-devel@alsa-project.org>;
	Tue, 30 Jun 2009 18:53:48 +0200 (CEST)
Received: by pzk36 with SMTP id 36so228344pzk.16
	for <alsa-devel@alsa-project.org>; Tue, 30 Jun 2009 09:53:46 -0700 (PDT)
In-Reply-To: <20090630085917.GA13961@sirena.org.uk>
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
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 30, 2009 at 2:59 AM, Mark
Brown<broonie@opensource.wolfsonmicro.com> wrote:
> On Mon, Jun 29, 2009 at 08:26:12PM -0400, Jon Smirl wrote:
>
>> Does your touchscreen driver use this mutex? Or was this mutex needed
>> just for the AC97 driver?
>
> It's in the register accesses so everything accessing the chip registers
> will use it.

The mutexes are needed.  The ac97 bus doesn't have any knowledge about
what codec(s) will be wired up to it so it must protect against
multiple access.  In my case both the wm9712 audio codec driver and
the wm9712 touchscreen driver perform register accesses.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
