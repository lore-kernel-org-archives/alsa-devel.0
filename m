From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Per option CFLAGS?
Date: Fri, 14 Sep 2007 16:13:29 -0700
Message-ID: <46EB1599.4020806@zytor.com>
References: <46EB141A.7090200@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759918AbXINXN5@vger.kernel.org>
In-Reply-To: <46EB141A.7090200@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Rene Herman <rene.herman@gmail.com>
Cc: Kai Germaschewski <kai@germaschewski.name>, Sam Ravnborg <sam@ravnborg.org>, Linux Kernel <linux-kernel@vger.kernel.org>, ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Rene Herman wrote:
> Hi Kai, Sam.
> 
> I have a single file foo.c that I want to generate two (ALSA) modules
> from, snd-foo2000.ko and snd-foo2001.ko, by compiling with either
> FOO2000 or FOO2001 defined.
> 
> I can do this, and ALSA does this a few times, by providing dummy
> foo2000.c and foo2001.c files, like:
> 
> === foo2000.c
> #define FOO2000
> #include "foo.c"
> ===
> 
> and a regular Makefile
> 
> ===
> foo2000-objs := foo2000.o
> foo2001-objs := foo2001.o
> 
> obj-$(CONFIG_SND_FOO2000) += snd-foo2000.o
> obj-$(CONFIG_SND_F002001) += snd-foo2001.o
> ===
> 
> That #include is a little lame though. Is there a nicer way? I noticed
> the per-file CFLAGS, but given that it's one source file for both, that
> doesn't fit.
> 

The stub source file is usually considered a good way to do this.

	-hpa
