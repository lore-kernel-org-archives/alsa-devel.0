From: "Brand, Mark (Mr) (Summerstrand Campus South)" <Mark.Brand@nmmu.ac.za>
Subject: Re: Turtle Beach Tahiti (snd-msnd-classic)
Date: Mon, 6 Sep 2010 12:38:45 +0200
Message-ID: <F5D2EA2BCBDF9247A489B479BEB484B60B02A46A96@sicily.nmmu.ac.za>
References: <F5D2EA2BCBDF9247A489B479BEB484B60B02A45910@sicily.nmmu.ac.za>
	<20100904111603.a158dd2c.krzysztof.h1@wp.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ra.nmmu.ac.za (ra.nmmu.ac.za [192.96.15.50])
	by alsa0.perex.cz (Postfix) with ESMTP id 726DC24506
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Sep 2010 12:38:22 +0200 (CEST)
In-Reply-To: <20100904111603.a158dd2c.krzysztof.h1@wp.pl>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 'Krzysztof Helt' <krzysztof.h1@wp.pl>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "anabellesgarden@yahoo.de" <anabellesgarden@yahoo.de>
List-Id: alsa-devel@alsa-project.org

Dear Krzysztof,

No problem, Takashi sent me in the right direction (see his patch and my reply).  I did not find the time to spend on this over the weekend as I'd hoped, but I can report that:
* I now have audio playback
* There is a regular click, at about 200ms intervals (while playing, of course, not otherwise)
* Audio does vanish occasionally - I reload alsa and it returns
* I suspect the isapnp and cfg parameters shouldn't be necessary, but as it stands the driver defaults to PnP mode without them

Just as soon as I can squeeze off a bit more time to spend on this, I'll try to provide better feedback.

Kind regards, and thank you for responding.
Mark Brand.

-----Original Message-----
From: Krzysztof Helt [mailto:krzysztof.h1@wp.pl]
Sent: 04 September 2010 11:16 AM
To: Brand, Mark (Mr) (Summerstrand Campus South)
Cc: alsa-devel@alsa-project.org; tiwai@suse.de; anabellesgarden@yahoo.de
Subject: Re: Turtle Beach Tahiti (snd-msnd-classic)

Dear Mark,

I was on a business trip for one month so please forgive the delay in answering your request.

I will dig into the issue this weekend.

Thank you for testing,
Krzysztof

NOTICE: Please note that this eMail, and the contents thereof, is subject to the standard NMMU eMail disclaimer which may be found at:
http://www.nmmu.ac.za/disclaimer/email.htm
