From: stan <stanl@cox.net>
Subject: Re: SOLVED Re: snd_pcm_hw_params_set_format fails with
 invalid argument
Date: Tue, 7 Aug 2007 08:26:21 -0700
Message-ID: <20070807082621.5a557ca4@localhost.localdomain>
References: <20070803112049.7ced76ec@localhost.localdomain>
	<20070805131041.67c04d1e@localhost.localdomain>
	<20070806090457.1ec96108@localhost.localdomain>
	<20070806092201.37bdc18e@localhost.localdomain>
	<s5habt31n33.wl%tiwai@suse.de>
	<20070807080242.0da2a0ff@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fed1rmmtao107.cox.net (fed1rmmtao107.cox.net [68.230.241.39])
	by alsa0.perex.cz (Postfix) with ESMTP id E65C610385D
	for <alsa-devel@alsa-project.org>;
	Tue,  7 Aug 2007 17:26:23 +0200 (CEST)
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao107.cox.net
	(InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
	id <20070807152622.JXK7349.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>
	for <alsa-devel@alsa-project.org>; Tue, 7 Aug 2007 11:26:22 -0400
In-Reply-To: <20070807080242.0da2a0ff@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I sent this directly to Takashi by mistake.  I could have sworn I saw
the list in the to field but I must be mistaken.  Here it is for the
list.

On Tue, 7 Aug 2007 08:02:42 -0700
stan <stanl@cox.net> wrote:

> On Tue, 07 Aug 2007 15:38:40 +0200
> Takashi Iwai <tiwai@suse.de> wrote:
> 
> > At Mon, 6 Aug 2007 09:22:01 -0700,
> > stan wrote:
> > > 
> > > On Mon, 6 Aug 2007 09:04:57 -0700
> > > stan <stanl@cox.net> wrote:
> > > 
> > > > I downloaded the hg alsa-lib snapshot of July 14, 2007, compiled
> > > > it, (on Fedora 7 you will have to make a link to compile,
> > > > cd /usr/include
> > > > ln -s python2.5 python)
> > > > and linked my program against it.  It works again so the issue
> > > > has been fixed in the latest version of alsa lib.  Any estimate
> > > > of when this version will be released for public consumption?
> > > > My app is dead in the water with the current version of alsa, so
> > > > anyone trying to use it will have a terrible user
> > > > experience.  :-(  I want to give some indication of when people
> > > > can expect it to start working again. In the meantime I'll
> > > > create instructions on how to install the hg version to
> > > > usr/local and change the library linking.
> > > > 
> > > > Thanks.
> > > > 
> > > For anyone interested, these are the formats that fail in 1.0.14
> > > final
> > > 
> > > Value of last format 43
> > > test of sample format 14 failed (Invalid argument)
> > > test of sample format 15 failed (Invalid argument)
> > > test of sample format 16 failed (Invalid argument)
> > > test of sample format 17 failed (Invalid argument)
> > > test of sample format 18 failed (Invalid argument)
> > > test of sample format 19 failed (Invalid argument)
> > > test of sample format 23 failed (Invalid argument)
> > > test of sample format 24 failed (Invalid argument)
> > > test of sample format 25 failed (Invalid argument)
> > > test of sample format 26 failed (Invalid argument)
> > > test of sample format 27 failed (Invalid argument)
> > > test of sample format 28 failed (Invalid argument)
> > > test of sample format 29 failed (Invalid argument)
> > > test of sample format 30 failed (Invalid argument)
> > > test of sample format 31 failed (Invalid argument)
> > > Format returned (0)
> > > 
> > > 
> > > and these are the formats that fail in the hg version.
> > > 
> > > Value of last format 43
> > > test of sample format 18 failed (Invalid argument)
> > > test of sample format 19 failed (Invalid argument)
> > > test of sample format 23 failed (Invalid argument)
> > > test of sample format 24 failed (Invalid argument)
> > > test of sample format 25 failed (Invalid argument)
> > > test of sample format 26 failed (Invalid argument)
> > > test of sample format 27 failed (Invalid argument)
> > > test of sample format 28 failed (Invalid argument)
> > > test of sample format 29 failed (Invalid argument)
> > > test of sample format 30 failed (Invalid argument)
> > > test of sample format 31 failed (Invalid argument)
> > > Format returned (16)
> > 
> > Could you give me the simple test case for checking the same thing
> > on my system?
> > 
> > 
> > thanks,
> > 
> > Takashi
> 
> They are attached as file test_case.c and shell script mktest.
> 
> Running ./mktest should generate an executable named test_case.
> Running that should generate the above output.
> 
> 
