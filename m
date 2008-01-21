From: Philippe Paravicini <philippe@paravicini.com>
Subject: Re:
	=?iso-8859-1?q?Support_for_Compaq_Presario_F700_-_mo?=
	=?iso-8859-1?q?del_755US=09-=09NVidia_MCP67_Audio_-_Codec_Conexant?=
	=?iso-8859-1?q?_5051?=
Date: Mon, 21 Jan 2008 13:42:42 -0800
Message-ID: <200801211342.43148.philippe@paravicini.com>
References: <200801181655.05217.philippe@paravicini.com>
	<200801211343.33892.herton@mandriva.com.br>
	<1200931888.30379.36.camel@razman.gruemaster.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp116.sbc.mail.sp1.yahoo.com (smtp116.sbc.mail.sp1.yahoo.com
	[69.147.64.89]) by alsa0.perex.cz (Postfix) with SMTP id 8B89F248BB
	for <alsa-devel@alsa-project.org>; Mon, 21 Jan 2008 22:42:48 +0100 (CET)
In-Reply-To: <1200931888.30379.36.camel@razman.gruemaster.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, Claudio Matsuoka <cmatsuoka@gmail.com>, alsa-user@alsa-project.org, Herton Ronaldo Krzesinski <herton@mandriva.com.br>
List-Id: alsa-devel@alsa-project.org

Good news ! I installed the patch at:

> http://www.linuxant.com/alsa-hg-20080120.patch

and was able to get the jack to mute the speakers. I also tested w/ skype and 
the mic appears to work properly. I understand from the email from the 
linuxant people that there may still be a couple of issues with the driver, 
but from my perspective it solved my short-term problem (jack not muting the 
speakers).  I also see that the alsa-mixer and kmixer have more settings.

Thank you very much for your help,
let me know if I can help you test the patch further.

Open Source rocks !

Philippe Paravicini


For the sake of posterity, I describe below the steps that I took to install 
the patched driver.

The patch above, as stated in the email forwarded by the linuxant folks is 
relative to the current source in the mercurial source repository as of 
around 2008-11-20.  It will not work against the current 1.0.15 source 
distribution, or prior sources.

Hence, one needs to download the source from the source repository.

I followed these steps:

1. 'apt-get install mercurial'  (for debian/ubuntu folks) to install the 
mercurial source repository client

2. download the 'alsa-driver' and 'alsa-kernel' sources as indicated at:

	http://www.alsa-project.org/main/index.php/SourceCodeRepository
	
 I installed these in /usr/src/alsa

3. download the patch:

	http://www.linuxant.com/alsa-hg-20080120.patch

4. patch the alsa-kernel/pci/hda folder:

	cp alsa-hg-20080120.pach alsa-kernel/pci/hda
	cd alsa-kernel/pci/hda
	patch -i alsa-hg-20080120.patch    (should run w/o errors)

5. consult the alsa-driver/INSTALL file, section 'Compiling from HG Sources' 
6. cd alsa-driver
7. ./hgcompile
8. make install
9. reboot (there is probably a shorter way to reload the driver)


Note that before taking the steps above, I attempted to fix the problem by 
installing from source the  latest 1.0.15 version of the alsa-driver, 
alsa-libs and alsa-utils projects, as described in:

  https://help.ubuntu.com/community/HdaIntelSoundHowto

Hence, I do not know whether the patched drive above will work when used with 
versions 1.0.14 and prior of the alsa-libs and alsa-utils projects.



----  Original Message  ----

Subject: Re: [alsa-devel] Support for Compaq Presario F700 - model 755US	-	
NVidia MCP67 Audio - Codec Conexant 5051
Date: Monday 21 January 2008
From: Tobin Davis <tdavis@dsl-only.net>
To: Herton Ronaldo Krzesinski <herton@mandriva.com.br>

> I already did.  They said they'd submit a patch sometime soon.  As a
> matter of fact, I just got a message in my inbox from them, that I'll
> forward.
>
> Tobin
>
> On Mon, 2008-01-21 at 13:43 -0200, Herton Ronaldo Krzesinski wrote:
> > Em Monday 21 January 2008 09:03:30 Takashi Iwai escreveu:
> > > At Sat, 19 Jan 2008 21:23:29 -0200,
> > >
> > > Herton Ronaldo Krzesinski wrote:
> > > > Em Saturday 19 January 2008 12:45:52 Claudio Matsuoka escreveu:
> > > > > On Jan 19, 2008 9:56 AM, Tobin Davis <tdavis@dsl-only.net> wrote:
> > > > > > I have already requested documentation and a development board
> > > > > > from Conexant, so I should be able to get a fully functional
> > > > > > driver going soon.  In the meantime, I'll try to get a test patch
> > > > > > out to you as soon as possible.
> > > > >
> > > > > If this is the Hermosa codec (see
> > > > > http://helllabs.org/codecgraph/out/hp-spartan-ng.svg), Herton has
> > > > > just finished fully functional support to it, based on the HP
> > > > > "Spartan 1.1"
> > > >
> > > > Yes, it was working, but there were some things to sort out, like the
> > > > Spartan 1.1 doesn't have to switch between capture source as each mic
> > > > (int, ext) has its own adc, and I hacked it without removing the
> > > > capture source from mixer.
> > > >
> > > > Also I worked on the same code provided by hsfmodem, that already has
> > > > support for 5051, but I don't know why it wasn't sent upstream yet by
> > > > Conexant/hsfmodem people.
> > > >
> > > > > laptop (subdevice ID is 14f1:5051).
> > > > >
> > > > > Herton, did you submit the patches for Hermosa support to the list?
> > > >
> > > > No, as I didn't fixed the patches for proper submission, and the part
> > > > of hsfmodem probably Conexant/Linuxant people should send with proper
> > > > Signed-offs etc. But anyway I'll attach here the patches for
> > > > reference, that are not ready for inclusion and will not apply to
> > > > current alsa tree.
> > >
> > > Thanks.  Do you happen to know how linuxant guys think of the patch
> > > submission?  Of couse, the HSF modem part can be never merged to the
> > > upstream, but the sane GPL'ed part could be good to merge.
> >
> > Hi, don't know too, I'll try to contact Linuxant and ask about submission
> > for Hermosa support.
> >
> > > Takashi
> >
> > --
> > []'s
> > Herton
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@alsa-project.org
> > http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
