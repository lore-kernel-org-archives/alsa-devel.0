From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Re: Detecting the sample format in the driver
Date: Mon, 20 Mar 2006 08:06:27 +0000
Message-ID: <1142841987.9459.7.camel@localhost.localdomain>
References: <1142810413.9700.45.camel@localhost.localdomain>
	 <20060320080019.GB5574@turing.informatik.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sc-outsmtp2.homechoice.co.uk (sc-outsmtp2.homechoice.co.uk [81.1.65.36])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 32EE61E6
	for <alsa-devel@alsa-project.org>; Mon, 20 Mar 2006 09:06:33 +0100 (MET)
In-Reply-To: <20060320080019.GB5574@turing.informatik.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Mon, 2006-03-20 at 09:00 +0100, Clemens Ladisch wrote:
> Adrian McMenamin wrote:
> > 	if ((substream->runtime)->format == SNDRV_PCM_FMTBIT_S16_LE)
> 
> This should be SNDRV_PCM_FORMAT_S16_LE.
> 
> 
Which works! Thanks.



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
