From: Tim Goetze <tim@quitte.de>
Subject: Re: Re: alsalib symbol problem
Date: Tue, 17 Sep 2002 20:14:29 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.21.0209172012260.612-100000@summer.quitte>
References: <3D874CAE.DDA03E51@sun.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3D874CAE.DDA03E51@sun.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Florian Bomers <Florian.Bomers@sun.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Florian Bomers wrote:

>On the practical side - how can I solve the problem ? I can't change the way my
>plugin is linked to the main app, so do I need to manually dlopen() libasound
>myself with the RTLD_GLOBAL flag (and not use -lasound ??)

until your copy of alsa has jaroslav's recent addition, both. after,
-lasound should do.

tim



-------------------------------------------------------
This SF.NET email is sponsored by: AMD - Your access to the experts
on Hammer Technology! Open Source & Linux Developers, register now
for the AMD Developer Symposium. Code: EX8664
http://www.developwithamd.com/developerlab
