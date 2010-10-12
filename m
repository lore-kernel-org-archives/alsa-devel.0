From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Setting Input Source
Date: Tue, 12 Oct 2010 22:56:23 +0800
Message-ID: <AANLkTi=UzgUZ1dtJGbYZYnowWKXEDdPJ5=1nWrhvRKcs@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id B4BDF243B0
	for <alsa-devel@alsa-project.org>;
	Tue, 12 Oct 2010 16:56:23 +0200 (CEST)
Received: by ewy9 with SMTP id 9so735877ewy.38
	for <alsa-devel@alsa-project.org>; Tue, 12 Oct 2010 07:56:23 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

>> Hi,

>> I wanted to set my input
>> sources and control volume through the mixer api from a 'C' code. I am
>> required to do this without using alsa utils. Please guide me as to how I
>> can set my input source to say 'Mic' and also adjust say Front Right
>> channel volume.

>> It would also be nice if there was a mini
>> tutorial on the alsa page which explains how to do this basic stuff.

>> Thanks
>>  and Regards,
>> Chandrashekhar

Are your program a mixer application or recording application ?

If the sound card does not support multi-streaming ,

the mic is one of the choice in the "Capture Source" controls

If your application can find "Input Source" in your sound card , this
mean that your sound card support multi-streaming capture
i.e. there will be more than one "Input Source" controls
