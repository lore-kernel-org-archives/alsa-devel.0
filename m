From: "Edward Wildgoose" <ed@wildgooses.com>
Subject: Re: HDSP 9632 driver and expansion cards
Date: Thu, 22 Jan 2004 22:46:40 -0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <018701c3e139$9ab05a20$0369a8c0@BigMotha>
References: <1074650862.6893.10.camel@rivendell.home.local> <400E74F6.1040803@undata.org> <02f701c3e04e$1f39d2e0$5d40a8c0@FRiskMan.com> <400EEDE9.80208@undata.org> <013301c3e0fc$f4ea92e0$5d40a8c0@FRiskMan.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Thomas Charbonnel <thomas@undata.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> I will try it again and document exactly which apps and what my setup is.
> Sorry for the vague problem report...  In the meantime I'm actually using
> the PAD card for general duties (ie watching TV)

Hi Thomas,

I successfully watched a surround 5.1 film tonight using the 9632!! Wahey!  Thanks a bunch!

I had to use Xine and oss emulation (kernel 2.6.1 mm-1 and alsa patched to around 1.01 I think?).  Alsa and xine gave errors about
device surround51 not being defined, but I think this is likely my setup of Xine..?

Mplayer completely refuses to play ball.  In asla mode (using plug), it scrolls a load of:
alsa-space: xrun of at least: 11.501 msecs, resetting stream

type messages.   (always 10-12ms, with occasionaly 18ms thrown in)  Sound just stutters constantly.

It is no better in OSS mode, same bad audio, but no messages on the screen.

I'm fairly sure that mplayer is at least trying to set the period size (since it fails to work under alsa with my RME 96/8 PAD card,
moaning about unable to set period size).

Any ideas what might be happening?  My guess would have been that the period size was too small and the player was not servicing the
audio frequently enough...  However, I'm not sure...

Mythtv has a similar issue, and this is the main app I want to get working.  Any ideas would be appreciated!

Thanks

Ed W



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
