From: =?iso-8859-2?q?Rafa=B3_Zawadzki?= <bluszcz@jabberpl.org>
Subject: Re: problem with ATI SB600 Azalia
Date: Thu, 2 Aug 2007 00:32:00 +0200
Message-ID: <200708020032.00930.bluszcz@jabberpl.org>
References: <200708012157.11350.bluszcz@jabberpl.org>
	<s5hk5sezz2v.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.jabberpl.org (unknown [195.116.239.3])
	by alsa0.perex.cz (Postfix) with ESMTP id 278BE10384D
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Aug 2007 00:32:08 +0200 (CEST)
Received: from antichrist.local (chello084010037230.chello.pl [84.10.37.230])
	by mail.jabberpl.org (Postfix) with ESMTP id 5EA649437E
	for <alsa-devel@alsa-project.org>;
	Thu,  2 Aug 2007 00:32:01 +0200 (CEST)
In-Reply-To: <s5hk5sezz2v.wl%tiwai@suse.de>
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
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thursday 02 August 2007 00:09:44 Takashi Iwai wrote:
> At Wed, 1 Aug 2007 21:57:11 +0200,
>
> Rafa=B3 Zawadzki wrote:
> > Hello. I tried earlier on alsa-user, but nobody answer. Propably this is
> > the better place for this post. I have the same problem as mentioned
> > here:
> >
> > http://thread.gmane.org/gmane.linux.alsa.devel/47688/focus=3D47827 (the
> > same laptop).
> >
> > I tried this solution, but unfortunately i had below error during kernel
> > compilation (kernel source ubuntu 2.6.20-16). What is proper way to make
> > upgrade alsa to alsa-hg?
>
> Use alsa-driver tree to build external modules. =


It is not so easy :) :

./configure: line 11726: ALSA_TOPLEVEL_SELECT: command not found
./configure: line 11739: ALSA_TOPLEVEL_DEFINES: command not found
./configure: line 11749: ALSA_TOPLEVEL_OUTPUT: command not found
configure: creating ./config.status
config.status: creating version
config.status: creating Makefile.conf
config.status: WARNING:  Makefile.conf.in seems to ignore the --datarootdir =

setting
config.status: creating snddevices
config.status: creating utils/alsa-driver.spec
config.status: creating utils/buildrpm
config.status: error: cannot find input file: toplevel.config.in
bluszcz@antichrist:~/usr/src/alsachuj/alsa-driver$   =


Any idea?

-- =

Rafa=B3 bluszcz Zawadzki =

http://my.jabberpl.org - use jabber
http://glam.pl - try secondhand clothes
http://bluszcz.net - my homepage
