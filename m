From: Caleb Crome <caleb@crome.org>
Subject: Re: [PATCH v5] ASoC: cs53l30: Add support for Cirrus
 Logic CS53L30
Date: Thu, 2 Jun 2016 10:40:58 -0700
Message-ID: <CAG5mAdwp2DEeFk6pwe6n65iQHHzzyiNPx1QTz3u2rUsQRUpNEA@mail.gmail.com>
References: <1458082066-2859-1-git-send-email-tim.howe@cirrus.com>
 <20160517234333.GB29471@Asurada-Nvidia> <20160531165358.GH29837@sirena.org.uk>
 <CAG5mAdw-gh2_ZQ17h3HS=pMZaW-bGhoKgNDz_hbwzw2rBKs8ig@mail.gmail.com>
 <20160531173505.GI29837@sirena.org.uk>
 <CAG5mAdwB-YCiFV0L+KgULKcmRVEhHK68mBrf9UHe0s-1UBotJQ@mail.gmail.com>
 <20160602171753.GQ2282@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-oi0-f67.google.com (mail-oi0-f67.google.com
 [209.85.218.67])
 by alsa0.perex.cz (Postfix) with ESMTP id EA08126519F
 for <alsa-devel@alsa-project.org>; Thu,  2 Jun 2016 19:41:18 +0200 (CEST)
Received: by mail-oi0-f67.google.com with SMTP id e80so4707647oig.1
 for <alsa-devel@alsa-project.org>; Thu, 02 Jun 2016 10:41:18 -0700 (PDT)
In-Reply-To: <20160602171753.GQ2282@sirena.org.uk>
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
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, paul.handrigan@cirrus.com, "Howe,
 Tim" <tim.howe@cirrus.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 2, 2016 at 10:17 AM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, May 31, 2016 at 03:32:05PM -0700, Caleb Crome wrote:
>> On Tue, May 31, 2016 at 10:35 AM, Mark Brown <broonie@kernel.org> wrote:
>
>> > I'm not sure why mic arrays would drive that, it's not like they're
>> > particularly new or innovative technology here and multi channel output
>> > has been even more widely available for a long time?
>
>> Good point.  I guess I'm coming from the SoC/mobile world where most SoCs
>> support stereo only, and a couple microphones at most.  Now phones have 3-4
>> or more microphones.   Amazon echo has 7 mics.  We're working on arrays of
>
> That's fairly rare, I'd say more of the vendors are doing programmable
> serial ports and those that aren't have a different model...  see below.
>
>> We must be looking at different sorts of chips :-)  Even on new parts like
>> the Snapdragon 410, they have a super inflexible I2S only port. (up to 3
>> parallel I2S for up to 6 channels, but no TDM).
>
> Qualcomm have never really wanted anyone to use I2S in their mobile
> products for quite some time now - they've always wanted to do a system
> sale based on either their integrated CODECs or (in the current
> production designs) their own external CODECs which normally use Slimbus
> to connect to the CPU (they are working off and on on upstreaming
> Slimbus, nobody else ever adopted it so there's relatively little
> pressure).
>
>> and a few other chips that I'm not familiar with.  So  there does not seem
>> to be overwhelming support for TDM in Alsa ASoC.  To what extent this is a
>> software vs. hardware issue could use a little investigation.
>
> It's software and legacy hardware.
>
>> So... if anybody knows of a Cortex A53 or A57 with good TDM support in
>> linux (at least 16 channels in and out), I'd love to know about it :-)
>
> Well, if you specifically mean TDM as opposed to multi-channel our
> general support for that isn't good (mainly due to lack of demand).  It
> sounds like you're more interested in multi channel here though.

I must be missing something.  To me, TDM is synonymous with
multi-channel on a single wire. The datasheets of codecs and SoCs
invariably refer to TDM as putting multiple slots onto a single wire,
and not necessarily the actual bit-format and clocking of that wire.
The actual clocking and bits are generally configurable, but the
concept of TDM in the datasheets seems to be universal and have the
same meaning -- multi-channel on a wire.

(I recall there is also a specific TDM format with something like 384
slots per frame, which is a well defined thing, but that's not what
I'm talking about.  That's used just for telephony I beleive).


What's the linuxy name for what the datasheets call TDM format with
slots > 2?  Do we just call that 'multi-channel', or specifically say,
'channels_max > 2'?  I was always under the assumption that's what TDM
meant.

Thanks,
   -Caleb
