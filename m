From: Michael Trimarchi <michael@amarulasolutions.com>
Subject: Re: [PATCH 1/1] ASoC: pcm1792a: Remove redundant
	of_match_ptr helper
Date: Sat, 21 Dec 2013 15:24:57 +0100
Message-ID: <CAOf5uwnpP=X2R+TACXTcKin6XAbU+3sryQyT0Rwzf9=RKYXzEw@mail.gmail.com>
References: <1387613747-22784-1-git-send-email-sachin.kamat@linaro.org>
 <20131221141224.GA30815@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f169.google.com (mail-wi0-f169.google.com
 [209.85.212.169])
 by alsa0.perex.cz (Postfix) with ESMTP id 17A7E264FBA
 for <alsa-devel@alsa-project.org>; Sat, 21 Dec 2013 15:24:58 +0100 (CET)
Received: by mail-wi0-f169.google.com with SMTP id j9so1166151wiv.0
 for <alsa-devel@alsa-project.org>; Sat, 21 Dec 2013 06:24:57 -0800 (PST)
In-Reply-To: <20131221141224.GA30815@sirena.org.uk>
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
Cc: Sachin Kamat <sachin.kamat@linaro.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi

On Sat, Dec 21, 2013 at 3:12 PM, Mark Brown <broonie@kernel.org> wrote:
> On Sat, Dec 21, 2013 at 01:45:47PM +0530, Sachin Kamat wrote:
>> 'pcm1792a_of_match' is always compiled in. Hence the
>> helper macro is not needed.
>
> Part of the idea here is that the macro drops the reference to the table
> when OF is not in use and then the table gets eliminated by the compiler
> as unreferenced so we don't need ifdefs.

Yes, I don't understand here why we need to remove. This should go away.
BTW I found a bunch of commits from Sanchin on this direction

Michael
