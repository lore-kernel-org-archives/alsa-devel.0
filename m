From: "Nenad Sljivic" <nenad.sljivic@rt-rk.com>
Subject: Re: Timer interface
Date: Tue, 2 Aug 2011 12:33:32 +0200
Message-ID: <C58CA57B5617482A934848228E6EB13D@domain.local>
References: <1731E52B1A4E4804B5D5A4820E26368F@domain.local>
	<s5h4o20tl3g.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.rt-rk.com (mail.rt-rk.ftn.uns.ac.rs [147.91.177.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 4DF3A1037E3
	for <alsa-devel@alsa-project.org>;
	Tue,  2 Aug 2011 12:33:41 +0200 (CEST)
In-Reply-To: <s5h4o20tl3g.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 'Takashi Iwai' <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Takashi,

Thanks for your help. My timer device has not been created at the correct
path (/dev/snd), so I thought it was missing and that I need to implement
it.  

-----Original Message-----
From: Takashi Iwai [mailto:tiwai@suse.de] 
Sent: 02 August 2011 07:54
To: Nenad Sljivic
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] Timer interface

At Fri, 29 Jul 2011 17:05:23 +0200,
Nenad Sljivic wrote:
> 
> Hi,
> 
> I am extending my ALSA driver in order to support software mixing. Driver
> currently supports both MMAP and RW access modes. However, I am still not
> able to use dmix since it requires timer interface to be implemented.
> My hardware does not generate interrupts at the period boundary but issues
> timer interrupts at a fixed timer rate. 

The timer interface is always present with ALSA (kernel) PCM
interface, thus normally you don't have to implement it.
Or are you trying to implement without the normal kernel driver but
with alsa-lib ioplug or such?


Takashi
