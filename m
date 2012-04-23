From: Felix Homann <linuxaudio@showlabor.de>
Subject: Re: [PATCH 1/5] Unify M-Audio Fast Track Ultra and
	Ebox-44 mixer quirks.
Date: Mon, 23 Apr 2012 20:46:45 +0200
Message-ID: <CAFz=ag6OJBotLqvUw3aAR4SJ8=NUHVE=AetuEUYAsF6u2=pqgg@mail.gmail.com>
References: <1335205467-12650-1-git-send-email-linuxaudio@showlabor.de>
	<1335205467-12650-2-git-send-email-linuxaudio@showlabor.de>
	<alpine.LNX.2.01.1204231932580.20159@stax.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <alpine.LNX.2.01.1204231932580.20159@stax.localdomain>
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

Hi Mark,

2012/4/23 Mark Hills <mark@pogo.org.uk>:
> When implementing the Ebox44 quirk, I found I needed this. The min and max
> would be automatically completed for the S16 values, but not for the mute
> buttons, so I defaulted to the range required for the BOOLEAN.

thanks for answering and sorry for my cc'ing you in so many iterations
of my patch set.
We leave it as it is then until someone has a need for other defaults.

Regards,

Felix
