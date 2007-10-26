From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: Testers Wanted: OPL3 hwdep loader interface
Date: Sat, 27 Oct 2007 01:09:32 +0200
Message-ID: <472273AC.9020702@keyaccess.nl>
References: <s5hfxzyoxvf.wl%tiwai@suse.de> <47223817.7060508@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq2.tilbu1.nb.home.nl (smtpq2.tilbu1.nb.home.nl
	[213.51.146.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 9D213244E0
	for <alsa-devel@alsa-project.org>;
	Sat, 27 Oct 2007 01:12:31 +0200 (CEST)
In-Reply-To: <47223817.7060508@keyaccess.nl>
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

On 10/26/2007 08:55 PM, Rene Herman wrote:

> Working fine. Applied the patches against alsa-{kernel,lib,tools}-1.0.15.
> 
> rene@7ixe4:~$ aplaymidi -l
>  Port    Client name                      Port name
>  14:0    Midi Through                     Midi Through Port-0
>  16:0    ESS ES1978 (Maestro 2E)          ESS ES1978 (Maestro 2E) MIDI
>  20:0    CS4236B                          CS4236B MIDI
>  21:0    OPL3 FM synth                    OPL3 FM Port
> rene@7ixe4:~$ cat /proc/asound/hwdep
> 01-00: OPL3 FM
> rene@7ixe4:~$ sbiload -D hw:1,0 -4 std.o3 drums.o3
> rene@7ixe4:~$ aplaymidi -p 21:0 music/midi/jzz30xg.mid
> 
> <noise>
> 
> If you need/want me to, I can also test against an OPL2 (AdLib clone 
> card) but I assume that'll be okay?

rene@6bap:~$ aplaymidi -l
  Port    Client name                      Port name
  14:0    Midi Through                     Midi Through Port-0
  16:0    OPL2 FM synth                    OPL2 FM Port
rene@6bap:~$ cat /proc/asound/hwdep
00-00: OPL2 FM
rene@6bap:~$ sbiload -D hw:0,0 std.sb drums.sb
rene@6bap:~$ aplaymidi -p 16:0 midi/jzz30xg.mid

<same noise>

So, OPL2 same deal. However -- there is a problem after all. With this as 
the source file:

http://members.home.nl/rene.herman/opl3/jzz30xg.mid

using the old sbiload with the sb and o3 patches respectively, produces:

http://members.home.nl/rene.herman/opl3/jzz30xg-cs4236b_opl3-seq-sb.ogg
http://members.home.nl/rene.herman/opl3/jzz30xg-cs4236b_opl3-seq-o3.ogg

while with the new hwdep sbiload, I hear:

http://members.home.nl/rene.herman/opl3/jzz30xg-cs4236b_opl3-hwdep-sb.ogg
http://members.home.nl/rene.herman/opl3/jzz30xg-cs4236b_opl3-hwdep-o3.ogg

While much less annoying... something's still missing. The former are how 
they are supposed to be rendered. A problem with the "drums"?

Rene.
