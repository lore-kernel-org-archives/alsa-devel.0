From: Jussi Laako <jussi@sonarnerd.net>
Subject: Re: [PATCH 2/2] alsa-lib: bring pcm.h and pcm.c in
 sync with the kernel list
Date: Thu, 28 Mar 2013 09:36:29 +0200
Message-ID: <5153F2FD.50704@sonarnerd.net>
References: <1364427144-30036-1-git-send-email-zonque@gmail.com>
 <1364427144-30036-2-git-send-email-zonque@gmail.com>
 <51538493.40309@sonarnerd.net>
 <7.0.0.16.2.20130327213632.13b07718@akdesigninc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.sonarnerd.net (rankki.sonarnerd.net [83.145.240.118])
 by alsa0.perex.cz (Postfix) with ESMTP id 1FD52265239
 for <alsa-devel@alsa-project.org>; Thu, 28 Mar 2013 08:36:31 +0100 (CET)
In-Reply-To: <7.0.0.16.2.20130327213632.13b07718@akdesigninc.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andreas Koch <andreas@akdesigninc.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, clemens@ladisch.de, Daniel Mack <zonque@gmail.com>, demian@auraliti.com, ray@auraliti.com
List-Id: alsa-devel@alsa-project.org

Hi Andreas,> Now of course, with your heroic effort in creating a 
generic driver that
> would help everyone, we have a mess. Some DACs expect little endian
> (mine and others as well) and others (all that are based on Rigisystems
> modules) big endian positions.

OK, we actually have two separate endianess issues here, but only one 
with word lengths longer than 8-bit.

We have the traditional byte order endianess and the bit order 
endianess. Of course from computer point of view order of bits in a byte 
is sort of separate issue. And now the two file formats used for DSD use 
opposite bit ordering, but being byte-based don't have the byte ordering 
issue. At worst we have four different sample format possibilities for 
word lengths longer than a byte...

Either way, application will have to be able to reshuffle the bits for 
the other format.


	- Jussi
