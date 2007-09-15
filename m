From: Denys Vlasenko <vda.linux@googlemail.com>
Subject: Re: Per option CFLAGS?
Date: Sat, 15 Sep 2007 16:53:47 +0100
Message-ID: <200709151653.48351.vda.linux@googlemail.com>
References: <46EB141A.7090200@gmail.com> <20070915084754.GO3563@stusta.de> <46EBF774.2030306@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755860AbXIOPyL@vger.kernel.org>
In-Reply-To: <46EBF774.2030306@gmail.com>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Rene Herman <rene.herman@gmail.com>
Cc: Adrian Bunk <bunk@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Kai Germaschewski <kai@germaschewski.name>, Sam Ravnborg <sam@ravnborg.org>, Linux Kernel <linux-kernel@vger.kernel.org>, ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Saturday 15 September 2007 16:17, Rene Herman wrote:
> On 09/15/2007 10:47 AM, Adrian Bunk wrote:
> >>> The stub source file is usually considered a good way to do this.
> >> Mmm. If I'll have to live with it, I can, but thought I'd ask if there was 
> >> some nice build trickery available instead.
> > 
> > The usual trick is to create _three_ modules:
> > 
> > Two with the foo2000 and foo2001 specific parts, and a third one with 
> > all code used by both.
> > 
> > Or if foo2000 and foo2001 differ only in small details, create one 
> > snd-foo200x module supporting both at the same time.
> 
> Thanks for the comment. Yes, first would be massive overkill in this case 
> and second somewhat annoying as one of the differences is support for 
> different resources (IRQs) among the two versions, whereas I'm checking the 
> validity of the passed in values at a time I do not know which version I'm 
> looking at yet -- knowing that requires having talked to the hardware.

If I understood you right, this is PCI, USB or other kind of devices
where module is selected according to PCI/USB/whatever IDs.

You thinking is - if module foo2000 is loaded, this is definitely a
2000 device and you can "check the validity of the passed in values"
for the device 2000 now.

Correct me if I'm wrong.

But you can do absolutely the same at runtime in unified driver,
since PCI/USB/whatever IDs are accessible to the driver.

Two drivers will most likely have code duplication.

Unified driver will be harder to read and maintain because of all
ifs/switch's/function pointers you need.

The choice depends on *how much* maintainability pain you can
tolerate by taking "unified code" path.

> Can do, but for now it seems like the two seperate modules might be cleaner. 

Can you give a bit more info what the dirrefences between devices are
in this particular cases?
--
vda
