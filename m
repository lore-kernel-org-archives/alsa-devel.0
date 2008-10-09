From: "Ted T. Logian" <tedtheologian@gmail.com>
Subject: Re: Will there ever be emu20k1/x-fi support in Alsa?
Date: Thu, 09 Oct 2008 12:27:39 -0500
Message-ID: <1223573259.13995.0.camel@home>
References: <1223248483.19560.9.camel@home> <20081006212526.219130@gmx.net>
	<1223361156.20470.0.camel@home> <48EB049C.1010002@gmail.com>
	<1223426782.11647.5.camel@home>  <s5hprmahyue.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rv-out-0708.google.com (rv-out-0708.google.com [209.85.198.245])
	by alsa0.perex.cz (Postfix) with ESMTP id E37252456C
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Oct 2008 19:28:00 +0200 (CEST)
Received: by rv-out-0708.google.com with SMTP id f25so100269rvb.32
	for <alsa-devel@alsa-project.org>; Thu, 09 Oct 2008 10:27:42 -0700 (PDT)
In-Reply-To: <s5hprmahyue.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, The Source <thesourcehim@gmail.com>
List-Id: alsa-devel@alsa-project.org

Myself and The source(if I might volunteer him) would likely to be happy
to test.  I certainly would.

I just want to be able to use my usb mic AND My soundcard at the same
time.  oss4 does not support usb mic recording on linux.

There's also oss4 problems with myth, etc.   I'm really anxious to get
back to alsa.


On Thu, 2008-10-09 at 12:00 +0200, Takashi Iwai wrote:

> At Tue, 07 Oct 2008 19:46:22 -0500,
> Ted T. Logian wrote:
> > 
> > Yes, but it is better than nothing, and perhaps some of that is a
> > limitation of oss4:).
> 
> Just looking at their code, and I can conclude it's a half-baked
> driver, indeed.  Fixed rate, no full duplex, no multi playback, no
> multi channel, etc, etc.
> 
> OTOH, it's pretty easy to port right now because of its shortness.
> More comprehensive be more longer codes.
> 
> OK, if the code is that long, I'll try to port as experimental.
> It's always good to have a reference at the beginning.
> Maybe it'll take one or two days...  Will inform you when it's ready.
> 
> Note that I have neither XFi hardware nor datasheet, so someone brave
> has to test it :)
>      
> 
> Takashi
> 
> > On Tue, 2008-10-07 at 10:41 +0400, The Source wrote:
> > 
> > > That driver isn't too good unfortunately. No surround support, sample 
> > > rate stuck at 96000Hz and is read-only (this makes apps that require 
> > > explicit sample rate to fail to use sound), no pulse-audio compatibility 
> > > (pulse-audio fails to load oss modules).
> > > 
> > > Ted T. Logian ?????:
> > > > >From what I understand, they did not use creative code/license for the
> > > > oss4 support, so I wouldn't see why not.
> > > >
> > > > On Mon, 2008-10-06 at 23:25 +0200, Sebastian Schneider wrote:
> > > >
> > > >   
> > > >> Isn't it a question of the license? I mean is it allowed just to port the OSS Code with the Creative Part to Alsa?
> > > >>
> > > >>     
> > > >>> I had to ask because oss4 has had emu20k1/x-fi support for a long time
> > > >>> now.  However, it has the obvious limitations of oss4 and also you
> > > >>> cannot use usb microphones, so I can't use skype which I'd really like
> > > >>> to do.
> > > >>>
> > > >>>       
> > > > _______________________________________________
> > > > Alsa-devel mailing list
> > > > Alsa-devel@alsa-project.org
> > > > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> > > >
> > > >   
> > > 
> > > _______________________________________________
> > > Alsa-devel mailing list
> > > Alsa-devel@alsa-project.org
> > > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> > 
