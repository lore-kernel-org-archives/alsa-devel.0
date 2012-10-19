From: Pete Leigh <pete.leigh@gmail.com>
Subject: Re: Fwd: Support for Roland VG-99 (working code,
 but could use help)
Date: Fri, 19 Oct 2012 18:02:03 +0100
Message-ID: <CABn3OEH4n5i_UNMQSVM9a+gUBD5mXH=faeazu038Kdy_p9G+AQ@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ia0-f179.google.com (mail-ia0-f179.google.com
 [209.85.210.179])
 by alsa0.perex.cz (Postfix) with ESMTP id 9884D265CAC
 for <alsa-devel@alsa-project.org>; Fri, 19 Oct 2012 19:02:04 +0200 (CEST)
Received: by mail-ia0-f179.google.com with SMTP id k25so431148iah.38
 for <alsa-devel@alsa-project.org>; Fri, 19 Oct 2012 10:02:03 -0700 (PDT)
In-Reply-To: <CABn3OEF18-Q3agOZ3Er5BODDo2R=H-G4Njdua-1L_E1uXHqpMw@mail.gmail.com>
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

On 19 October 2012 09:49, Pete Leigh <pete.leigh@gmail.com> wrote:
> On 19 October 2012 09:24, Daniel Mack <zonque@gmail.com> wrote:
>> You should extract the config of the old kernel (/proc/config.gz)
>> and use this as start for building the upstream.

 > I'll try re-doing the kernel based off config.gz from the distro
> kernel, as you suggest,
[...]
> If this problem is confined to the usb subsystem, it seems unlikely I
> broke anything with my config operations, but I'm no expert certainly.

Perhaps predictably after saying this, I find that using
/boot/config-3.5.4-1.fc17.x86_64 as .config, then make localmodconfig
and make menuconfig to turn off loads of network device drivers and
such that would take hours to compile, usb audio is working on the
sound.git kernel :-/

I quickly tested the VG-99 quirk (modified as per Clemens' suggestion)
and that works too, so I'll work on generating a patch as per the
instructions on alsa-project.org.

If it's any use regarding the urb 0 -ENOSPACE error I was having,  I
can try and track down the config item difference that makes it work,
or provide the config files for you to look at.. Please let me know if
this would be useful.

Should there be some dependency in the configs so that whatever item
is making the difference is enabled by selecting SND_USB_AUDIO ?

Thanks for the pointers :)

Cheers,

- Pete.
