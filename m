From: <kshemanth.vasireddi@wipro.com>
Subject: Re: Copy call back for capture substream
Date: Tue, 3 May 2011 11:33:45 +0530
Message-ID: <A3D770027F3D024D8AA74E0D0C63081303135D92@PNE-HJN-MBX02.wipro.com>
References: <A3D770027F3D024D8AA74E0D0C630813030CA7E7@PNE-HJN-MBX02.wipro.com>	<4DB93389.3060103@ladisch.de>	<A3D770027F3D024D8AA74E0D0C630813030CAF55@PNE-HJN-MBX02.wipro.com>	<4DBAD7A6.3030502@ladisch.de>
	<A3D770027F3D024D8AA74E0D0C630813031359F6@PNE-HJN-MBX02.wipro.com>
	<4DBEA6CF.1090706@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wipro-blr-out01.wipro.com (wipro-blr-out01.wipro.com
	[203.91.198.74])
	by alsa0.perex.cz (Postfix) with ESMTP id 6A60B1037F8
	for <alsa-devel@alsa-project.org>;
	Tue,  3 May 2011 08:03:51 +0200 (CEST)
Content-class: urn:content-classes:message
In-Reply-To: <4DBEA6CF.1090706@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

Copy call back is getting invoked for sterio mode with below command

arecord -c 2 -f s16_LE -r 48000 -t wav test.wav

But when I tried to create separate files for both the channels using
below command, copy call is not getting invoked.

arecord -c 2 -f s16_LE -r 48000 -I test1 test2

Please help me out. I want to create separate raw files for both
channels.

Thanks and regards,
Kshemanth


-----Original Message-----
From: Clemens Ladisch [mailto:clemens@ladisch.de] 
Sent: Monday, May 02, 2011 6:13 PM
To: Kshemanth Vasireddi (WT01 - Manufacturing & Hi Tech)
Cc: alsa-devel@alsa-project.org
Subject: Re: [alsa-devel] Copy call back for capture substream

kshemanth.vasireddi@wipro.com wrote:
> If I want to record both channels in separate files, what command
should
> be given to arecord, I am not clear on -I option.

Just give two file names.  Please note that this always results
in raw files.

> The information contained in this electronic message ...

This e-mail contains public information intended for any subscriber of
this mailing list and for anybody else who bothers to read it; it will
be copied, disclosed and distributed to the public.  If you think you
are not the intended recipient, please commit suicide immediately.
These terms apply also to any e-mails quoted in, referenced from, or
answering this e-mail, and supersede any confidentiality notices in
those e-mails.  Additionally, confidentiality notices in those e-mails
will incur legal processing fees of $42 per line; you have agreed to
this by reading this confidentiality notice.


Regards,
Clemens

Please do not print this email unless it is absolutely necessary. 

The information contained in this electronic message and any attachments to this message are intended for the exclusive use of the addressee(s) and may contain proprietary, confidential or privileged information. If you are not the intended recipient, you should not disseminate, distribute or copy this e-mail. Please notify the sender immediately and destroy all copies of this message and any attachments. 

WARNING: Computer viruses can be transmitted via email. The recipient should check this email and any attachments for the presence of viruses. The company accepts no liability for any damage caused by any virus transmitted by this email. 

www.wipro.com
