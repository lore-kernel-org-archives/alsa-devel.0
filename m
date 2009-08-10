From: "Harsha, Priya" <priya.harsha@intel.com>
Subject: Re: issue at 44.1 Khz capturing
Date: Mon, 10 Aug 2009 18:42:47 +0530
Message-ID: <98769532B4BB14429434178695419EAE5F937AC6@bgsmsx501.gar.corp.intel.com>
References: <98769532B4BB14429434178695419EAE5F937821@bgsmsx501.gar.corp.intel.com>
	<4A8009B5.5020305@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 630B8103873
	for <alsa-devel@alsa-project.org>;
	Mon, 10 Aug 2009 15:15:27 +0200 (CEST)
In-Reply-To: <4A8009B5.5020305@ladisch.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

I see that the buffer allocated is 22050 bytes (and not 22052 bytes). Yes the hardware supports buffers which are not multiple of period size.

Can I forcefully set my buffer size to 22052 bytes and allocate using snd_pcm_lib_malloc_pages and try? Will that help?	 

Thanks,
Harsha.
>-----Original Message-----
>From: Clemens Ladisch [mailto:clemens@ladisch.de]
>Sent: Monday, August 10, 2009 5:21 PM
>To: Harsha, Priya
>Cc: alsa-devel@alsa-project.org
>Subject: Re: [alsa-devel] issue at 44.1 Khz capturing
>
>Harsha, Priya wrote:
>> ... But when I printed out the values passed from the pointer function,
>> they are exactly at the intervals of 5513 bytes.
>
>What is the exact buffer size?  Half a second would be 22050 bytes
>(frames?), while four of your periods are 22052 bytes.
>Does your hardware support buffers whose length is not an integer
>multiple of the period size?
>
>
>Best regards,
>Clemens
