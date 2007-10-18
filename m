From: Jan-Simon =?iso-8859-1?q?M=F6ller?= <dl9pf@gmx.de>
Subject: Re: [alsa-devel] hda-intel: no soundcard with current linus' =?iso-8859-1?q?git=09tree?=
Date: Thu, 18 Oct 2007 17:05:17 +0200
Message-ID: <200710181705.18265.dl9pf@gmx.de>
References: <471538C2.80806@m3y3r.de> <s5hhcko2668.wl%tiwai@suse.de> <200710181350.48974.dl9pf@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1765941AbXJRPFi@vger.kernel.org>
In-Reply-To: <200710181350.48974.dl9pf@gmx.de>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Hi !

I compiled some different kernel and tried - no success without module, 
module=fujitsu, module=laptop, model=asus. I went through the alsa doc and 
found the section about Conexant 5047. I tried it and got some sound when 
using module=laptop-hp.

So I suppose some pins are different here.

So let's summarize: I get sound on a 2.6.23 with module=laptop-hp. Laptop is a 
fujitsu-siemens v5505 as mentioned.

Best regards
Jan-Simon
