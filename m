From: Herton Ronaldo Krzesinski <herton@mandriva.com.br>
Subject: Re:
	=?iso-8859-1?q?Support_for_Compaq_Presario_F700_-_mo?=
	=?iso-8859-1?q?del_755US_-=09NVidia_MCP67_Audio_-_Codec_Conexant_5?=
	=?iso-8859-1?q?051?=
Date: Mon, 21 Jan 2008 13:43:32 -0200
Message-ID: <200801211343.33892.herton@mandriva.com.br>
References: <200801181655.05217.philippe@paravicini.com>
	<200801192123.29589.herton@mandriva.com.br>
	<s5h1w8bfnjx.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <s5h1w8bfnjx.wl%tiwai@suse.de>
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
Cc: Takashi Iwai <tiwai@suse.de>, Claudio Matsuoka <cmatsuoka@gmail.com>, alsa-user@alsa-project.org, Philippe Paravicini <philippe@paravicini.com>
List-Id: alsa-devel@alsa-project.org

Em Monday 21 January 2008 09:03:30 Takashi Iwai escreveu:
> At Sat, 19 Jan 2008 21:23:29 -0200,
>
> Herton Ronaldo Krzesinski wrote:
> > Em Saturday 19 January 2008 12:45:52 Claudio Matsuoka escreveu:
> > > On Jan 19, 2008 9:56 AM, Tobin Davis <tdavis@dsl-only.net> wrote:
> > > > I have already requested documentation and a development board from
> > > > Conexant, so I should be able to get a fully functional driver going
> > > > soon.  In the meantime, I'll try to get a test patch out to you as
> > > > soon as possible.
> > >
> > > If this is the Hermosa codec (see
> > > http://helllabs.org/codecgraph/out/hp-spartan-ng.svg), Herton has just
> > > finished fully functional support to it, based on the HP "Spartan 1.1"
> >
> > Yes, it was working, but there were some things to sort out, like the
> > Spartan 1.1 doesn't have to switch between capture source as each mic
> > (int, ext) has its own adc, and I hacked it without removing the capture
> > source from mixer.
> >
> > Also I worked on the same code provided by hsfmodem, that already has
> > support for 5051, but I don't know why it wasn't sent upstream yet by
> > Conexant/hsfmodem people.
> >
> > > laptop (subdevice ID is 14f1:5051).
> > >
> > > Herton, did you submit the patches for Hermosa support to the list?
> >
> > No, as I didn't fixed the patches for proper submission, and the part of
> > hsfmodem probably Conexant/Linuxant people should send with proper
> > Signed-offs etc. But anyway I'll attach here the patches for reference,
> > that are not ready for inclusion and will not apply to current alsa tree.
>
> Thanks.  Do you happen to know how linuxant guys think of the patch
> submission?  Of couse, the HSF modem part can be never merged to the
> upstream, but the sane GPL'ed part could be good to merge.

Hi, don't know too, I'll try to contact Linuxant and ask about submission for 
Hermosa support.

>
>
> Takashi

--
[]'s
Herton
