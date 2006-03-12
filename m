From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Re: Dreamcast AICA driver
Date: Sun, 12 Mar 2006 10:59:41 +0000
Message-ID: <1142161181.9555.3.camel__13083.384538959$1142161219$gmane$org@localhost.localdomain>
References: <1142124747.9496.50.camel@localhost.localdomain>
	 <1142125920.25358.22.camel@mindpipe>
	 <1142126427.9496.56.camel@localhost.localdomain>
	 <1142144081.25358.103.camel@mindpipe> <1142144901.25358.108.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sc-outsmtp2.homechoice.co.uk (sc-outsmtp2.homechoice.co.uk [81.1.65.36])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 250291D5
	for <alsa-devel@alsa-project.org>; Sun, 12 Mar 2006 11:59:46 +0100 (MET)
In-Reply-To: <1142144901.25358.108.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: linux-sh <linuxsh-dev@lists.sourceforge.net>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Sun, 2006-03-12 at 01:28 -0500, Lee Revell wrote:
> On Sun, 2006-03-12 at 01:14 -0500, Lee Revell wrote:
> > You should submit this to ALSA now, as a patch against CVS...
> 
> 
> static int snd_aicapcm_free(snd_card_aica_t *dreamcastcard)
> {
> 	release_mem_region(0xa0702c00, 0x4);
> 	release_mem_region(0xa0800000, 0x200000);
> 	return 0;
> }
> 
> Actually this driver still has way too many magic numbers - if you're
> not exactly sure what a constant does then document it with comments in
> the header file.
> 

I know what these are - they can be turned into constants - they are
either references to the ARM7 register bank or the ARM7 memory space.


> It looks like many of these will be trivial to document:
> 
> 	if (request_mem_region(0xa0702c00, 4, "AICA ARM control")== NULL) return -ENOMEM;
> 	if (request_mem_region(0xa0800000, 0x200000, "AICA Sound RAM") == NULL)
> 
> Lee
> 
> 
> 
> -------------------------------------------------------
> This SF.Net email is sponsored by xPML, a groundbreaking scripting language
> that extends applications into web and mobile media. Attend the live webcast
> and join the prime developer group breaking into this new coding territory!
> http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
