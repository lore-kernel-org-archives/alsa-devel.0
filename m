From: "Paul Kavan" <pkavan@gmail.com>
Subject: Re: Alsa lib configure asoundlib.h
Date: Tue, 10 Jul 2007 16:11:33 -0500
Message-ID: <61c0054e0707101411p4f6c9fcdr7f398e9bd52e6bd6@mail.gmail.com>
References: <468D0AFA.20208@tse.gov.br> <s5hwsxd50fg.wl%tiwai@suse.de>
	<s5h3azwl5p2.wl%tiwai@suse.de>
	<61c0054e0707100805m446a1bf0xbd12d6da6d68fde6@mail.gmail.com>
	<20070710160423.748e5cd6.AlsaUser@PragmaSoft.com>
	<61c0054e0707101322h1d554d9ax1a52a4ceaf8826f8@mail.gmail.com>
	<20070710165929.7c21881a.AlsaUser@PragmaSoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mu-out-0910.google.com (mu-out-0910.google.com [209.85.134.184])
	by alsa0.perex.cz (Postfix) with ESMTP id 79983103850
	for <alsa-devel@alsa-project.org>;
	Tue, 10 Jul 2007 23:11:35 +0200 (CEST)
Received: by mu-out-0910.google.com with SMTP id w8so1264513mue
	for <alsa-devel@alsa-project.org>; Tue, 10 Jul 2007 14:11:34 -0700 (PDT)
In-Reply-To: <20070710165929.7c21881a.AlsaUser@PragmaSoft.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "J. Scott Merritt" <AlsaUser@pragmasoft.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 7/10/07, J. Scott Merritt <AlsaUser@pragmasoft.com> wrote:
>
> On Tue, 10 Jul 2007 15:22:30 -0500
> "Paul Kavan" <pkavan@gmail.com> wrote:
>
> > > Perhaps you just need to run the "strip" tool to remove symbols from
> the
> > > Object file ?
> > >
> >
> > I am really new to this. Could you tell me how to do that?
>
> I haven't followed closely, but I believe that you are cross compiling.
> In other words, somewhere you found/built a copy of "gcc" that runs
> on your host and builds executables for your target.
>
> In the same "place" that you found/built that copy of gcc, there should
> be some other tools, including "strip".  Simply run:
> "strip libasound.so" or perhaps "strip libsalsa.so".
>


Thanks Scott:

That is exactly the case. I am developing an embedded system for an ARM
platform. My host machine is a i686 type. I do in fact have a cross-tool
called arm-linux-strip. I will work on that first with alsa then look at
salsa. My problem with salsa is that for testing, I want to make sure I can
use aplay and am having a hard time cross-compiling aplay with salsa.

Thanks.

Paul

-- 
***************************************
Paul David Kavan
Project Engineer
GRH Electronics, Inc.
402-734-4900
pkavan@gmail.com
***************************************
