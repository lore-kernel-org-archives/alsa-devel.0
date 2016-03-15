From: "Lu, Han" <han.lu@intel.com>
Subject: Re: [PATCH 02/10] alsabat: add standalone mode
Date: Tue, 15 Mar 2016 03:45:40 +0000
Message-ID: <B51200AC81AB024499A3C2C9A1BB90A83D3AAE7A@SHSMSX101.ccr.corp.intel.com>
References: <cover.1456907242.git.han.lu@intel.com>
 <5c8e6ec9f17e113f77f4ac89b02c51809e377400.1456907242.git.han.lu@intel.com>
 <s5hr3fl9srx.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 3D4182605CA
 for <alsa-devel@alsa-project.org>; Tue, 15 Mar 2016 04:45:45 +0100 (CET)
In-Reply-To: <s5hr3fl9srx.wl-tiwai@suse.de>
Content-Language: en-US
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
Cc: "liam.r.girdwood@linux.intel.com" <liam.r.girdwood@linux.intel.com>, "Gautier, Bernard" <bernard.gautier@intel.com>, "Popescu,
 Edward C" <edward.c.popescu@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Tuesday, March 8, 2016 6:19 PM
> To: Lu, Han <han.lu@intel.com>
> Cc: liam.r.girdwood@linux.intel.com; Gautier, Bernard
> <bernard.gautier@intel.com>; Popescu, Edward C
> <edward.c.popescu@intel.com>; alsa-devel@alsa-project.org
> Subject: Re: [PATCH 02/10] alsabat: add standalone mode
> 
> On Wed, 02 Mar 2016 09:53:12 +0100,
> han.lu@intel.com wrote:
> >
> > From: "Lu, Han" <han.lu@intel.com>
> >
> > Add support for standalone mode where alsabat will run on a different
> > machine to the one being tested.
> > In standalone mode, the sound data can be generated, playback and
> > captured just like in normal mode, but will not be analyzed.
> > The alsabat being built without libfftw3 support is always work in
> > standalone mode.
> > The alsabat in normal mode can also bypass data analysis using option
> > "--standalone".
> >
> > Signed-off-by: Lu, Han <han.lu@intel.com>
> >
> > diff --git a/bat/Makefile.am b/bat/Makefile.am index 8dfafa9..5646e9a
> > 100644
> > --- a/bat/Makefile.am
> > +++ b/bat/Makefile.am
> > @@ -6,7 +6,6 @@ EXTRA_DIST = alsabat.1  alsabat_SOURCES = \
> >  	bat.c \
> >  	common.c \
> > -	analyze.c \
> >  	signal.c \
> >  	convert.c \
> >  	alsa.c
> > @@ -15,8 +14,12 @@ noinst_HEADERS = \
> >  	common.h \
> >  	bat-signal.h \
> >  	alsa.h \
> > -	convert.h \
> > -	analyze.h
> > +	convert.h
> > +
> > +if HAVE_LIBFFTW3
> > +alsabat_SOURCES += analyze.c
> > +noinst_HEADERS += analyze.h
> > +endif
> 
> I wonder how "make dist" works if running on a system without fftw3...
> Does it pack these conditional files, too?
> 
> 
> Takashi

[han] after remove libfftw3 by "sudo apt-get remove libfftw3-dev", I cloned
a new alsabat repo, patch and build with
	./gitcompile
	./configure
	make
	sudo make install
and then ran "make dist", and the analyze.c and analyze.h are included in the
.bz2 and the .gz packages. I suppose it's the result we expected?

BR,
Han
