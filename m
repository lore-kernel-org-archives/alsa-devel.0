From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Copy call back for capture substream
Date: Thu, 28 Apr 2011 11:29:45 +0200
Message-ID: <4DB93389.3060103@ladisch.de>
References: <A3D770027F3D024D8AA74E0D0C630813030CA7E7@PNE-HJN-MBX02.wipro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id 73F802432E
	for <alsa-devel@alsa-project.org>;
	Thu, 28 Apr 2011 11:28:20 +0200 (CEST)
In-Reply-To: <A3D770027F3D024D8AA74E0D0C630813030CA7E7@PNE-HJN-MBX02.wipro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: kshemanth.vasireddi@wipro.com
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

kshemanth.vasireddi@wipro.com wrote:
> I had registered a copy call back.
> 
> all call backs are invoked, but copy call back is not
> getting invoked. Can you please let me know when will copy call  back
> shall be invoked, is there any condition for it.

It's right there in the source code.

The copy callback is called exactly when in the same circumstances when
the data of a 'normal' driver would be copied out of the device's
buffer, i.e., when some data is available.

I'd guess that your pointer callback does not return the correct values.

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
