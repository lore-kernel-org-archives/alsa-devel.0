From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: How to get CardId for pseudo soundcards like dmix
 and dsnoop
Date: Fri, 10 Jun 2005 17:01:36 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0506101655400.26170-100000@studcom.urz.uni-halle.de>
References: <42A99D5C.5080002@vidsoft.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mailgate.uni-halle.de (mailgate.urz.uni-halle.de [141.48.3.51])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id BCEBC217
	for <alsa-devel@alsa-project.org>; Fri, 10 Jun 2005 17:01:37 +0200 (MEST)
In-Reply-To: <42A99D5C.5080002@vidsoft.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Gregor Jasny <jasny@vidsoft.de>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Gregor Jasny wrote:
> In my application the user can specify the pcm devices as a string (i.e.
> hw:0,0, plughw:1, dmix, default).
>
> Now I want to open the corresponding mixer device.

What do you mean with "corresponding" when there is no, or more than
one, mixer device?

> At the moment I fetch the cardid via snd_pcm_info_get_card. Then I
> build a string hw:<cardid> and attach to that string. This works
> fine for hw and plughw devices.  Doing this for dmix or dsnoop
> devices fails because the cardid is -1.

Or for virtual software-only devices, or devices composed of several
hardware devices.

> Another way I tried is to attach to the user supplied pcm string
> directly.

This is what Jack does, but it may fail if there isn't a control
device with the same name.

> How do I get the right mixer for a opened pcm device?

Hope that the user has a ctl.right definition in his .asoundrc.  ;-)


Using the card id is a good heuristic, but your program shouldn't
complain if that fails.  It may be better to optionally allow the user
to specify a control device name, too.


HTH
Clemens



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
