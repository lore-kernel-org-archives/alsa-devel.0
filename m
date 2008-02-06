From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: OSS4 X-Fi driver port to ALSA
Date: Wed, 06 Feb 2008 08:19:53 +0100
Message-ID: <47A95F99.7030609@ladisch.de>
References: <1202160350.3719.76.camel@petrie.sacredspiral.co.uk.sacredspiral.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id D0C761038FF
	for <alsa-devel@alsa-project.org>; Wed,  6 Feb 2008 08:18:04 +0100 (CET)
In-Reply-To: <1202160350.3719.76.camel@petrie.sacredspiral.co.uk.sacredspiral.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: William Pitcock <nenolod@sacredspiral.co.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

William Pitcock wrote:
> On Feburary 1, 4Front released their XFi driver to the public. Is anyone
> looking into porting this? If not, I will give it a try soon enough.

Please not that the hwaccess.* files are apparently not GPL licensed.

> It seems to not require any firmware at all too.

Because the driver doesn't support the interesting features (hardware
mixing, DSP).


Regards,
Clemens
