From: Michael Gerdau <mgd@technosis.de>
Subject: Re: Ideas - Support for multiple MIDI devices on a
	single interface
Date: Sat, 3 Jun 2006 08:33:52 +0200
Message-ID: <200606030833.52839.mgd@technosis.de>
References: <1633.212.69.53.77.1149301088.squirrel@webmail.silverblade.co.uk>
Reply-To: mgd@technosis.de
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1633.212.69.53.77.1149301088.squirrel@webmail.silverblade.co.uk>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

[snipped]
> And if it's a completely pointless idea, let me know also ;)

Ok, you asked for it... ;)

I'm sorry to say that but I personally think it's a completely
pointless idea.

- the raw count of external MIDI equipment used in professional
  music productions has passed its high watermark years ago. Most
  external gear is replaced by softsynths these days [this is to
  say the requirement for large racks of external gear which needs
  to be controlled via MIDI is diminishing]
- IMO if you are interested in tight MIDI timing you use a multiport
  MIDI interface and won't chain snyths on a single port. Cost is not
  an issue because multiport interfaces are cheap these days (or at
  least WAY cheaper than decent external synths or other gear).
- why would there be demand to switch channels dynamically in the
  first place anyway ?
  Ignoring the additional delays (and the resulting timing issues)
  introduced by the suggested switching procedure I don't see why
  you'd need to dynamically reallocate ports and channels.
  A single port gives you 16 channel, 2-/4-/8-port interfaces give
  you 32/64/128 channel for external MIDI.
  How much equipment are you going to connect ?
  And how complex will your music be that this isn't sufficient ?
  Last not least why don't you daisychain two or more of the better
  8-port interfaces ? -- w/r to tight timing a better idea anyway !

Last not least I never used the Windows MIDI mapper and to the day
I think it is useful only for very special cases.

Best,
Michael
-- 
 Vote against SPAM - see http://www.politik-digital.de/spam/
 Michael Gerdau       email: mgd@technosis.de
 GPG-keys available on request or at public keyserver
