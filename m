From: James Gauld <james@thundermonkey.net>
Subject: Re: Help required. Slax OS, no audio, multiple cards,
 hdmi
Date: Tue, 14 Apr 2009 16:46:21 +0100
Message-ID: <49E4AFCD.6020603@thundermonkey.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out5.blueyonder.co.uk (smtp-out5.blueyonder.co.uk
	[195.188.213.8]) by alsa0.perex.cz (Postfix) with ESMTP id 54E7C243E2
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Apr 2009 17:46:23 +0200 (CEST)
Received: from [172.23.170.143] (helo=anti-virus02-10)
	by smtp-out5.blueyonder.co.uk with smtp (Exim 4.52)
	id 1Ltkq6-0006uv-MZ
	for alsa-devel@alsa-project.org; Tue, 14 Apr 2009 16:46:22 +0100
Received: from [82.39.153.172] (helo=[192.168.2.3])
	by asmtp-out2.blueyonder.co.uk with esmtpa (Exim 4.52)
	id 1Ltkq4-0003Ov-Ha
	for alsa-devel@alsa-project.org; Tue, 14 Apr 2009 16:46:20 +0100
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Yes, I tried the following Slax module first of all:

http://www.slax.org/modules.php?action=detail&id=1063

with no success.

any other suggestions?

i've enabled iec958 mixer control, but cannot adjst it's volume. the
HDMI device does not have the "pvolume" capability. I don't know if
that's of any significance, but I'm in dark, uncharted territory here.


Lee Revell wrote:
> On Mon, Apr 13, 2009 at 11:09 AM, James Gauld <james@thundermonkey.net> wrote:
>> However, running slax (from usb) I cannot get any sound from either
>> device, but I'm only interested in the HDMI card (card #1) which
>> delivers output to the integrated speakers (as far as I can tell from
>> windows).
>>
>> I've tried from console and various widgets in KDE with no success.
> 
> Try installing the proprietary ATI video driver.  Thanks to DRM the
> video driver has veto power over whether you can output audio via
> HDMI.
> 
> Lee
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> 
> 
