From: "Robert P. J. Day" <rpjday@crashcourse.ca>
Subject: Re: any reason for include/uapi/sound header files not
 listed in Kbuild?
Date: Tue, 31 May 2016 08:54:29 -0400 (EDT)
Message-ID: <alpine.LFD.2.20.1605310853410.10394@localhost.localdomain>
References: <alpine.LFD.2.20.1605281508070.8417@localhost.localdomain>
 <s5h60tu5s1s.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp484.redcondor.net (smtp484.redcondor.net [208.80.204.84])
 by alsa0.perex.cz (Postfix) with ESMTP id 1B58026052B
 for <alsa-devel@alsa-project.org>; Tue, 31 May 2016 14:55:17 +0200 (CEST)
In-Reply-To: <s5h60tu5s1s.wl-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 31 May 2016, Takashi Iwai wrote:

> On Sat, 28 May 2016 21:10:32 +0200,
> Robert P. J. Day wrote:
> >
> >
> >   i just noticed that, in include/uapi/sound/, there are three header
> > files:
> >
> > * asoc.h
> > * tlv.h
> > * usb_stream.h
> >
> > that are not referenced by the corresponding Kbuild file. is there any
> > reason for this?
>
> There is no reason.  I noticed this sometime ago but forgot after
> that.
>
> > or, in general, is there *any* reason for there to be
> > header files under include/uapi/ that are not listed in their Kbuild
> > files? thanks.
>
> Yes, they should be included in Kbuild file.  So far, all user-space
> stuff is self-contained, keeping the copy of such files in it, thus
> there was no complaint due to the missing files.
>
> That said, feel free to send a fix patch ;)

  so the patch would be to include the missing files in Kbuild, not to
delete them? :-)

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
