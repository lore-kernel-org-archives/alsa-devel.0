From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: [2.6 patch] schedule obsolete OSS drivers for removal
Date: Tue, 03 Jan 2006 22:33:33 +0000
Message-ID: <43BAFBBD.9010206@superbug.demon.co.uk>
References: <20050726150837.GT3160@stusta.de> <200601031629.21765.s0348365@sms.ed.ac.uk> <20060103170316.GA12249@dspnet.fr.eu.org> <200601031716.13409.s0348365@sms.ed.ac.uk> <20060103192449.GA26030@dspnet.fr.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from anchor-post-35.mail.demon.net (anchor-post-35.mail.demon.net [194.217.242.85])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 5203F170
	for <alsa-devel@alsa-project.org>; Tue,  3 Jan 2006 23:33:35 +0100 (MET)
In-Reply-To: <20060103192449.GA26030@dspnet.fr.eu.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Olivier Galibert <galibert@pobox.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Olivier Galibert wrote:
> 
> As for the OSS API being crippled, I'd take the 3 ioctl calls you need
> to setup a simple stereo 16bits output with OSS than the 13 ALSA
> library calls anyday.  Especially with the impressive lack of
> documentation you get about what the hell is a period, or what you can
> do except aborting when you get an error.
> 

There is perfectly good documentation. You just have not bothered to 
look at it.
The ALSA api is good enough so you can actually decide what happens when 
you get an error. e.g. an over or under run. You can tell ALSA to stop 
the stream, or you can tell is to continue on just using silence frames 
until you send it some new sounds.
The OSS API cannot achieve that.

James

P.S. Sorry, but I had to wipe all the cross posting addresses.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
