From: Tim Goetze <tim@quitte.de>
Subject: Re: alsalib symbol problem
Date: Tue, 17 Sep 2002 10:52:53 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.21.0209171050510.612-100000@summer.quitte>
References: <3D8659BB.AD439110@sun.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3D8659BB.AD439110@sun.com>
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

>Why does this happen ? I searched the mailing list archive and only found an
>explanation that symbols don't match and I need to recompile the ALSA lib. In my
>case it's a clean install of ALSA on a newly installed red hat system. There was
>never any other version of ALSA. 

you probably are calling alsa from a shared object -- try 

  dlopen ("libasound.so", RTLD_LAZY | RTLD_GLOBAL);

in your module's init function.

hth, tim



-------------------------------------------------------
Sponsored by: AMD - Your access to the experts on Hammer Technology! 
Open Source & Linux Developers, register now for the AMD Developer 
Symposium. Code: EX8664 http://www.developwithamd.com/developerlab
