From: pdq808@t-online.de (Reiner Klenk)
Subject: Re: New Powerbook - Mixer Prob
Date: Mon, 07 Jun 2004 20:50:54 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40C4B90E.8080808@t-online.de>
References: <40AA6321.3060305@t-online.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <40AA6321.3060305@t-online.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Clarification: seems to be a problem of the chip not being identified 
correctly. Workaround: skip detection and let chip->model = PMAC_SNAPPER 
in pmac.c
see here: http://lists.debian.org/debian-powerpc/2004/05/msg00349.html

Regards,
Reiner

Reiner Klenk wrote:
> Greetings,
> 
> I have a problem with a 15" powerbook (from the new series introduced 
> recently). aplay -l says card0 is AWACS. I can get sound, but only on 
> the headphone jack. No matter which mixer controls I fiddle with, there 
> is no sound from the speakers. Also, the volume on the headphone doesn't 
> seem to be influenced by any mixer controls.
> 
> Ideas ?
> 
> Thanks,
> Reiner
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by: SourceForge.net Broadband
> Sign-up now for SourceForge Broadband and get the fastest
> 6.0/768 connection for only $19.95/mo for the first 3 months!
> http://ads.osdn.com/?ad_id=2562&alloc_id=6184&op=click
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel



-------------------------------------------------------
This SF.Net email is sponsored by: GNOME Foundation
Hackers Unite!  GUADEC: The world's #1 Open Source Desktop Event.
GNOME Users and Developers European Conference, 28-30th June in Norway
http://2004/guadec.org
