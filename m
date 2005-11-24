From: Sasha Khapyorsky <sashakh@gmail.com>
Subject: Re: Conexant softmodem and snd-intel8x0m
Date: Thu, 24 Nov 2005 04:41:43 +0200
Message-ID: <20051124024143.GA6056@tecr>
References: <Pine.LNX.4.64.0511240134010.7042@rhama.deepcore.ngn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.193])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 41CDD1BC
	for <alsa-devel@alsa-project.org>; Thu, 24 Nov 2005 03:27:30 +0100 (MET)
Received: by wproxy.gmail.com with SMTP id i12so1427145wra
        for <alsa-devel@alsa-project.org>; Wed, 23 Nov 2005 18:27:28 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0511240134010.7042@rhama.deepcore.ngn>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "Theodoros V. Kalamatianos" <thkala@softlab.ece.ntua.gr>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 01:41 Thu 24 Nov     , Theodoros V. Kalamatianos wrote:
> 
> I own a Dell Latitude D800 laptop with a Centrino chipset and a Conexant 
> modem chip, which I have seen refered to as a CXT22 in some logs. The pcm 
> part of the modem is properly recognised by the snd-intel8x0m ALSA module, 
> but I am unable to tell the modem to go off-hook, as the related mixer 
> control does not seem to do anything.

This is exactly the problem with this codec (actually with all
unsupported CXT modem codecs).

> Has anyone had any success with ALSA 
> and these modems ?

No, afaik.

> How can I help to add support for them to ALSA ?

If you (as reference hw holder) can find how to hook-off this codec
this may help (I think some works should be done with 0x7a AC97
registers, but not something trivial, it is likely just pipe which pass
data to codec and DAA internal parts).

Also I'm pretty sure that 'hook-off' is only one visible problem there.

Sasha.


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
