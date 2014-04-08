From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Tenor TE8802,
 USB : clics and crackles during music play
Date: Tue, 08 Apr 2014 12:29:47 +0200
Message-ID: <5343CF9B.8020202@ladisch.de>
References: <CA+T9nP_hcPQBoQwike7oB5TfECax2MvARv0dTG9qB-RdFMuy=w@mail.gmail.com>
 <CA+T9nP-=ffsy9ftnxynUhdJK_Eev+S-MRznLz7CED-Yp3DiOjg@mail.gmail.com>
 <20140114143417.GB23764@tamtam.fritz.box>
 <loom.20140404T165417-983@post.gmane.org> <533ECF3C.3020404@ladisch.de>
 <op.xdya5wmiwx6sbz@ws00534.pq> <534305F1.8040805@ladisch.de>
 <op.xdznse1cwx6sbz@ws00534.pq>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id 79EFD2656C0
 for <alsa-devel@alsa-project.org>; Tue,  8 Apr 2014 12:29:55 +0200 (CEST)
In-Reply-To: <op.xdznse1cwx6sbz@ws00534.pq>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: mick <mick37@gmx.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

mick wrote:
> are you asking me personally to test or is this a general call for the
> group?

Both.  I cannot apply this patch before it is tested by somebody.

> If you need me to test, what version of kernel sources do I patch?

Any more-or-less recent version should work.

> Your patch looks quite different from the solution I pointed out. Why?

That patch did some inefficient and superfluous things, and anonymous
patches cannot go into the kernel.

> In particular the assertion:
>> +         * The TEAC UD-H01 firmware sometimes changes the feedback value
>> +         * by +/- 0x1.0000.
> is quite different from the assertion
> "the 3rd byte of the feadback value is getting corrupted and probably
> changing when it should not "

These two assertions describe the same change.

> Also, you made it quite explicit for the TEAC UD-H01 but I think it
> should be more general. I have the Teac A-H01 and it also has the
> problem. As far as I gather from the various discussions on the Web it
> probably is a general Tenor 8802 issue.

I was not aware of these other devices.  What are the vendor/device IDs
of the A-H01?


Regards,
Clemens
