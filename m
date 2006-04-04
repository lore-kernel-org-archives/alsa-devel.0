From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
Subject: Re: Patch for AICA sound support on SEGA Dreamcast
Date: Tue, 4 Apr 2006 01:16:13 +0100
Message-ID: <200604040116.13732.s0348365@sms.ed.ac.uk>
References: <1144075522.11511.20.camel@localhost.localdomain> <443162B4.60500@kenati.com> <s5hzmj28q8k.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S964907AbWDDAQS@vger.kernel.org>
In-Reply-To: <s5hzmj28q8k.wl%tiwai@suse.de>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Carlos Munoz <carlos@kenati.com>, Adrian McMenamin <adrian@mcmen.demon.co.uk>, Alsa-devel <alsa-devel@lists.sourceforge.net>, linux-sh <linuxsh-dev@lists.sourceforge.net>, Paul Mundt <lethal@linux-sh.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Monday 03 April 2006 19:32, Takashi Iwai wrote:
> At Mon, 03 Apr 2006 11:00:20 -0700,
>
> Carlos Munoz wrote:
> > Takashi Iwai wrote:
> > >Please avoid use of typedefs as much as possible.
> > >We (finally :-) got rid of whole typedefs recently from the ALSA core
> > >code.
> >
> > Hi Takashi,
> >
> > Just out of curiosity. What is the reason for no using typedefs ?
>
> Just to follow the convention of coding style in kernel tree.
>
> There are some reasons that typedefs are evil, but I don't want to
> start flames :)

I also do not wish to start a flame war, but I will direct Carlos to this URL:

http://www.linuxjournal.com/article/5780

I think this write-up provides justification. However, it is not part of 
linux/Documentation/CodingStyle. Perhaps somebody should add these details to 
this file, so that new code follows this currently 'unwritten' rule.

-- 
Cheers,
Alistair.

'No sense being pessimistic, it probably wouldn't work anyway.'
Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
