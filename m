From: Justin Cormack <justin@street-vision.com>
Subject: Re: Re: How to support multiple open in low-level
	driver
Date: 06 Jan 2003 13:57:35 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1041861462.32308.19.camel@lotte>
References: <Pine.LNX.4.33.0301051532360.500-100000@pnote.perex-int.cz>
	<200301051548.31168.torger@ludd.luth.se>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from tench.street-vision.com ([212.18.235.100])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id OAA32766
	for <alsa-devel@alsa-project.org>; Mon, 6 Jan 2003 14:57:48 +0100
In-Reply-To: <200301051548.31168.torger@ludd.luth.se>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Anders Torger <torger@ludd.luth.se>
Cc: Jaroslav Kysela <perex@suse.cz>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sun, 2003-01-05 at 14:48, Anders Torger wrote:
> I have another question. The rme96 driver provides two sub devices, one 
> which is the card in adat mode, and one which is the card in spdif 
> mode. These cannot be run at the same time.
> 
> If I had written the driver today, I suppose I would have had only one 
> device, which supports 2 or 8 channels. Do you agree that it would be a 
> better design, than the two sub-devices I have now? I don't think I 
> will change that now though, if you don't insist that I should (I think 
> it will be quite easy to do the change).

It means that you have to define software devices for adat and spdif,
which output always to 8 or 2 channels hw, as the general plughw device
will sometimes open one sometimes the other depending on how many
channels your sound source is. As they are on the same output and most
people only have one kind of DA converter attached this may not be that
convenient. I dont mind the current scheme.

Justin




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
