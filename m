From: Daniel Mack <zonque@gmail.com>
Subject: Re: Fwd: Support for Roland VG-99 (working code,
 but could use help)
Date: Fri, 19 Oct 2012 20:21:40 +0200
Message-ID: <50819A34.4010600@gmail.com>
References: <CABn3OEFatrnhGs1xzpmOfXSxpSLuGwgRtN8v=1B96i6=7_9vTg@mail.gmail.com>
 <CABn3OEHRK7TLp+J_pZjMoFts4bZ=-FquQX0WKCzUcaaMZ8Nrpg@mail.gmail.com>
 <507D0F6D.1000102@gmail.com>
 <CABn3OEF1L7hqVAcjs5E5NveA741HPVd4a9eq0w9sS77PYg+2hQ@mail.gmail.com>
 <507D1C77.5080302@gmail.com>
 <CABn3OEHxhguP6E56DUjfPAgxyaSXOHrRSd7jEdsax3e16Zm3Nw@mail.gmail.com>
 <50810512.2040909@gmail.com>
 <CABn3OEECLmo3LXQ7Zg+HVk4HBO54NgLZgxwV11-7rjQYu8BHQQ@mail.gmail.com>
 <50810E4E.2020108@gmail.com>
 <CABn3OEF18-Q3agOZ3Er5BODDo2R=H-G4Njdua-1L_E1uXHqpMw@mail.gmail.com>
 <CABn3OEH4n5i_UNMQSVM9a+gUBD5mXH=faeazu038Kdy_p9G+AQ@mail.gmail.com>
 <508191DF.2060802@gmail.com>
 <CABn3OEHmJqtkkKz1TeLh_Q52meUkuzKYnp8sTH5LtSjMG73sCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id E84F6265B79
 for <alsa-devel@alsa-project.org>; Fri, 19 Oct 2012 20:21:43 +0200 (CEST)
Received: by mail-bk0-f51.google.com with SMTP id e19so286254bku.38
 for <alsa-devel@alsa-project.org>; Fri, 19 Oct 2012 11:21:43 -0700 (PDT)
In-Reply-To: <CABn3OEHmJqtkkKz1TeLh_Q52meUkuzKYnp8sTH5LtSjMG73sCg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Pete Leigh <pete.leigh@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 19.10.2012 20:18, Pete Leigh wrote:
> On 19 October 2012 18:46, Daniel Mack <zonque@gmail.com> wrote:
>> On 19.10.2012 19:02, Pete Leigh wrote:
> 
>>> I quickly tested the VG-99 quirk (modified as per Clemens' suggestion)
>>> and that works too, so I'll work on generating a patch as per the
>>> instructions on alsa-project.org.
> 
> Actually, I'm struggling a bit with this. I'm guessing
> (alsa-project.org doesn't seem to say...) that you need to check out
> the release branch in alsa-driver to work on, and do your commit
> against that (master branch contains only a README) but the wiki also
> advises to do a rebase origin/master after your commit. It seemed
> weird, but I tried it, to no useful effect of course.
> 
> As a relative novice, this is pretty confusing stuff. Is there a plain
> step-by-step of the procedure to generate a patch? Would  it be
> acceptable to send the patch against the sound.git tree?

Yes, sound.git is the reference, and your patch should apply cleanly on
top of it.


Daniel
