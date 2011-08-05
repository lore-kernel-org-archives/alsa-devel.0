From: Shane Volpe <shanevolpe@gmail.com>
Subject: Re: Suspend/Resume failure of Alsa but OSS emulation
	still works
Date: Fri, 5 Aug 2011 07:38:34 -0400
Message-ID: <CAMgc3zMJ8QX8ZsgF7fozHT8B_3NWA9NSyDcF8tLNcaDfJ7p1UA@mail.gmail.com>
References: <CAMgc3zMzTrkG-ENxayHG6v+q_3WttVv47L6oiLOrCO8EV3h8sA@mail.gmail.com>
	<CAMgc3zObxQJ1A-kJyVh=sm8C-iZqoGaQ-1q+6SbUJ6MAGh4Adw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 9FC3110380E
	for <alsa-devel@alsa-project.org>;
	Fri,  5 Aug 2011 13:38:54 +0200 (CEST)
Received: by ewy6 with SMTP id 6so782671ewy.38
	for <alsa-devel@alsa-project.org>; Fri, 05 Aug 2011 04:38:54 -0700 (PDT)
In-Reply-To: <CAMgc3zObxQJ1A-kJyVh=sm8C-iZqoGaQ-1q+6SbUJ6MAGh4Adw@mail.gmail.com>
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

>> =A0If I kill the audio player and start it back up the sound returns so
>> it seems the act of opening and closing Alsa fixes the failure. During
>> the "no sound state" I also opened alsamixer and adjusted
>> (successfully) several alsa settings including volume but the sound
>> still did not resume until I restarted the player.

If I do an strace on aplayer and look at its output after the resume
it looks like aplayer is hanging up on trying to read /dev/snd/timer
and is getting -1 EAGAIN (Resource temporarily unavailable) from it.
I would greatly appreciate any comments or suggestions of what I can
do next to further narrow down the problem
Regards,
Shane
