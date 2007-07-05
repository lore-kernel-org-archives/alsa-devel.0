From: "gt bradley" <baykelper@gmail.com>
Subject: PS3 - Surround sound on SPDIF set-up
Date: Thu, 5 Jul 2007 15:37:48 -0700
Message-ID: <c55b1dd60707051537v6f32c554m647c81fa5e43f839@mail.gmail.com>
References: <4689B1BF.2050709@gmail.com> <s5hps39a4hv.wl%tiwai@suse.de>
	<468A9A7A.7020802@gmail.com> <s5hfy44a8rn.wl%tiwai@suse.de>
	<468C47FD.7070003@gmail.com> <s5hy7hv5dag.wl%tiwai@suse.de>
	<c55b1dd60707051534o3e5665c7ue98b64d83a96773d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.171])
	by alsa0.perex.cz (Postfix) with ESMTP id CF8A61038E2
	for <alsa-devel@alsa-project.org>;
	Fri,  6 Jul 2007 00:37:49 +0200 (CEST)
Received: by ug-out-1314.google.com with SMTP id h2so595383ugf
	for <alsa-devel@alsa-project.org>; Thu, 05 Jul 2007 15:37:49 -0700 (PDT)
In-Reply-To: <c55b1dd60707051534o3e5665c7ue98b64d83a96773d@mail.gmail.com>
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

Crud   :(

 I had asked them and they said that the hypervisor should allow for AC3
pass-through.  In my inital review of the snd_ps3.c code, it looked like it
was basically a data-pump, handling the DMA & interupts to move data from
the passed in stream to the h/w (via the hypervisor).  I also assumed that
the iec bits (in headers in the SPDIF frames) were being set by higher
levels in the software stack.

If the bits are being set by the hardware and/or hypervisor then I'll have
to fall back to plan "B".

I've been programming for 20+ years, and have put kernel mods into
production, but the last kernel hacking/device driver I did was in SYSV.  I
can forward changes/fixes to Geoff, for inclusion rolling things
"upstream".  I don't have direct access to inside information other than the
source-code, but can forward the requests for more detailed info.

let me know if I can help
GT

p.s.  thanks for your time and patience.


On 7/5/07, Takashi Iwai <tiwai@suse.de> wrote:
>
> At Wed, 04 Jul 2007 18:23:09 -0700,
> GT Bradley wrote:
> >
> > right,
> >   For my Fedora install, these files are at /etc/alsa/cards,   (although
> > the iec958.conf) is in /etc/alsa/pcm).
> >
> > The iec958.conf seems resonable, although I don't fully understand the
> > syntax of the file, nor understand how the asoundrc file wires to
> > /etc/alsa/...  to the actual linux driver.   It seems to pass through to
>
> > the default device (which is what I want)
> >
> > using the system-config-soundcard utility, I do get surround sound, and
> > is displays the card as PS3 whcih matches the output of aplay -l    I've
>
> > tryed createing a /etc/alsa/cards/PS3.conf file as follows:
>
> It seems that the current PS3 driver doesn't support the passthru
> properly yet.  For AC3, you'd have to set up the IEC958 status bits,
> but the driver doesn't support it.  Some receivers are robust that
> work even without non-audio bit, but many receivers require the proper
> status bits.  I'll contact with SCE guys for fixing this issue.
>
>
> Takashi
>
