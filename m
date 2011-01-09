From: Halim Sahin <halim.sahin@freenet.de>
Subject: hda: again low volume problem :-(
Date: Sun, 9 Jan 2011 20:27:35 +0100
Message-ID: <20110109192735.GA22137@gentoo.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 8AEDB243C1
	for <alsa-devel@alsa-project.org>; Sun,  9 Jan 2011 20:33:31 +0100 (CET)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1Pc116-0007JQ-HH
	for alsa-devel@alsa-project.org; Sun, 09 Jan 2011 20:33:28 +0100
Received: from p4fc865af.dip.t-dialin.net ([79.200.101.175])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sun, 09 Jan 2011 20:33:28 +0100
Received: from halim.sahin by p4fc865af.dip.t-dialin.net with local (Gmexim
	0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Sun, 09 Jan 2011 20:33:28 +0100
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

hi Folks,

i see the low volume problem is not only related to my hardware but
reported a few times in alsa-user mailinglist.
Please! have a look in to that problem.
Using 100% of the volume sliders in alsamixer is not enough to get
usable sound for the amp.
here my last mail ng the same problemd

Hi,

On Mo, Aug 23, 2010 at 08:18:46 +0200, Takashi Iwai wrote:
> First off, try with the latest version of alsa-driver.
> Get the snapshot version from
>   ftp://ftp.kernel.org/pub/linux/kernel/people/tiwai/snapshot/alsa-driver-snapshot.tar.gz
 
Done. Compilation and load of the modules are ok but the volume stays
low on the rear panel of the computer.


> If this doesn't help, try to set EAPD on NID 0x14 and/or 0x15, set it
> to 0x02.  Get hda-verb program (available on OBS home:tiwai repo),
> then run like
> 
> 	hda-verb /dev/snd/hwC0D0 0x14 SET_EAPD 0x02
> 	hda-verb /dev/snd/hwC0D0 0x15 SET_EAPD 0x02

also no success with hda-verb.
Do you have more ideas what I can test?

Maybe this aditional info helps you :-).
I noticed a difference in volume between headphone (front connector) and
the line out (rear panel connector).
The volume is higher when using the headphone connector but should also
be improoved a bit :-(.
this info is from alsamixer and the new driver:
Card: HDA NVidia
    Chip: Nvidia ID 7
This info is from the orginal driver of kernel 2.6.34:
  Card: HDA NVidia
    Chip: Nvidia MCP79/7A HDMI

Why does alsamixer show     Chip: Nvidia ID 7 with new driver?

All help appreciated ;-)

BR.
halim
