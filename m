From: Stefano Panella <stefano.panella@citrix.com>
Subject: paravirtualized alsa  kernel driver for XEN
Date: Mon, 19 Mar 2012 17:15:21 +0000
Message-ID: <4F6769A9.6090200@citrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from SMTP.EU.CITRIX.COM (smtp.ctxuk.citrix.com [62.200.22.115])
	by alsa0.perex.cz (Postfix) with ESMTP id 4E7C51041B0
	for <alsa-devel@alsa-project.org>; Mon, 19 Mar 2012 18:06:04 +0100 (CET)
Received: from stefanop.cam.xci-test.com ([10.80.248.120])	by
	norwich.cam.xci-test.com with esmtp (Exim 4.72)	(envelope-from
	<stefano.panella@citrix.com>)	id 1S9g1w-0002SO-JU	for
	alsa-devel@alsa-project.org; Mon, 19 Mar 2012 17:06:00 +0000
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

I am Stefano Panella, I am new to the list and I would like to take the 
opportunity to ask some questions since I am trying to write a 
paravirtualized alsa driver for XEN.

If all goes well I would also like to upstream it on linux.

I have been reading the documentation on "Writing an ALSA Driver" and I 
am still not completely clear on the meaning of the "pointer" callback 
in the pcm operations.

The description say:

"This callback is called when the PCM middle layer inquires the current 
hardware position on the buffer."

My question are:

1) In case of a playback stream, is the pointer referring to wich sample 
is currently playing on the DAC or to which is it the last frame read by 
the HW from the alsa memory buffer?

2) What does the pointer mean in case of a capture stream? Is it the 
position of the current frame on the ADC or is the latest frame written 
into the alsa buffer?

3) in case it is the frame on the DAC/ADC, what happens if the callback 
does not return the real DAC/ADC frame position but an approximate 
value, let say rounded to 64 frames only?

4) is there any test I could run to check I have implemented correctly 
the "pointer" callback? Or any application which would need very high 
"pointer" precision like frame precision?

Thanks very much in advance,

Stefano
