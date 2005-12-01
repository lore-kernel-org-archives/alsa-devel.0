From: David Peroutka <David.Peroutka@seznam.cz>
Subject: Re: M-Audio Revolution 5.1 Support
Date: Thu, 1 Dec 2005 20:19:28 +0000 (UTC)
Message-ID: <loom.20051201T211819-384@post.gmane.org>
References: <loom.20051201T152934-108@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Pieter-Jan Malfait <pieterjan.malfait <at> gmail.com> writes:

> 
> hello,
> 
> i've read on a couple of sites that the M-Audio Revolution 5.1 is not supported
> by   the alsa driver, however some of these sites were over a year old.. Is it
> currently supported or will it be in the near future ?
> 
> thank you
> 
> kind regards,
> PJ
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
> for problems?  Stop!  Download the new AJAX search engine that makes
> searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
> http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
> 

Hello,

unfortunately, the Revolution 5.1 is currently not supported in ALSA; only
Revolution 7.1 is supported. Both cards are based on VIA Envy 24HT controller,
but there are some notable differences between the two models:

The front two output channels of the Revolution 7.1 use AKM AK4381 stereo DAC,
the remaining 5.1 channels use AKM AK4355.  Analog audio is sampled with the
AKM AK5380 ADC.

The Revolution 5.1 uses different codecs.  All output channels use AKM AK4358
(8-ch DAC, 24/192). Inputs are sampled by AKM AK5365 (24/96).  Also, the
Revolution 5.1 has a dedicated headphone output.

Also note, that the DAC used in Revolution 5.1 is the same as in Juli@, which
is already supported in ALSA (ice1724).

I've also tried a kernel patch, that is supposed to add support for the M-Audio
Revolution 5.1:

http://www.mph.eclipse.co.uk/pub/linux/patches/ice1712_revo.patch

but it does not work for me; apparently the driver failed to setup the output
codec, so I can only hear some strange dizzling sounds, coming out at full
volume :)

I hope that someone will be able to add ALSA support for this great card. I'm
willing to help in this effort (by testing or coding).

Currently, I'm forced to use free-version of OSS drivers:

http://www.opensound.com/

which works very well for Revolution 5.1, but they are commercial
closed-source binary-only modules.

Regards,

--
David




-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
