From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: pulseaudio eats 19% CPU power in Fedora 12
Date: Wed, 21 Apr 2010 08:57:28 +0100
Message-ID: <hqmb58$frb$1@dough.gmane.org>
References: <20100414075658.GA26283@localhost>	<20100419032856.GA13629@tango.0pointer.de>	<k2q604760771004182038n72eec9bdy77a9e4faf2152ee4@mail.gmail.com>
	<u2l4f3252891004201730g94e709abs8ebf34b00d9ed505@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lo.gmane.org (lo.gmane.org [80.91.229.12])
	by alsa0.perex.cz (Postfix) with ESMTP id 6AE92103825
	for <alsa-devel@alsa-project.org>;
	Wed, 21 Apr 2010 09:57:47 +0200 (CEST)
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1O4Uob-0001Hi-UQ
	for alsa-devel@alsa-project.org; Wed, 21 Apr 2010 09:57:45 +0200
Received: from brent.tribalogic.net ([78.86.109.144])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 21 Apr 2010 09:57:45 +0200
Received: from gmane by brent.tribalogic.net with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <alsa-devel@alsa-project.org>; Wed, 21 Apr 2010 09:57:45 +0200
In-Reply-To: <u2l4f3252891004201730g94e709abs8ebf34b00d9ed505@mail.gmail.com>
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

'Twas brillig, and Raymond Yau at 21/04/10 01:30 did gyre and gimble:
> 2010/4/19 Daniel Chen <seven.steps@gmail.com>
> 
>>  but, like
>> Lennart suggests, these are by no means *caused* by PulseAudio.
>>
>> Best,
>> -Dan
>>
>>
> There are other factor affecting CPU usage  significantly
> 
> 1) the number of pulseaudio clients connected to PA server (i.e. number of
> audio stream need to be mixed )
> 2) the accuracy of system timer and the clock of the sound chip
> 3) the latency requirement of the different PA clients
> 4) the resampling method
> 5) the cpu loading of the system
> 6) the period time/period size selected by PA server to configure the alsa
> driver
> 
> why do you ruled out the cause ?
> 
>>> If you use "pacat" you can play audio with almost zero CPU
> usage
> 
> do you get the zero CPU usage in  Ubuntu 9.04/Ubuntu 9.10 with pacat on your
> machines ?

The pacat support for proper latency adjustment is only available in
more recent PA versions (with some , so chances are the older distros
wont have them (although I believe a 9.10 version of 0.9.21+stable-queue
exists somewhere.


These commits from stable-queue are certainly needed:

commit 19fa81bf1375032cb1a27c7715a28a52b238d4cb
Author: Lennart Poettering <lennart@poettering.net>
Date:   Thu Feb 18 01:54:51 2010 +0100

    pacat: always fully fulfill write requests

    Make sure we always fulfill write requests from the server. If we don't
    the server won't ask us again and playback will stay stuck.


https://tango.0pointer.de/pipermail/pulseaudio-discuss/2010-February/006611.html


and this one (although it's not problematic for playback):

commit b2e9fb6f6e12a3eab8a41c67017507e60d616e2a
Author: Lennart Poettering <lennart@poettering.net>
Date:   Sun Feb 21 21:09:26 2010 +0100

    pacat: pass buffer_attr to recording streams too

    Pointed out by Colin Guthrie.


https://tango.0pointer.de/pipermail/pulseaudio-discuss/2010-February/006698.html






-- 

Colin Guthrie
gmane(at)colin.guthr.ie
http://colin.guthr.ie/

Day Job:
  Tribalogic Limited [http://www.tribalogic.net/]
Open Source:
  Mandriva Linux Contributor [http://www.mandriva.com/]
  PulseAudio Hacker [http://www.pulseaudio.org/]
  Trac Hacker [http://trac.edgewall.org/]
