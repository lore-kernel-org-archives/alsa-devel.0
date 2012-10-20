From: Pete Leigh <pete.leigh@gmail.com>
Subject: Re: Fwd: Support for Roland VG-99 (working code,
 but could use help)
Date: Sat, 20 Oct 2012 01:17:47 +0100
Message-ID: <CABn3OEG=u+iDeVqkar-Dg3rYWnY7b6UgHKJuyRpFgMXqMe_LoQ@mail.gmail.com>
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
 <CABn3OEF8HHCp2Z-gDV1smYdTpijO_Fty5H-RjfVCtqVQQQPfUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ie0-f179.google.com (mail-ie0-f179.google.com
 [209.85.223.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 8250A26260C
 for <alsa-devel@alsa-project.org>; Sat, 20 Oct 2012 02:17:48 +0200 (CEST)
Received: by mail-ie0-f179.google.com with SMTP id c10so1394076ieb.38
 for <alsa-devel@alsa-project.org>; Fri, 19 Oct 2012 17:17:47 -0700 (PDT)
In-Reply-To: <CABn3OEF8HHCp2Z-gDV1smYdTpijO_Fty5H-RjfVCtqVQQQPfUA@mail.gmail.com>
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

On 19 October 2012 23:24, Pete Leigh <pete.leigh@gmail.com> wrote:

> If I take the working config, and disable CONFIG_USB_EHCI_TT_NEWSCHED,
> recompile, make install, reboot, then I get the familiar  "cannot
> submit urb 0, error -28: not enough bandwidth" error, and trying to
> record off the UA-25 in audacity freezes audacity. If I then re-enable
> it, recompile, make install, reboot, then I don't see the error, and
> recording off the UA-25 works normally in audacity.

Just to add:  I did also make modules_install in the above procedure,
if you were wondering..

Also, if there's anything further I can do, in the way of testing
patches, etc., please let me know.

Cheers,

 - Pete
