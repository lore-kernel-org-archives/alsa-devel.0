From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Juli@-Card and hanging process snd-ak4114/0
Date: Thu, 10 Mar 2005 12:11:50 -0500
Message-ID: <1110474710.12805.26.camel@mindpipe>
References: <20050310170354.GH78387@mail.webmonster.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Received: from viper.oldcity.dca.net (viper.oldcity.dca.net [216.158.38.4])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with SMTP id 786E01C5
	for <alsa-devel@alsa-project.org>; Thu, 10 Mar 2005 18:11:54 +0100 (MET)
In-Reply-To: <20050310170354.GH78387@mail.webmonster.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Sebastian Benoit <benoit-lists@fb12.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thu, 2005-03-10 at 18:03 +0100, Sebastian Benoit wrote:
> Hi,
> 
> I already reported this in a note to issue 930 of the ALSA bugtracking
> system:
> 
> I've a Juli@-Soundcard working with the current CVS-driver.
> 
> The main problem is, that a process "snd-ak4114/0" is using 60% of my CPU
> time. I would like to solve this problem, and have started reading trough
> the code. But it seems I need some pointers where to look ;-)

Why don't you use oprofile to find out where all that CPU time is being
spent?

Lee





-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
