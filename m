From: Giuliano Pochini <pochini@shiny.it>
Subject: RE: Test Report: snd-asihpi with an ASI6114
Date: Thu, 26 Jun 2003 16:25:22 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20030626162522.pochini@shiny.it>
References: <200306260941.47611.fredg@salemradiolabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200306260941.47611.fredg@salemradiolabs.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Fred Gleason <fredg@salemradiolabs.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


On 26-Jun-2003 Fred Gleason wrote:
> I've got things working with my ASI6114.  Playback works well.
>
> Alsamixer shows me a bewildering array of controls, few of which seem to
> do anything.  How do I control stream levels?

I don't know that chip, but the names of the controls should be
self-explanatory enough. "stream" level is not the right name. The
control API has no knowledge of streams. You can set the level of
a channel indipendently from any open (sub)stream. I suggest you
to use amixer instead. It has only a command line interface, but
it gives a lot of useful infos. Try "amixer contents".


Bye.



-------------------------------------------------------
This SF.Net email is sponsored by: INetU
Attention Web Developers & Consultants: Become An INetU Hosting Partner.
Refer Dedicated Servers. We Manage Them. You Get 10% Monthly Commission!
INetU Dedicated Managed Hosting http://www.inetu.net/partner/index.php
