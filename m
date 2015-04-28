From: Glenn Golden <gdg@zplane.com>
Subject: Re: [pulseaudio-discuss] ThinkPad T-510 audio output
 mute LED non-workingness
Date: Tue, 28 Apr 2015 11:53:17 -0600
Message-ID: <20150428175317.GO550@huh.zplane.com>
References: <CAN8cciZQBRz2Ty3YRt2+3KO9v1BWef-_8FU_d_SsE87mLdgY-w@mail.gmail.com>
 <s5hh9s2gj45.wl-tiwai@suse.de>
 <20150427135859.GI550@huh.zplane.com>
 <s5ha8xt4hsa.wl-tiwai@suse.de>
 <20150428000206.GK550@huh.zplane.com>
 <s5hmw1s3hxh.wl-tiwai@suse.de>
 <20150428101645.GM550@huh.zplane.com>
 <s5h618gwnno.wl-tiwai@suse.de>
 <20150428113948.GN550@huh.zplane.com>
 <s5hwq0wv5du.wl-tiwai@suse.de>
Reply-To: gdg@zplane.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.indra.com (smtp.indra.com [209.169.0.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 414CB2625D7
 for <alsa-devel@alsa-project.org>; Tue, 28 Apr 2015 19:53:29 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <s5hwq0wv5du.wl-tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org, Alex Hung <alex.hung@canonical.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Raymond Yau <superquad.vortex2@gmail.com>, bruno.mueller@gmail.com, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Takashi Iwai <tiwai@suse.de> [2015-04-28 13:50:21 +0200]:
> At Tue, 28 Apr 2015 05:39:48 -0600,
> Glenn Golden wrote:
> > 
> > Takashi Iwai <tiwai@suse.de> [2015-04-28 12:30:19 +0200]:
> > > 
> > > Then it's likely an issue in thinkpad_acpi.c.  It implies that the
> > > driver couldn't get SSMS acpi handle.
> > > 
> > 
> > Raymond had pointed this out earlier as a (the?) patch that brought the static
> > tp_led_table led_tables[] into existence:
> > 
> >     http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/drivers/platform/x86/thinkpad_acpi.c?id=420f9739a62cdb027f5580d25c813501ff93aa6f
> 
> This change was in 3.13 kernel, nothing new.
> 


OK.

What's next on the menu for my end? Any further experiments that can be 
useful to try?
