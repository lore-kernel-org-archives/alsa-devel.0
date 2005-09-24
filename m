From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [BUG] alsa volume and settings not restored after suspend
Date: Sat, 24 Sep 2005 16:28:16 -0400
Message-ID: <1127593697.18892.1.camel@mindpipe>
References: <4335909D.2070904@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1750774AbVIXWy6@vger.kernel.org>
In-Reply-To: <4335909D.2070904@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: patrizio.bassi@gmail.com
Cc: "Kernel," <linux-kernel@vger.kernel.org>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sat, 2005-09-24 at 19:45 +0200, Patrizio Bassi wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> As topic.
> 
> Suspend works perfectly, but after resume, no sound from audio card.

I'm not surprised, suspend/resume is not implemented for that device.

It looks like it would not be too hard, see es1938.c for an example.

Lee
