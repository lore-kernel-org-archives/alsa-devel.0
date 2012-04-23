From: Felix Homann <linuxaudio@showlabor.de>
Subject: Re: [PATCH 0/5] Alsa: snd-usb: Improve M-Audio Fast
 Track Ultra mixer - v3
Date: Mon, 23 Apr 2012 21:00:17 +0200
Message-ID: <CAFz=ag4faFB53g0EjH7iYVYGkP-w9D_82re5hRvGVM+QrsFZfQ@mail.gmail.com>
References: <1335205467-12650-1-git-send-email-linuxaudio@showlabor.de>
	<alpine.LNX.2.01.1204231943200.20159@stax.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <alpine.LNX.2.01.1204231943200.20159@stax.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Hills <mark@pogo.org.uk>
Cc: alsa-devel@alsa-project.org, patch@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2012/4/23 Mark Hills <mark@pogo.org.uk>:
> I can, but I'll need some assistance or documentation to explain how. I
> took a quick look, and it wasn't very clear.
>
> I presume this adds dB values to the mixer? Unless I have taken some
> measurements is it not better to leave them unassigned than add bogus
> values?

Yes, measurements would be great but I haven't done any measurements
on the FTUs either.

The TLV callbacks  I've added to the volume controls enhances the
usability of the controls anyway. Without the TLV callbacks I would
have to go to at least 90% in amixer etc. to hear anythin at all. With
TLV callbacks I can hear a difference all over the control range.

(Chances are, that the returned dB gain values are correct since the
devices opeerate nearly standard conform.)

Just try with your S16 controls like I did for the FTUs and see if it
makes a difference for you.

Regards,

Felix
