From: "Munzir Taha (=?utf-8?q?=D9=85=D9=86=D8=B0=D8=B1?=
	=?utf-8?q?_=D8=B7=D9=87?=)" <munzirtaha@gmail.com>
Subject: Re: My Codec: IDT 92HD75B3X5 issues
Date: Fri, 2 Oct 2009 09:15:22 +0300
Message-ID: <200910020915.23068.munzirtaha@gmail.com>
References: <200909300818.31295.munzirtaha@gmail.com>
	<200910020111.01552.munzirtaha@gmail.com>
	<s5h1vlmmk8u.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.157])
	by alsa0.perex.cz (Postfix) with ESMTP id 0AA32243A3
	for <alsa-devel@alsa-project.org>;
	Fri,  2 Oct 2009 08:15:27 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id e12so2313209fga.2
	for <alsa-devel@alsa-project.org>; Thu, 01 Oct 2009 23:15:26 -0700 (PDT)
In-Reply-To: <s5h1vlmmk8u.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Yaum al-Jumma 12 Shawwal 1430 8:34:57 am Takashi Iwai wrote:
> At Fri, 2 Oct 2009 01:11:01 +0300,
> 
>  Munzir Taha (=?utf-8?q?=D9=85=D9=86=D8=B0=D8=B1?=   
=?utf-8?q?_=D8=B7=D9=87?=) wrote:
> > On Yaum al-Khamees 11 Shawwal 1430 5:42:56 pm Takashi Iwai wrote:
> > > I found the culprit.  It's actually a bug happening between the analog
> > > and the digital mic switches.
> > > Try the patch below.
> > >
> > >
> > > Takashi
> >
> > Dear Takashi,
> > To complete this thread, what about missing options like
> > 1. Disabling "Headphone Jack Sense" to allow both speakers and headphones
> > to work together in case
> 
> You can give "hp_detect = 0" to hints via sysfs and reconfigure.

But this is not user friendly. I used to see it as an option on other cards.
 
> > 2. jack retasking where I can plug my mic in the headphone jack and
> > expect it to work


> I thought it works now?

No. If I plug the mic in the mic jack it works but if I plug it in the 
headphone jack it doesn't.
 
> > 2. Capture boost
> 
> "Mux" volume corresponds to it (for analog mic).
> The digital mic has another capture volume independently on this codec.

I will test this when I am back.


-- 
Munzir Taha
Telecommunications and Electronics Engineer
Master CIW Designer, ICDL, MOUS, Linux+, LPI, SCSA
Riyadh, SA
