From: Dimitris Papavasiliou <dpapavas@gmail.com>
Subject: Re: Need help fixing pop/click artifacts in an ASOC
	driver
Date: Sun, 23 Dec 2018 22:11:56 +0200
Message-ID: <CAHEwa0AfqH_ooaCxnBUi3TUk1fmTrhuWTGMvZgNmxypMpCVo=w@mail.gmail.com>
References: <20181217154043.GC27909@sirena.org.uk>
 <f743bf6b-b10a-6c00-57d7-3a0df67d7bba@gmail.com>
 <20181217165257.GD27909@sirena.org.uk>
 <5a2103c5-194b-cb21-672e-d472e91825a8@gmail.com>
 <20181219161949.GD8130@sirena.org.uk>
 <8c996338-19a3-996b-16dc-5535688ccea2@gmail.com>
 <20181220153613.GC9325@sirena.org.uk>
 <c95346b8-335a-88c4-484b-9ad4e1aebc12@gmail.com>
 <20181221105741.GB4996@sirena.org.uk>
 <5f783336-1786-862c-b238-2309381bfd94@gmail.com>
 <20181221173345.GF4996@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-it1-f172.google.com (mail-it1-f172.google.com
 [209.85.166.172])
 by alsa0.perex.cz (Postfix) with ESMTP id ABC7D267960
 for <alsa-devel@alsa-project.org>; Sun, 23 Dec 2018 21:12:12 +0100 (CET)
Received: by mail-it1-f172.google.com with SMTP id a6so13278901itl.4
 for <alsa-devel@alsa-project.org>; Sun, 23 Dec 2018 12:12:12 -0800 (PST)
In-Reply-To: <20181221173345.GF4996@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 21, 2018 at 7:33 PM Mark Brown <broonie@kernel.org> wrote:
>
> > I can apply the patch via merge, so bothering with this is not at all
> > necessary, but if this change is useful, perhaps it's worth submitting
> > another patch for it.  I doubt this though, as it looks a bit hackish
> > to me.
>
> It's useful (that's a genuine issue) but it shouldn't be bodged by TDM
> mode but should instead just be done as standard without the machine
> driver needing to do TDM - check if the clock rate required is actually
> generated then fall back to a less exact frame if that helps.  That way
> everyone gets the benefit without needing custom configuration or code.
> Basically it's doing the right thing in terms of configuring the
> hardware but should be triggered differently.

I suspected as much; I'll need to read up a bit on clocking though if
I'm going to give this a shot.  I'll be away from my computer during
the holidays so, if time permits, I'll give it a try with the new year
and open a new thread if I need feedback.  Thanks again for all your
help so far.
