From: Carl Canuck <carl.canuck.official@gmail.com>
Subject: Re: Documentation Request
Date: Tue, 3 Sep 2013 23:15:37 -0400
Message-ID: <CAPOzVs7TiHEA2Fc9k40X58P-a2QCUzXcLLSU_B27aFbsbO0ztQ@mail.gmail.com>
References: <CAPOzVs4y7qc6PGps+rPzAKUUXJPuJSBowaqc2jnb=vRe9QchNg@mail.gmail.com>
 <522685BA.2030904@blennerhassett.gen.nz>
 <CAPOzVs5XUZ8RvcC4wTRp1sYZz7PP4UjnKu=qUzUcwdHkB-ta6Q@mail.gmail.com>
 <CACckToUBiwJg1TUMuw3eFws_rvf9qc3ZPfSzy7MRCB8b0JEnRg@mail.gmail.com>
 <CAPOzVs4+Sd=UXZ3gMGSNwMk1EW_yKPK+7dTo_vuWD_acyrWw6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f196.google.com (mail-ie0-f196.google.com
 [209.85.223.196])
 by alsa0.perex.cz (Postfix) with ESMTP id C9EE0265490
 for <alsa-devel@alsa-project.org>; Wed,  4 Sep 2013 05:15:38 +0200 (CEST)
Received: by mail-ie0-f196.google.com with SMTP id c10so46709ieb.7
 for <alsa-devel@alsa-project.org>; Tue, 03 Sep 2013 20:15:38 -0700 (PDT)
In-Reply-To: <CAPOzVs4+Sd=UXZ3gMGSNwMk1EW_yKPK+7dTo_vuWD_acyrWw6g@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Sorry, I only sent that last reply to Grant, the
reply-to-anybody-but-sender options are a little counter-intuitive in Gmail.


On Tue, Sep 3, 2013 at 11:10 PM, Carl Canuck <carl.canuck.official@gmail.com
> wrote:

> Hi Grant,
>
> I have in fact spent a little time with Jack and even conjured up a
> working prototype using Jack audio with ALSA MIDI (that will never see the
> light of day).  However, you're ignoring the fact that:
>
> 1.  Some people don't like having 20 separate audio applications running
> and having to save all of their states individually
> 2.  If you believe that any existing Jack session manager is a stable,
> reliable application that adequately solves problem #1, then it's obvious
> that you've not spent much time with Jack session managers
> 3.  Jack is something like 15 years old now, and they still haven't even
> managed to solve #1 and #2 yet, among other long-standing issues?
> 4.  With points #1, #2 and #3 all being common knowledge, why should I put
> my faith in Jack competently wrapping ALSA for me instead of taking matters
> into my own hands and going straight to ALSA?
> 5.  If you visit Windows/Mac audio forums, there are legions of people who
> will tell you they tried Linux once, found Jack to be buggy and terrible in
> general, never intend to try Linux again.  In fact, you can register a user
> name on any non-Linux music forum, and ask "i'm thinking of trying Linux
> for audio, thoughts?", and people will say exactly the things I described
> to you, not because they have any unfounded bias against Linux or Jack, but
> because that was truly their experience.
> 6.  Jack's configuration settings and error logging are atrocious, it is
> far too often excessively difficult to understand why Jack won't start and
> how to fix it.
> 7.  Is it really so unreasonable to ask for a basic example of a common
> use-case for ALSA without being told that I should just abandon the quest
> for that knowledge and put my faith in the Jack developers?  Should
> deciphering the intended use of any API be an exercise left to the would-be
> developer?
>
> If you like Jack, then by all means use it, but it's not ideal for my
> use-case, and I won't be spending any more time evaluating it until the
> Jack developers address these long-standing issues.
>
> Carl
>
> <http://users.suse.com/~mana/alsa090_howto.html>


Also, I have in fact seen the link you provided Grant, but that once again
is only bits and pieces of the use-case.  I'd like to know that I'm using
ALSA as it's creators intended, rather than stringing together bits and
pieces and hoping that I'm doing it right.

Regards,
Carl
