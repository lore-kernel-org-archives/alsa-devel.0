From: Hannu Savolainen <hannu@opensound.com>
Subject: Re: Re: [2.6 patch] schedule obsolete OSS drivers for
 removal
Date: Wed, 4 Jan 2006 01:41:16 +0200 (EET)
Message-ID: <Pine.LNX.4.61.0601040051200.2610@zeus.compusonic.fi>
References: <20050726150837.GT3160@stusta.de> <200601031629.21765.s0348365@sms.ed.ac.uk>
 <20060103170316.GA12249@dspnet.fr.eu.org> <200601031716.13409.s0348365@sms.ed.ac.uk>
 <20060103192449.GA26030@dspnet.fr.eu.org> <43BAFBBD.9010206@superbug.demon.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from minor.compusonic.fi (host1.compusonic.fi [195.238.198.242])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 4ECF617A
	for <alsa-devel@alsa-project.org>; Wed,  4 Jan 2006 00:43:23 +0100 (MET)
In-Reply-To: <43BAFBBD.9010206@superbug.demon.co.uk>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: James Courtier-Dutton <James@superbug.demon.co.uk>
Cc: Olivier Galibert <galibert@pobox.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 3 Jan 2006, James Courtier-Dutton wrote:

> The ALSA api is good enough so you can actually decide what happens when you
> get an error. e.g. an over or under run. You can tell ALSA to stop the stream,
> or you can tell is to continue on just using silence frames until you send it
> some new sounds.
> The OSS API cannot achieve that.
I would not say it in this way. I have intentionally left this kind of 
stuff of minimal or no importance out from the OSS API. This decision was 
made more than 10 years ago and it's still valid. In practice it 
will not take more than few hours to add this kind of interface to the 
API but I have no intention to do it. 

The cruel fact is that the application has already failed it it causes an 
overrun/underrun. There is an audible defect in the output or some 
recording data has been lost forever. There is no way to recover the 
error afterwards. So why to waste application programmer's time and 
energy with API features that can't work anyway. 

If an application has timing problems then it's better to force the 
programmer to fix the application design issues. For this reason OSS 
handles underruns in the simpliest possible way (by adding a full 
fragment of silence). This makes xruns clearly audible which in turn 
takes care that the problem will get noticed. 

With sophisticated application/driver interaction it may be possible to 
make the xrun defects almost unaudible but so what. OSS is designed for 
software professionals who do _NOT_ release applications that don't work 
correctly in the given environment. 

In OSS the application can check if an overrun/underrun has occurred and 
then make the decision to continue or abort. Most applications don't care 
about this kind of issues so all this has very limited importance.

Btw, about the subject. I would recommend quick removal of the current 
kernel OSS drivers since they are really obsolete. They are lacking all 
the development made to the OSS API during past (almost) 10 years. We are
planning to make an open source version of OSS available during this year
which will make the kernel OSS drivers unnecessary anyway.

Best regards,

Hannu
-----
Hannu Savolainen (hannu@opensound.com)
http://www.opensound.com (Open Sound System (OSS))
http://www.compusonic.fi (Finnish OSS pages)
OH2GLH QTH: Karkkila, Finland LOC: KP20CM


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
