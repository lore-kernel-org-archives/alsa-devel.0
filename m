From: "Mark Knecht" <mknecht@controlnet.com>
Subject: RE: Hammerfall DSP System Problems
Date: Wed, 11 Jun 2003 07:15:34 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <NDBBLGIKBJENLAMOLFHGAEEHCHAB.mknecht@controlnet.com>
References: <20030611064511.GA551@always.joy.eth.net>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030611064511.GA551@always.joy.eth.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Joshua N Pritikin <vishnu@pobox.com>
Cc: Paul Davis <paul@linuxaudiosystems.com>, frankgaetano@collegeclub.com, Alsa-Devel <Alsa-Devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

> > so I think
> > I'm almost set to be able to try this stuff out again.
>
> For what it's worth, i had problems with alsa 0.9.4 & SMP.  i think
> there are some spinlock changes that aren't very well debugged yet.
> On the other hand, alsa 0.9rc7 seems fairly stable.  i've gotten
> some lockups, but i've also used jack for 4-5 hours without any
> problem.

Well, I found last night that if I removed Alsa and then rebuilt it, that as
long as I didn't power down 0.9.4-rc1 stayed up and I could see my card even
after a warm boot, but again, after a cold boot Alsa no longer recognized
the card.

So, my new strategy is that every morning, as I brew my tea, I now do:

emerge -C alsa-driver alsa-utils alsa-tools
ACCEPT_KEYWORDS="~x86" emerge alsa-driver alsa-utils alsa-tools

and then warm boot to get the driver to find the card. I still don't get
sound, but at least my CPU knows the card is there.

I guess life is good when you finally know how to cope with it! ;-)

Mark




-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
