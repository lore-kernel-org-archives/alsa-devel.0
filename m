From: Patrick Dumais <pat@dumaisnet.ca>
Subject: rawmidi
Date: Fri, 8 Oct 2004 11:26:39 -0400 (EDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0410081115480.13304@pat.dumaisnet.ca>
Reply-To: pat@dumaisnet.ca
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


I noticed that some drivers tend to send "batch" note-on commands. I mean:
instead of sending 90h,01h,7Fh everytime, it sends a first 90,01,7f then
just 02,7f etc... It sends the noteon command only once and assumes that
your application will set itself in a "noteon receive" mode. This is very
annoying because my application expects to receive a command byte each
time. the emu10k1 driver doesn't do that, but snd-virmidi does.

I'm using virmidi because I want 2 apps to read my sbLive midi port. I
aconnect this port to 2 virmidi ports then my apps read from those ports.

Is there any way that I can configure virmidi so that it sends commands
the conventional way, or any other way that I could have 2 applications
reading on the same midi port? (using the alsa sequencer interface is not
an alternative method that I want to consider for the scope of my
applications)

Thanks,
Patrick Dumais
****************************
http://www.dumaisnet.ca:242/


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
