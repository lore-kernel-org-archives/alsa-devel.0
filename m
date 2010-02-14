From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Since kernel-2.6.32,
 alsactl fails to restore defaults
Date: Sun, 14 Feb 2010 20:10:20 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1002142008190.28127@eeebox2.perex-int.cz>
References: <alpine.LNX.2.00.1002141912260.28127@eeebox2.perex-int.cz>
	<1266174001.23964.9.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1507077685-1266174620=:28127"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id 969262443F
	for <alsa-devel@alsa-project.org>; Sun, 14 Feb 2010 20:10:20 +0100 (CET)
In-Reply-To: <1266174001.23964.9.camel@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Pacho Ramos <pacho@condmat1.ciencias.uniovi.es>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1507077685-1266174620=:28127
Content-Type: TEXT/PLAIN; charset=UTF-8; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Sun, 14 Feb 2010, Pacho Ramos wrote:

> El dom, 14-02-2010 a las 19:20 +0100, Jaroslav Kysela escribi=C3=B3:
>>
>> I agree, this value is bogus. I just fixed the code to return exit code
>> 99 as described in init/00main:
>>
>> http://git.alsa-project.org/?p=3Dalsa-utils.git;a=3Dcommitdiff;h=3D69c6b=
ead434e7a4a546ab1300413312994b93e35
>>
>>> What could I do? Thanks for helping me, if you need more information,
>>> simply ask me for it :-)
>>
>> There are two ways to fix this issue for your distro:
>>
>> 1) modify the script which calls alsactl and add a check for code 99
>>     (it may ignore this exit code) - assuming that patch above is applie=
d
>> 2) change init/00main - EXIT=3D"99" line to EXIT=3D"0"
>>
>> But from your gentoo bug, I guess that your system don't save the last
>> soundcard state to /var/lib/alsa/asound.state correctly - it's looks lik=
e
>> a bug in the init scripts for your distro.
>>
>> Or it might be totaly different issue - could you send me your
>> /var/lib/alsa/asound.state file and file test.state generated using
>> 'alsactl -f test.state store' command?
>>
>>  =09=09=09=09=09=09Jaroslav
>>
>
> Yes, of course :-)

The files look good. The question is why the initialization is called=20
when a default state already exists (it shouldn't).

Does 'alsactl -f test.state restore' show some messages? Use test.state=20
file you sent me.

 =09=09=09=09=09Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.

--8323584-1507077685-1266174620=:28127
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--8323584-1507077685-1266174620=:28127--
