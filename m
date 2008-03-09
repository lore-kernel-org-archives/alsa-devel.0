From: Pavel Hofman <pavel.hofman@insite.cz>
Subject: ICE1724 - File descriptor in bad state when capturing
Date: Sun, 09 Mar 2008 23:56:01 +0100
Message-ID: <47D46B01.8020009@insite.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailserver.bobrnet.net (bobrnet.cust.inethome.cz [88.146.180.6])
	by alsa0.perex.cz (Postfix) with ESMTP id F270010380B
	for <alsa-devel@alsa-project.org>; Sun,  9 Mar 2008 23:56:10 +0100 (CET)
Received: from [192.168.105.213] (ap-dustin.bobrnet.cz [10.109.8.38])
	by mailserver.bobrnet.net (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id
	m29MuRlS012639
	for <alsa-devel@alsa-project.org>; Sun, 9 Mar 2008 23:56:27 +0100
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

Hi,

I have most of the ESI Juli driver working, but I have hit a problem 
with the capture stream. I had to modify some ice1724.c code to allow 
redefining clock-related functions in the actual card file (Juli has a 
different clocking scheme), but all the DMA code is left intact, as well 
as the methods defining the capture stream.

The ice1724 vu-meters detect input ADC data, I can hear correct sound 
when setting the internal mixer to H/W-In. Yet, when trying to record, I get

arecord -v -D hw:0,0,0 -r 44100 -f S32_LE -c2

....
RIFF$WAVEfmt  ... data arecord: pcm_read:1346: read error: File 
descriptor in bad state

At the same time, my second Envy24-based card Prodigy192 (uses the 
original methods in ice1724.c) works OK, arecord gives no errors. 
Swapping the cards using the model parameter (to swap the 
/dev/snd/pcmCXDXc device file) makes no difference.

Thank you for any hints of where I should focus my attention to. I am 
not attaching the patches, as they are rather complicated. If you find 
that important, I will send the preliminary version.


Pavel Hofman.
