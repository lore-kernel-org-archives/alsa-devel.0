From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Audiophile 192 driver
Date: Wed, 26 Jul 2006 19:27:42 -0400
Message-ID: <1153956462.2927.38.camel@mindpipe>
References: <1153955831.14079.3.camel@server>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1153955831.14079.3.camel@server>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Cruise X Overide <cruiseoveride@gmail.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 2006-07-26 at 19:17 -0400, Cruise X Overide wrote:
> ive started work on adding the audiophile 192 to ice1724.c
> 
> i have come across a peculiar problem. After i built the driver and
> rebooted. I can now only seem to have 1 soundcard driver loaded at once.
> 
> i have an intel8x0 which, when i load first, loads nicely, but if i load
> any other driver after that i get the following error in dmesg
> 
> ALSA /usr/src/Alsa/alsa-driver/acore/init.c:133: cannot find the slot
> for index 0 (range 0-0)
> ICE1724: probe of 0000:05:07.0 failed with error -12
> 
> if i unload it, and load my ice1724 only, it loads ok, otherwise i get
> the above error.

Can you post a link to your source code, in the form of a patch against
the ALSA ice1724.c driver?

Lee


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
