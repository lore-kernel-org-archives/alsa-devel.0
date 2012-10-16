From: Daniel Mack <zonque@gmail.com>
Subject: Re: Fwd: Support for Roland VG-99 (working code,
 but could use help)
Date: Tue, 16 Oct 2012 10:36:07 +0200
Message-ID: <507D1C77.5080302@gmail.com>
References: <CABn3OEFatrnhGs1xzpmOfXSxpSLuGwgRtN8v=1B96i6=7_9vTg@mail.gmail.com>
 <CABn3OEHRK7TLp+J_pZjMoFts4bZ=-FquQX0WKCzUcaaMZ8Nrpg@mail.gmail.com>
 <507D0F6D.1000102@gmail.com>
 <CABn3OEF1L7hqVAcjs5E5NveA741HPVd4a9eq0w9sS77PYg+2hQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 by alsa0.perex.cz (Postfix) with ESMTP id AB6D2261708
 for <alsa-devel@alsa-project.org>; Tue, 16 Oct 2012 10:36:12 +0200 (CEST)
Received: by mail-bk0-f51.google.com with SMTP id e19so2255975bku.38
 for <alsa-devel@alsa-project.org>; Tue, 16 Oct 2012 01:36:12 -0700 (PDT)
In-Reply-To: <CABn3OEF1L7hqVAcjs5E5NveA741HPVd4a9eq0w9sS77PYg+2hQ@mail.gmail.com>
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

On 16.10.2012 10:31, Pete Leigh wrote:
> Hi Daniel, thanks for taking the time..
> 
> On 16 October 2012 08:40, Daniel M
> 
>> are you sure 44100 is the only supported sample rate?
> 
> Yep, the manual is pretty clear about that. Also,
> http://www.rolandus.com/products/details/849 in the "specs" section.

Ok then.

>>>  the device name no longer shows up in lsusb output [...]
>> lsusb -v should still show it
> 
> Hmm... and now it's there! I guess I must have missed it.
> 
>>  For the normal output, you could submit
>> an entry here: http://www.linux-usb.org/usb-ids.html
> 
> Right! I've just done that - the id comes up differently for the two
> "driver modes", so I put both in.
> 
>> Check out the latestes sound.git[*] and make sure your patch applies
>> there. Also note that the entries in this file are sorted by VID/PID.
> 
> Ok, I'll give this a shot.. Does the quirk definition look sane?

Yes. Note that there are several coding style rules to obey in the
kernel (most importantly in your case: tabs are used for indentation).
See Documentation/CodingStyle and run scripts/checkpatch.pl on the patch
before submitting.

And I missed the annotation in the previous mail, so here it is:

[*] git://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git

> Is it
> worth showing the lsusb -v output with that patch in place (would you
> expect that to look any different... it still has the "unrecognized"
> parts)?

No.


Thanks,
Daniel
