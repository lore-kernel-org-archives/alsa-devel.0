From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: Testers Wanted: OPL3 hwdep loader interface
Date: Fri, 26 Oct 2007 20:55:19 +0200
Message-ID: <47223817.7060508@keyaccess.nl>
References: <s5hfxzyoxvf.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.groni1.gr.home.nl (smtpq1.groni1.gr.home.nl
	[213.51.130.200])
	by alsa0.perex.cz (Postfix) with ESMTP id A0BA224434
	for <alsa-devel@alsa-project.org>;
	Fri, 26 Oct 2007 20:58:15 +0200 (CEST)
In-Reply-To: <s5hfxzyoxvf.wl%tiwai@suse.de>
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

On 10/26/2007 02:37 PM, Takashi Iwai wrote:

> one of big pending patches on my local tree is the removal of
> seq-instr interface.  The only real user of instrument layer is OPL3
> patch loader, and I'd like to move this to hwdep interface.
> 
> The patch below is to move the OPL3 patch loading to hwdep device.
> Two more patches will follow in other mails for alsa-lib addition and
> sbiload change.
> 
> Can someone test whether these patches work?  Unfortunately, I have
> no hardware with OPL3 at this moment around here.

Working fine. Applied the patches against alsa-{kernel,lib,tools}-1.0.15.

rene@7ixe4:~$ aplaymidi -l
  Port    Client name                      Port name
  14:0    Midi Through                     Midi Through Port-0
  16:0    ESS ES1978 (Maestro 2E)          ESS ES1978 (Maestro 2E) MIDI
  20:0    CS4236B                          CS4236B MIDI
  21:0    OPL3 FM synth                    OPL3 FM Port
rene@7ixe4:~$ cat /proc/asound/hwdep
01-00: OPL3 FM
rene@7ixe4:~$ sbiload -D hw:1,0 -4 std.o3 drums.o3
rene@7ixe4:~$ aplaymidi -p 21:0 music/midi/jzz30xg.mid

<noise>

If you need/want me to, I can also test against an OPL2 (AdLib clone card) 
but I assume that'll be okay?

Rene.
