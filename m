From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [alsa-devel] [PATCH] ALSA: msnd: Optimize / harden DSP and MIDI
 loops
Date: Tue, 12 Sep 2017 05:34:18 -0700
Message-ID: <20170912123418.GB19179@kroah.com>
References: <20170908160626.24771-1-gtertych@cisco.com>
 <s5hzia0o06l.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <s5hzia0o06l.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "Grygorii Tertychnyi (gtertych)" <gtertych@cisco.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "xe-linux-external(mailer list)" <xe-linux-external@cisco.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Sep 12, 2017 at 09:17:38AM +0200, Takashi Iwai wrote:
> On Fri, 08 Sep 2017 19:47:32 +0200,
> Grygorii Tertychnyi (gtertych) wrote:
> > 
> > 
> > >> Hi Greg,
> > >>
> > >> Could you please apply it for 4.4-stable.
> > >> This fixes https://nvd.nist.gov/vuln/detail/CVE-2017-9985
> > >
> > > This vulnerability is just non-issue.  You can't get it working
> > > practically; it requires a modified hardware of the decade old ISA
> > > sound card, and yet the system has to load / set up the module
> > > beforehand.  We should withdraw it from CVE, IMO.
> > 
> > I think it is worth having it in 4.4, 4.9 and 4.12 also.
> 
> ... even though the code has never been tested on the real hardware?
> That doesn't sound good for stable kernels at all.  That's why I
> didn't put Cc to stable in the patch.

Oh, I didn't know that, want me to drop the patch from the stable queues
now?

thanks,

greg k-h
