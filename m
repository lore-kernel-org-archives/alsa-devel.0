From: "Ronny V. Vindenes" <s864@ii.uib.no>
Subject: Re: Problem with supported PCM formats in ice1712
	driver
Date: Sat, 17 Jan 2004 13:08:27 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1074341307.3405.9.camel@terminal124.gozu.lan>
References: <1074305741.6251.7.camel@moria.arnor.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from eik.ii.uib.no (eik.ii.uib.no [129.177.16.3])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id NAA04803
	for <alsa-devel@alsa-project.org>; Sat, 17 Jan 2004 13:09:08 +0100
In-Reply-To: <1074305741.6251.7.camel@moria.arnor.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Torrey Hoffman <thoffman@arnor.net>
Cc: ALSA Development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sat, 2004-01-17 at 03:15, Torrey Hoffman wrote:
> I've got an M-Audio Audiophile 2496 and am running linux 2.6.1-mm3
> (which includes ALSA 1.0.1).
> 
> I'm trying to get all my sound applications working using only ALSA
> interfaces.   I'm having problems with the ice 1712 driver.
> 

> 
> --
> Message: alsa_setup_mixer
> Message: alsa_setup_mixer: end
> Message: Opening device
> Message: alsa_setup
> Message: output format: 7, rate: 44100, channels: 2
> Message: Opening device: hw:0,0
> Opened ALSA card 0, Device 0, Subdevice 0
> Message: Configuring device: hw:0,0
> Message: Attempting to set hardware format S16_LE
> Message: Attempting to set next hardware format S16_LE
> Message: Attempting to set next hardware format S16_BE
> Message: Attempting to set next hardware format U8
> ** WARNING **: alsa_setup(): Sample format not available for playback:
> Invalid argument
> Message: Closing device
> Message: Device closed
> --

> This seems to explain why the XMMS Alsa plugin fails... apparently only
> "Signed 32 bit Little Endian" is supported by this driver???
> 

The Envy24 hardware only supports 24bit in 32bit little-endian format,
if you want other formats you have to use the plughw: device.

-- 
Ronny V. Vindenes <s864@ii.uib.no>



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
