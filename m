From: Manuel Jander <manuel.jander@usm.cl>
Subject: Re: The ALSA Situation
Date: Thu, 11 Nov 2004 12:50:56 -0300
Message-ID: <1100188256.2431.8.camel@localhost>
References: <20041110235502.6C8211D2B2D@sc8-sf-uberspam1.sourceforge.net>
	 <20041111085646.GB17034@rhlx01.fht-esslingen.de>
Reply-To: mjander@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20041111085646.GB17034@rhlx01.fht-esslingen.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: andi@lisas.de, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi,

[snip]
> In my azt3328 driver, I went through great pains to try to avoid popping
> (mostly successful), but I guess some of that work is actually not necessary
> any more once stream popping issues get handled at ALSA level.
> (BTW: does the other operating system take any measures against popping?)

Yes, some driver do, but as usual every driver does this kind of stuff
on their own.
Would be nice to see that in ALSA. Should not be that difficult, its
just about appending a few samples ramping toward zero when stopping the
device.

Manuel Jander

-- 
Manuel Jander
Electronic Engineer



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
