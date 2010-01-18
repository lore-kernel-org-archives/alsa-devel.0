From: "S. Aguinaga" <sa_jr@yahoo.com>
Subject: Re: Echo Indigo card on Sabayon Gentoo
Date: Mon, 18 Jan 2010 10:09:13 -0800 (PST)
Message-ID: <380669.70878.qm@web65607.mail.ac4.yahoo.com>
References: <898710.10745.qm@web65614.mail.ac4.yahoo.com>
	<20100116015733.0fef5bf0@Jay>
Reply-To: "S. Aguinaga" <sa_jr@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from n6d.bullet.mail.ac4.yahoo.com (n6d.bullet.mail.ac4.yahoo.com
	[76.13.13.90]) by alsa0.perex.cz (Postfix) with SMTP id 75CB410382C
	for <alsa-devel@alsa-project.org>; Mon, 18 Jan 2010 19:09:15 +0100 (CET)
In-Reply-To: <20100116015733.0fef5bf0@Jay>
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



> Hello Fellows, 
> Just downloaded the latest (released)  alsa-lib, alsa-driver, and alsa-utils, but my Indigo card does not work. It has been tested on the same system using the same drivers and on the same system using Fedora 10, that works fine.

Kernel or alsa version ?
[**]  Alsa!  I used the LiveCD of Fedora10, then downloaded the Alsa Lib and Firmware, and the IO-card works!! 

> Do you know what I might have to do to get it working on Gentoo (sabayon)?

Same version ?
[**] Sabayon_Linux_5.0_x86_K 
[**] Linux xthink 2.6.31-sabayon #1 SMP Fri Sep 25 19:21:17 UTC 2009 i686 Intel(R) Pentium(R) M processor 1.60GHz GenuineIntel GNU/Linux


> Using aplay to list the device:
> card 2: IO [Indigo IO], device 0: PCM [Indigo IO]
>   Subdevices: 8/8
> .... etc.
> 
> Using aplay to test the card here is the command:
> aplay -D plughw:2,0  <wav file>
> 
> And this does not work, I have checked that things are ok with alsamixer, but still!

Do you mean aplay works but there is no sound ?
[**] Right it appears to be working (no errors returned) but no sound!
Do you see anything in the vu-meter or in the mixer meters ?
[**] This I don't understand, how would do/check that? I verified that alsamixer and see that the vu-meters are turned all the way up!




-- 
Giuliano.


[**] Salvador
