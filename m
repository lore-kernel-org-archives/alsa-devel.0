From: holborn <holborn@telefonica.net>
Subject: alsa-seq queue events
Date: Thu, 14 Aug 2003 19:20:30 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200308141920.30197.holborn@telefonica.net>
Reply-To: holborn@telefonica.net
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


Hi!

I have two questions.

When i queue a event

snd_seq_ev_set_note(&ev, channel, note, velocity, length);
snd_seq_ev_schedule_tick(&ev, queue_id,  0, tick);

if tick is earlier than the actual tick alsa-seq play the event?

i think that's true ...  but .. in this case:

when alsa-seq sends note-off for this event?   in tick+length?  or in "actual 
tick" + length?

well .. are four questions :-)

Thanks


Josep






-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
