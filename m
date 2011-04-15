From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Accessing already probed snd_card in kernel space
Date: Fri, 15 Apr 2011 09:37:17 +0200
Message-ID: <4DA7F5AD.3060207@ladisch.de>
References: <BANLkTi=6LHNZMeKisa57FYqsoYzQ_38vqQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out3.smtp.messagingengine.com (out3.smtp.messagingengine.com
	[66.111.4.27]) by alsa0.perex.cz (Postfix) with ESMTP id C069F1037FC
	for <Alsa-devel@alsa-project.org>;
	Fri, 15 Apr 2011 09:35:32 +0200 (CEST)
In-Reply-To: <BANLkTi=6LHNZMeKisa57FYqsoYzQ_38vqQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Shreshtha <shreshthakumar@gmail.com>
Cc: Alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Shreshtha wrote:
> How can I access already detected/populated sound card from inside the
> kernel using standard ALSA kernel APIs?

Why would you want to do this?  Why can't you do this from user space?

Anyway, there is no 'standard' ALSA kernel API.  You might have a look
at how the OSS emulation code accesses the ALSA devices.


Regards,
Clemens
