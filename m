From: Pete Leigh <pete.leigh@gmail.com>
Subject: Re: Fwd: Support for Roland VG-99 (working code,
 but could use help)
Date: Fri, 19 Oct 2012 19:18:49 +0100
Message-ID: <CABn3OEHmJqtkkKz1TeLh_Q52meUkuzKYnp8sTH5LtSjMG73sCg@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f179.google.com (mail-ie0-f179.google.com
 [209.85.223.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 34CAD265B79
 for <alsa-devel@alsa-project.org>; Fri, 19 Oct 2012 20:18:51 +0200 (CEST)
Received: by mail-ie0-f179.google.com with SMTP id c10so1016000ieb.38
 for <alsa-devel@alsa-project.org>; Fri, 19 Oct 2012 11:18:50 -0700 (PDT)
In-Reply-To: <508191DF.2060802@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Daniel

On 19 October 2012 18:46, Daniel Mack <zonque@gmail.com> wrote:
> On 19.10.2012 19:02, Pete Leigh wrote:

>> I quickly tested the VG-99 quirk (modified as per Clemens' suggestion)
>> and that works too, so I'll work on generating a patch as per the
>> instructions on alsa-project.org.

Actually, I'm struggling a bit with this. I'm guessing
(alsa-project.org doesn't seem to say...) that you need to check out
the release branch in alsa-driver to work on, and do your commit
against that (master branch contains only a README) but the wiki also
advises to do a rebase origin/master after your commit. It seemed
weird, but I tried it, to no useful effect of course.

As a relative novice, this is pretty confusing stuff. Is there a plain
step-by-step of the procedure to generate a patch? Would  it be
acceptable to send the patch against the sound.git tree?

>> If it's any use regarding the urb 0 -ENOSPACE error I was having,  I
>> can try and track down the config item difference that makes it work,
>> or provide the config files for you to look at.. Please let me know if
>> this would be useful.
>
> Absolutely, that would be great. We keep getting reports from users that
> see this since the driver was reworked, and I still haven't got my head
> around what really causes it. And none of my machines show the error
> yet, so it's really hard to track. If you would point me to any specific
> config option that reproducibly changes the behaviour, that would be of
> great help.
>
>> Should there be some dependency in the configs so that whatever item
>> is making the difference is enabled by selecting SND_USB_AUDIO ?
>
> No, it's really just a bug that must be fixed.

Ok, I'll try narrowing down the config differences. It might take a
while, though:

$ diff ~/3.7.working.config ~/broken.config | grep -v '#' | wc -l
$ 1001

Cheers,

- Pete.
