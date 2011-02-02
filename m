From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: need input on USB Audio class device.
Date: Wed, 02 Feb 2011 16:14:28 +0100
Message-ID: <4D4974D4.4070803@ladisch.de>
References: <AANLkTi=yA+Ma0zo6HAceOdK1u8gv1hcVcT1dsOapv=Tp@mail.gmail.com>	<4D46A024.5000901@ladisch.de>
	<AANLkTi=oR4ADAjJOArUme73AjKdGnge8_n8Eo_+Fgw85@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 628E62457B
	for <alsa-devel@alsa-project.org>; Wed,  2 Feb 2011 16:14:19 +0100 (CET)
In-Reply-To: <AANLkTi=oR4ADAjJOArUme73AjKdGnge8_n8Eo_+Fgw85@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Sakthi Subramanian <sakthi.subramaniang@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Sakthi Subramanian wrote:
> i have opened a capture device, and the captured data i have written to a
> file.
> That file is of RAW format.
> I have opened the raw file in audacity, with 8 channel it shows only 2
> channels having the captured data.

Raw-format files do not have any information about the format, so
Audacity has to guess.  Just write a .wav file with the proper headers.


Regards,
Clemens
