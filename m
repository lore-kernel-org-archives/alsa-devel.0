From: Damien Wyart <damien.wyart@free.fr>
Subject: Re: [alsa-devel] [BUG] 3.10.[01] modprobe snd-... hangs
Date: Tue, 16 Jul 2013 09:49:25 +0200
Message-ID: <20130716074925.GA9631@brouette>
References: <20130715182010.GA4853@pmhahn.de>
 <87ppujysbk.fsf@rustcorp.com.au>
 <s5h38rfngx3.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5h38rfngx3.wl%tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Philipp Matthias Hahn <pmhahn@pmhahn.de>, alsa-devel@alsa-project.org, Kernel Mailing List <linux-kernel@vger.kernel.org>, Lucas De Marchi <lucas.demarchi@profusion.mobi>
List-Id: alsa-devel@alsa-project.org

* Takashi Iwai <tiwai@suse.de> [2013-07-16 08:43]:
> At Tue, 16 Jul 2013 15:11:51 +0930,
> Rusty Russell wrote:

> > Philipp Matthias Hahn <pmhahn@pmhahn.de> writes:
> > > Hello,

> > > My x86_64 systems has some trouble loading some ALSA snd-* modules since
> > > the upgrade to 3.10.[01]: Several automatic modprobe calls hang, but
> > > loading snd-intel-hda and snd-audio-usb by hand still works.

> > Not a known problem to me, at least.  Perhaps it's a dep loop somehow.

> I remember that someone reported it being Debian specific snd-seq-oss
> loading stuff.

There is also additional information here:
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=660803

-- 
Damien Wyart
