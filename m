From: Krzysztof Foltman <wdev@foltman.com>
Subject: Re: [PATCH 1/1] ALSA: usb-audio: add support for Akai
 MPD16
Date: Wed, 19 May 2010 21:31:48 +0100
Message-ID: <4BF44AB4.7050808@foltman.com>
References: <1274207876-3215-1-git-send-email-wdev@foltman.com>
	<4BF38C5A.7040901@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from outbound-mail-313.bluehost.com (cpoproxy3-pub.bluehost.com
	[67.222.54.6]) by alsa0.perex.cz (Postfix) with SMTP id A89071038D6
	for <alsa-devel@alsa-project.org>;
	Wed, 19 May 2010 22:31:53 +0200 (CEST)
Received: from [188.141.6.113] (helo=[192.168.1.12])
	by box517.bluehost.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.69) (envelope-from <wdev@foltman.com>) id 1OEpvi-0007y2-Co
	for alsa-devel@alsa-project.org; Wed, 19 May 2010 14:31:50 -0600
In-Reply-To: <4BF38C5A.7040901@ladisch.de>
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

On 05/19/2010 07:59 AM, Clemens Ladisch wrote:

>  This might overflow if the buffer ends with a 2x byte.

True. I rewrote that part now, using better sanity checking (hopefully). 
Also, the control endpoint uses 0x1x instead of 0x2x and the length is 
9, so the mask 0xF8 was wrong too.

>  Assuming that this device doesn't have any output ports, please add
>  a comment that this isn't the actual output protocol.

In the most recent version, I've added output support (for control port 
only, as the device does not seem to handle input on its data port 
endpoint). It's a little bit hairy, but seems to do the job. I've 
checked it with amidi, both input and output - even when I deliberately 
added junk before actual sysex data, or when I put several SysEx 
messages in one hex string. The device seems to require that individual 
messages are entirely contained within a single USB packet, which 
complicates things a little bit.

Thanks!

K.
