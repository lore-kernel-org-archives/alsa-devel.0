From: "Pavana Sharma" <pavans@india.ti.com>
Subject: RE: Testing Audio driver
Date: Thu, 18 Mar 2004 14:45:56 +0530
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <000901c40cc9$9f771d80$f8b6a8c0@ent.ti.com>
References: <Pine.LNX.4.58.0403181003560.1835@pnote.perex-int.cz>
Reply-To: <pavans@india.ti.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0403181003560.1835@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: 'Jaroslav Kysela' <perex@suse.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Thank you,


-----Original Message-----
From: Jaroslav Kysela [mailto:perex@suse.cz]
Sent: Thursday, March 18, 2004 2:35 PM
To: Pavana Sharma
Cc: alsa-devel@lists.sourceforge.net
Subject: Re: [Alsa-devel] Testing Audio driver


On Thu, 18 Mar 2004, Pavana Sharma wrote:

> My doubts are,
>  where can I find the definitions for these functions or Alsa APIs ?
>  Do i need to have any lib (alsa_lib) ?
>  If not how my driver can be accessed from application layer, I mean how
> calls are mapped ?

You must use alsa-lib. We don't allow to use the syscalls directly.
Also, you might look to alsa-lib/test/pcm.c code which shows you
(and you can test with it) all access methods (playback only) - compile 
alsa-lib and type 'make pcm' in the test directory.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
