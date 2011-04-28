From: <kshemanth.vasireddi@wipro.com>
Subject: Copy call back for capture substream
Date: Thu, 28 Apr 2011 14:34:39 +0530
Message-ID: <A3D770027F3D024D8AA74E0D0C630813030CA7E7@PNE-HJN-MBX02.wipro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wipro-blr-out02.wipro.com (wipro-blr-out01.wipro.com
	[203.91.198.74])
	by alsa0.perex.cz (Postfix) with ESMTP id 7F30B103904
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Apr 2011 11:04:50 +0200 (CEST)
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

 

I am new to ALSA, I am trying to write an ALSA driver for voice channels
of and ADC.

 

I had create a sound card with a PCM instance with 2 capture sub
streams. I want to copy data manually by copy call back. I had
registered a copy call back.

 

I am trying to test my driver with arecord  -c 1 -f s16_LE  -t wav
test.wav. In log all call backs are invoked, but copy call back is not
getting invoked. Can you please let me know when will copy call  back
shall be invoked, is there any condition for it.

 

Thanks and regards,

Kshemanth


Please do not print this email unless it is absolutely necessary. 

The information contained in this electronic message and any attachments to this message are intended for the exclusive use of the addressee(s) and may contain proprietary, confidential or privileged information. If you are not the intended recipient, you should not disseminate, distribute or copy this e-mail. Please notify the sender immediately and destroy all copies of this message and any attachments. 

WARNING: Computer viruses can be transmitted via email. The recipient should check this email and any attachments for the presence of viruses. The company accepts no liability for any damage caused by any virus transmitted by this email. 

www.wipro.com
