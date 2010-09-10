From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: M-Audio Fast Track Ultra (8r) mixer: How to verify
 dB	information?
Date: Fri, 10 Sep 2010 09:18:29 +0200
Message-ID: <4C89DBC5.7070906@ladisch.de>
References: <4C89539E.8030701@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 7E38724490
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Sep 2010 09:18:06 +0200 (CEST)
In-Reply-To: <4C89539E.8030701@web.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Felix Homann <fexpop@web.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Felix Homann wrote:
> after some struggle I managed to get the mixer in the M-Audio working.
> Before I submit a patch I would like to know if there's an way to test
> the dB information for the controls. I'm using the mixer_vol_tlv TLV
> callback right now but I'm not sure it produces correct data.

Try alsamixer.  Or just post the output of "amixer contents" here.


Regards,
Clemens
