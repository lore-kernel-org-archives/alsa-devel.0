From: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Subject: Re: Fwd: arecord bug?
Date: Tue, 18 Mar 2003 16:43:50 +0200 (EET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0303181633140.9177-100000@vaino.wakkanet.fi>
References: <Pine.LNX.4.44.0303181622330.9177-100000@vaino.wakkanet.fi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0303181622330.9177-100000@vaino.wakkanet.fi>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jon Ellis <ashura666@mac.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 18 Mar 2003, Kai Vehmanen wrote:

> ecasound -f:16,2,44100 -i alsa -o stdout |oggenc -r -q 0 -o recording.ogg -

Btw; ecasound can also launch oggenc by itself. To modify oggenc params,
you have to edit ~/.ecasound/ecasoundrc (see man ecasoundrc(5) for info).
So the above command would be:

ecasound -f:16,2,44100 -i alsa -o recording.ogg

As another example, to get vu-meter while recording, you can issue:

ecasignalview -f:16,2,44100 alsa recording.ogg

Ecasignalview, too, comes with the standard ecasound package and thus
should be in Gentoo. If you prefer a GUI, try recording with:

ecamegapedal alsa recording.ogg

Independently of how you do the recording, you always get the benefits of
ecasound's realibility features. The key feature is separation of audio
and disk processing to separate execution contexts. If this is not done
(like is the case with arecord), any burst of disk activity can cause
xruns to the recording process.

--
 http://www.eca.cx
 Audio software for Linux!



-------------------------------------------------------
This SF.net email is sponsored by: Does your code think in ink? 
You could win a Tablet PC. Get a free Tablet PC hat just for playing. 
What are you waiting for?
http://ads.sourceforge.net/cgi-bin/redirect.pl?micr5043en
