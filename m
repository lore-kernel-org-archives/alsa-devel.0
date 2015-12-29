From: Rob van der Putten <rob@sput.nl>
Subject: Re: Rawmidi
Date: Tue, 29 Dec 2015 12:16:49 +0100
Message-ID: <n5tq31$od5$1@ger.gmane.org>
References: <CAL_NL1DGv74+62K9A_82osf6ywc9pPVPZhrZd+BsGs7tCnAxqQ@mail.gmail.com>
 <9511ACE5-064B-40C7-8286-9401991156CD@ladisch.de>
 <CAL_NL1Bgv8hoW-wR003jD4Wopc6udG=Xb+DJ8P+W5H5H9dQYnQ@mail.gmail.com>
 <56800895.5070008@sakamocchi.jp> <n5rho8$bn$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from plane.gmane.org (plane.gmane.org [80.91.229.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 7A56626568C
 for <alsa-devel@alsa-project.org>; Tue, 29 Dec 2015 12:17:01 +0100 (CET)
Received: from list by plane.gmane.org with local (Exim 4.69)
 (envelope-from <glad-alsa-devel-2@m.gmane.org>) id 1aDsGy-0001OA-9E
 for alsa-devel@alsa-project.org; Tue, 29 Dec 2015 12:17:00 +0100
Received: from ns4.sput.nl ([80.101.95.251])
 by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Tue, 29 Dec 2015 12:17:00 +0100
Received: from rob by ns4.sput.nl with local (Gmexim 0.1 (Debian))
 id 1AlnuQ-0007hv-00
 for <alsa-devel@alsa-project.org>; Tue, 29 Dec 2015 12:17:00 +0100
In-Reply-To: <n5rho8$bn$1@ger.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi there


Rob van der Putten wrote:

> On my box the snd_rawmidi_ stuff is in /usr/include/alsa/rawmidi.h
> /usr/include/alsa/asoundlib.h includes alsa/rawmidi.h, so a #include
> <alsa/asoundlib.h> in the c file should do.
>
> I compile with cc -Wall -lasound -o foo foo.c

Actually cc -Wall -O2 -lasound -o foo foo.c

> Hope this helps.


Regards,
Rob
