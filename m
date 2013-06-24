From: Daniel Mack <zonque@gmail.com>
Subject: Re: [PATCH 1/5] ASoC: codecs: tas5086: fix
	documentation
Date: Mon, 24 Jun 2013 18:46:48 +0200
Message-ID: <51C877F8.2010106@gmail.com>
References: <1372083932-4318-1-git-send-email-zonque@gmail.com>
 <20130624160551.GU27646@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ea0-f174.google.com (mail-ea0-f174.google.com
 [209.85.215.174])
 by alsa0.perex.cz (Postfix) with ESMTP id 58A7F261B00
 for <alsa-devel@alsa-project.org>; Mon, 24 Jun 2013 18:46:17 +0200 (CEST)
Received: by mail-ea0-f174.google.com with SMTP id o10so6186528eaj.33
 for <alsa-devel@alsa-project.org>; Mon, 24 Jun 2013 09:46:17 -0700 (PDT)
In-Reply-To: <20130624160551.GU27646@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 24.06.2013 18:05, Mark Brown wrote:
> On Mon, Jun 24, 2013 at 04:25:28PM +0200, Daniel Mack wrote:
>> The property 'ti,charge-period' must be given in nanoseconds, not
>> microseconds.
> 
> Applied al, thanks.  Though specifying this in nanoseconds does seem
> absurdly high resolution...

Meh, I was confused, sorry. That first patch need to be revered (or
dropped), the documentation was correct as it stood. The time values are
given in fractions of milliseconds, not microseconds. My bad.

> Not sure where the "codecs: " in the subject line came from either.

No problem, I can drop that in my future submissions.



Thanks,
Daniel
