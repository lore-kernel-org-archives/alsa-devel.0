From: Paul Davis <pbd@op.net>
Subject: Re: opening alsa pcm device for input/output on specific channels
Date: Thu, 06 Jun 2002 10:44:53 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200206061439.g56EdgH03077@post2.fast.net>
References: <001e01c20d6e$6beb46a0$0400a8c0@martijn>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from post2.fast.net (post2.fast.net [209.92.1.22])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id QAA14381
	for <alsa-devel@alsa-project.org>; Thu, 6 Jun 2002 16:39:47 +0200
In-Reply-To: Your message of "Thu, 06 Jun 2002 16:24:54 BST."
             <001e01c20d6e$6beb46a0$0400a8c0@martijn>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Martijn Sipkema <msipkema@sipkema-digital.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>> you do it using ~/.asoundrc to define a PCM device that has the
>> channel characteristics you want.
>>
>> next, you'll be asking how. that's the part i can't help you with. the
>> archives have some examples, and there are several people on the list who
>> can tell you.
>
>aha, so the idea is that an application can only open a device with a number
>of channels and the user uses the configuration file to map channels? there
>is no way for an aaplication to open a device for output on specific
>channels
>, perhaps using a channel mask as in EASI?

correct. i know you love EASI, but its definitely not the paradigm in
use by ALSA, at least not currently.

--p


_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
