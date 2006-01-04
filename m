From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001659]: dmix not working with ice1712
Date: Wed, 4 Jan 2006 17:06:02 +0100
Message-ID: <0f682d684d8d0ace40c1cbd55a40863d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2DA0E184
	for <alsa-devel@alsa-project.org>; Wed,  4 Jan 2006 17:06:03 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1659> 
======================================================================
Reported By:                jdthood
Assigned To:                tiwai
======================================================================
Project:                    ALSA - lib
Issue ID:                   1659
Category:                   0_general
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     resolved
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             12-18-2005 21:07 CET
Last Modified:              01-04-2006 17:06 CET
======================================================================
Summary:                    dmix not working with ice1712
Description: 
In Debian bug 342026 the submitter reports:

> After an upgrade today [to 1.0.10rc1?], the dmix plugin stopped
working.
> 
>     $ mocp 	# or any other program trying to use alsa
>     ALSA lib pcm_direct.c:812:(snd_pcm_direct_initialize_slave)
requested or auto-format is not available
>     ALSA lib pcm_dmix.c:831:(snd_pcm_dmix_open) unable to initialize
slave
> 
> My ~/.asoundrc is the example configuration for using dmix with the
> ICE1712 chip (found e.g. at
http://alsa.opensrc.org/index.php?page=DmixPlugin).
> 
> # cat ~/.asoundrc
> # our ICE1712 dmix:
> pcm.ossmix {
>     type dmix
>     ipc_key 1024
>     slave {
>     pcm "hw:0,0"
>         period_time 0
>         period_size 1024
>         buffer_size 4096 # buffer size < 6653, but pow(x, 2)
>         rate 44100 # we want to play CDs only
>     }
>     bindings {
>         0 0
>         1 1
>     }
> }
> # Everything shall be dmixed, so redefine "default":
> pcm.!default {
>     type plug
>     slave.pcm "ossmix"
> }
> # OSS via aoss should d(mix)stroyed:
> pcm.dsp0 {
>     type plug
>     slave.pcm "ossmix"
> }
> ctl.mixer0 {
>     type hw
>     card 0
> }


He says that this config worked in ALSA 1.0.9.

He later adds:

> Adding 'format S32_LE' in the original .asoundrc seems to have fixed
> the problem. Apparently the default format (for ice1712 or generally?)
> has been changed to something that doesn't work.

As always, see http://bugs.debian.org/342026 for the complete log.
======================================================================

----------------------------------------------------------------------
 jdthood - 01-04-06 11:16 
----------------------------------------------------------------------
-------- Original Message --------
Subject: [Pkg-alsa-devel] Bug#342026: alsa-utils: Dmix stopped working.
Resent-Date: Wed, 04 Jan 2006 09:48:13 UTC,	Wed, 04 Jan 2006 01:48:14
-0800
Date: Wed, 04 Jan 2006 10:37:54 +0100
From: Laurent Bonnaud
[...]

Hi,

I have a similar problem with my "Terratec Aureon Sky" soundcard (with
the snd_ice1724 driver).  Here is how it is listed by lspci:

0000:00:0c.0 Multimedia audio controller: VIA Technologies Inc.
VT1720/24 [Envy24PT/HT] PCI Multi-Channel Audio Controller (rev 01)

I have no .asoundrc or /etc/asound.conf file and dmix does not work: a
second program that tries to output sound blocks.

I tried this patch:

https://bugtrack.alsa-project.org/alsa-bug/file_download.php?file_id=969&type=bug

that I applied to the /usr/share/alsa/cards/ICE1724.conf file.  dmix
still does not work.

Let me add that dmix used to work with older versions of alsa and the
sample dmix configuration given
in /usr/share/doc/libasound2/examples/asound.conf_dmix.  This is
therefore a regression.


Package: libasound2
Version: 1.0.10+1.0.11rc1-1

-- System Information:
Debian Release: testing/unstable
  APT prefers unstable
  APT policy: (100, 'unstable')
Architecture: amd64 (x86_64)
Shell:  /bin/sh linked to /bin/bash
Kernel: Linux 2.6.14-2-amd64-k8
Locale: LANG=fr_FR@euro, LC_CTYPE=fr_FR@euro (charmap=ISO-8859-15)

Versions of packages libasound2 depends on:
ii  libc6                         2.3.5-11   GNU C Library: Shared
libraries an

libasound2 recommends no packages.

-- no debconf information

----------------------------------------------------------------------
 tiwai - 01-04-06 17:06 
----------------------------------------------------------------------
Applied to CVS.  Thanks.

The configuration for ice1724 was already changed to use dmix/dsnoop.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-18-05 21:07 jdthood        New Issue                                    
12-18-05 22:30 rlrevell       File Added: ICE1712-dmix.patch                    
12-18-05 22:31 rlrevell       Note Added: 0007072                          
01-02-06 23:07 jdthood        Note Added: 0007394                          
01-04-06 11:16 jdthood        Note Added: 0007413                          
01-04-06 17:06 tiwai          Status                   new => resolved     
01-04-06 17:06 tiwai          Resolution               open => fixed       
01-04-06 17:06 tiwai          Assigned To               => tiwai           
01-04-06 17:06 tiwai          Note Added: 0007434                          
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
