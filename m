From: <kshemanth.vasireddi@wipro.com>
Subject: arecord read error: Input/output error
Date: Wed, 4 May 2011 12:42:41 +0530
Message-ID: <A3D770027F3D024D8AA74E0D0C630813031921F7@PNE-HJN-MBX02.wipro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wipro-blr-out02.wipro.com (wipro-blr-out01.wipro.com
	[203.91.198.74])
	by alsa0.perex.cz (Postfix) with ESMTP id 9C6F110380F
	for <alsa-devel@alsa-project.org>;
	Wed,  4 May 2011 09:12:48 +0200 (CEST)
Content-class: urn:content-classes:message
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

 

I am new to ALSA, I have written an ALSA driver for ADC voice channels.
I am testing ALSA driver using arecord

 

"arecord -c 2 -f s16_LE -r 48000 -t raw test_file.raw"; when capture
file reaches 88KB arecord is terminating capture with error

 

"arecord: pcm_read:1529: read error: Input/output error

 

Can someone please help to identify actual reason for this.

 

Thanks and regards,

Kshemanth


Please do not print this email unless it is absolutely necessary. 

The information contained in this electronic message and any attachments to this message are intended for the exclusive use of the addressee(s) and may contain proprietary, confidential or privileged information. If you are not the intended recipient, you should not disseminate, distribute or copy this e-mail. Please notify the sender immediately and destroy all copies of this message and any attachments. 

WARNING: Computer viruses can be transmitted via email. The recipient should check this email and any attachments for the presence of viruses. The company accepts no liability for any damage caused by any virus transmitted by this email. 

www.wipro.com
