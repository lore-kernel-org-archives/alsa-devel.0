From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [2.4]ALi M5451 sound hangs on init; workaround
Date: 11 Dec 2002 19:39:48 +0000
Sender: linux-kernel-owner@vger.kernel.org
Message-ID: <1039635588.18587.8.camel@irongate.swansea.linux.org.uk>
References: <200212110715.20617.fedor@apache.org>
	<1039625298.18087.61.camel@irongate.swansea.linux.org.uk>
	<200212110852.42778.fedor@apache.org>  <200212111036.21771.fedor@apache.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+linux-kernel=40quimby.gnus.org@vger.kernel.org>
In-Reply-To: <200212111036.21771.fedor@apache.org>
To: Fedor Karpelevitch <fedor@apache.org>
Cc: lkml <linux-kernel@vger.kernel.org>, Vicente Aguilar <bisente@bisente.com>, alsa-devel@lists.sourceforge.net, Debian-Laptops <debian-laptop@lists.debian.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 2002-12-11 at 18:36, Fedor Karpelevitch wrote:
> almost as I posted before, just passing pointers to the read method.
> It works, but the question as to what is this supposed to affect 
> remains...

If I am reading the docs right then its just a thinko in the code and it
is meant to be toggling that bit not whacking the entire register.
