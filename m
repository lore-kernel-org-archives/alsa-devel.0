From: Joshua N Pritikin <vishnu@pobox.com>
Subject: Re: Hammerfall DSP System Problems
Date: Wed, 11 Jun 2003 12:15:11 +0530
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030611064511.GA551@always.joy.eth.net>
References: <20030610183131.76A8A3EFBF@vivaldi.controlnet.com> <NDBBLGIKBJENLAMOLFHGCECJCHAB.mknecht@controlnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <NDBBLGIKBJENLAMOLFHGCECJCHAB.mknecht@controlnet.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mark Knecht <mknecht@controlnet.com>
Cc: Paul Davis <paul@linuxaudiosystems.com>, frankgaetano@collegeclub.com, Alsa-Devel <Alsa-Devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 10, 2003 at 01:02:57PM -0700, Mark Knecht wrote:
> I'm sure that it will get worked out. I think Joshua is currently having
> some good successes with the HDSP 9652,

Yes, it works.

> and I'm currently learning how to
> modify a Gentoo ebuild to accomplish doing a patch. I also have (after more
> pain than I wish to recount) Windows on this Gentoo box in a dual boot
> config, and have the RME firmware tools to upgrade and downgrade, so I think
> I'm almost set to be able to try this stuff out again.

For what it's worth, i had problems with alsa 0.9.4 & SMP.  i think
there are some spinlock changes that aren't very well debugged yet.
On the other hand, alsa 0.9rc7 seems fairly stable.  i've gotten
some lockups, but i've also used jack for 4-5 hours without any
problem.

-- 
Victory to the Divine Mother!!         after all,
  http://sahajayoga.org                  http://why-compete.org


-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
