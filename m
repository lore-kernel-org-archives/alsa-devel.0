From: Brendan Pike <spike@spykes.net>
Subject: Re: Will there ever be emu20k1/x-fi support in Alsa?
Date: Wed, 8 Oct 2008 00:22:08 -0400
Message-ID: <20081008002208.464cb3aa@darius>
References: <1223248483.19560.9.camel@home> <20081006212526.219130@gmx.net>
	<1223361156.20470.0.camel@home> <48EB049C.1010002@gmail.com>
	<1223426782.11647.5.camel@home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.spykes.net (dsl.spykes.net [76.10.173.13])
	by alsa0.perex.cz (Postfix) with ESMTP id D291E243CF
	for <alsa-devel@alsa-project.org>;
	Wed,  8 Oct 2008 06:22:21 +0200 (CEST)
In-Reply-To: <1223426782.11647.5.camel@home>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Ted T. Logian" <tedtheologian@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 07 Oct 2008 19:46:22 -0500
"Ted T. Logian" <tedtheologian@gmail.com> wrote:

> Yes, but it is better than nothing, and perhaps some of that is a
> limitation of oss4:).
> 
> On Tue, 2008-10-07 at 10:41 +0400, The Source wrote:
> 
> > That driver isn't too good unfortunately. No surround support, sample 
> > rate stuck at 96000Hz and is read-only (this makes apps that require 
> > explicit sample rate to fail to use sound), no pulse-audio compatibility 
> > (pulse-audio fails to load oss modules).
> > 
> > Ted T. Logian ?????:
> > > >From what I understand, they did not use creative code/license for the
> > > oss4 support, so I wouldn't see why not.
> > >
> > > On Mon, 2008-10-06 at 23:25 +0200, Sebastian Schneider wrote:
> > >
> > >   
> > >> Isn't it a question of the license? I mean is it allowed just to port the OSS Code with the Creative Part to Alsa?
> > >>
> > >>     
> > >>> I had to ask because oss4 has had emu20k1/x-fi support for a long time
> > >>> now.  However, it has the obvious limitations of oss4 and also you
> > >>> cannot use usb microphones, so I can't use skype which I'd really like
> > >>> to do.
> > >>>
> > >>>       

Porting the oss4 driver over to ALSA would be a start until someone
can get hold of the datasheets to make it a proper driver with
hardware mixing and all. Anyone up to the task that we can donate
money to buy hardware or actual hardware to?

The newer PCIe EMU20K2 X-Fi Titaniums are the ones that are supposed to
have the intel-hda-audio backwards compatibility, but the older X-Fi's
based on the EMU20K1 do not. I guess this compatibility is a Vista
requirement so it appears on the new metal cladded X-Fi models.

Then there's the "fake" X-Fi's based on the CA0106 that
are supported by ALSA already. Lets not confuse those.
