From: Joern Nettingsmeier <nettings@folkwang-hochschule.de>
Subject: different nperiods for capture and playback when opening a device in
 duplex mode ?
Date: Wed, 10 Jul 2002 18:15:20 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D2C5D98.18C4EC22@folkwang-hochschule.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

hello alsa people !

i have a problem with jack on a sblive giving dropouts.
i found this might be due to too few periods per buffergla.
unfortunately, the sblive only seems to support two periods for
capturing, and jack sets both play and capture to the same number of
periods.

is it possible with alsa to use different settings for capture and
playback, either periods or buffer size or both ?
if yes, i might try and add that to jack, but since this is my first
undertaking with alsa programming, i thought i'd ask first :)

i got this idea from glame, which uses 2 and 4 periods and also
different sizes and runs dropout-free. it does not however open the card
full-duplex, but uses two threads that operate in halfduplex mode
instead.

i'd also appreciate pointers to programs that do this already, so that i
might refer to the sources for "inspiration" :)

best,

j=F6rn


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Two, two, TWO treats in one.
http://thinkgeek.com/sf
