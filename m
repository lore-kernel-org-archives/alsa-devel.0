From: Jean-Pierre ANDRE <jean-pierre.andre@wanadoo.fr>
Subject: Intel 82801I (ICH9 Family) HD Audio Controller on a HP
	dv4 computer
Date: Sat, 13 Dec 2008 12:41:23 +0100 (CET)
Message-ID: <7342920.39901.1229168483619.JavaMail.www@wwinf1b34>
Reply-To: Jean-Pierre ANDRE <jean-pierre.andre@wanadoo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp1b.orange.fr (smtp1b.orange.fr [193.252.23.64])
	by alsa0.perex.cz (Postfix) with ESMTP id 689DE1037E3
	for <alsa-devel@alsa-project.org>; Sat, 13 Dec 2008 12:41:24 +0100 (CET)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf1b03.orange.fr (SMTP Server) with ESMTP id A9630700029F
	for <alsa-devel@alsa-project.org>; Sat, 13 Dec 2008 12:41:23 +0100 (CET)
Received: from wwinf1b34 (wwinf1b34 [10.232.19.108])
	by mwinf1b03.orange.fr (SMTP Server) with ESMTP id 9F86B700029A
	for <alsa-devel@alsa-project.org>; Sat, 13 Dec 2008 12:41:23 +0100 (CET)
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

Hi,

I am getting difficulty setting up ALSA for my new HP portable computer.
lspci displays the audio chip as :
Audio device: Intel Corporation 82801I (ICH9 Family) HD Audio Controller (rev 03)
and /proc/asound displays the codec as IDT 92HD71B7X

I have uploaded the detailed hardware and configuration parameters to
http://pagesperso-orange.fr/b.andre/visits.html/92HD71B7X

I am using Fedora 10 x86_64 without pulseaudio and with the latest alsa-driver :
alsa-driver-1.0.18a.16.g4012f.139.g6e583.tar.bz2

I have googled for a similar problem, but did not get to an actual fix,
the following thread appears to deal with a most similar situation :
http://forums.opensuse.org/pre-release-beta/399731-beta-5-no-sound.html

After several tries, I have set modprobe.conf as
alias snd-card-0 snd-hda-intel
options sound slots=snd-hda-intel
options snd-hda-intel model=hp-m4 single_cmd=1 enable_msi=1

Results :

aplay freezes, with some sound output which is the continual repeat  
of the initial expected sound (some fraction of a second repeated).
However if I boot with pci=noacpi the output is correct (I do not
understand the relation of power management to sound, there must be
one as I see :
HDA Intel 0000:00:1b.0: power state changed by ACPI to D0
when I unload/reload alsa)

WITHOUT the pci=noacpi option :

- mplayer outputs the sound correctly (does mplayer bypass alsa ?)
- xine outputs a chopped sound (some 100ms OK, some 100ms silent,
  some 100ms OK, etc, with a period which could be 200..500ms)
- most players (eg Real player) just freeze.

I would say that when some sound buffer gets empty, the driver does
not get the information, so it does not fill the buffer again.   

I have done some digging into the code. I see that this 92HD71B7X chip
is supported for HP dv5 and dv7 computers (subsystem ID 103c30f2 and
103C30f4), but mine is a HP dv4 showing a subsystem ID 103c30f7,
so it must be somewhat different and not supported yet.

Can anybody suggest some fix ?

If needed I can apply patches to the code and do some testing so 
that my configuration gets supported in subsequent versions.  

Regards

Jean-Pierre
