From: Peter Zubaj <pzad@pobox.sk>
Subject: Re: Q: Periodsize for capture, SBLive
Date: Tue, 19 Oct 2004 10:07:23 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200410190807.i9J87NmG000466@www6.pobox.sk>
Reply-To: Peter Zubaj <pzad@pobox.sk>
Mime-Version: 1.0
Content-Type: TEXT/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: asbjs@stud.ntnu.no
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

> OK.  Any idea why I get 384?
I think hardware can't do less. If you need less latency use hw:0,2
and set more channel count (1, 2, 4, 8, 16, 32)

Peter Zubaj


=0A____________________________________=0Ahttp://www.pobox.sk/ - spolahliva=
 a bezpecna prevadzka=0A=0A=0A


-------------------------------------------------------
This SF.net email is sponsored by: IT Product Guide on ITManagersJournal
Use IT products in your business? Tell us what you think of them. Give us
Your Opinions, Get Free ThinkGeek Gift Certificates! Click to find out more
http://productguide.itmanagersjournal.com/guidepromo.tmpl
