From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [RFC] disabling ALSA period interrupts
Date: Tue, 4 May 2010 11:18:51 +0800
Message-ID: <j2o4f3252891005032018ocf0d4770uc34e846903cd1aad@mail.gmail.com>
References: <h2l6160a5131004291538w6c7891fbn2db3425846aefd60@mail.gmail.com>
	<1272645879.3220.177.camel@odin>
	<s2l6160a5131004301039r5da20135vc024bb1e0b1fb7cc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179]) by alsa0.perex.cz (Postfix) with ESMTP id 2A3BC24472
	for <alsa-devel@alsa-project.org>;
	Tue,  4 May 2010 05:18:52 +0200 (CEST)
Received: by pvg7 with SMTP id 7so502444pvg.38
	for <alsa-devel@alsa-project.org>; Mon, 03 May 2010 20:18:51 -0700 (PDT)
In-Reply-To: <s2l6160a5131004301039r5da20135vc024bb1e0b1fb7cc@mail.gmail.com>
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

2010/5/1 pl bossart <bossart.nospam@gmail.com>

> Hi Liam,
>
> > How do you handle any clock drift here between the HDA hardware
> > interface clock and the PA timer ?
>
> Good question. This is already handled by PulseAudio. The timer isn't
> programmed with a fixed value but is adapted precisely to track
> differences between system time and audio time.


seem underrun occur during this adjustment but PA just print "cutting
sleeping time" and did not provide any information about the sleeping time
for debugging

PulseAudio relies on
> snd_pcm_avail() to query the number of samples played, and correlates
> timer values with samples.


This mean that cs46xx and those drivers which cannot provide accurate number
of sample played will not work with PA ?


-Pierre
>
