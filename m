From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: VIA VT1708S
Date: Tue, 10 Aug 2010 08:43:29 +0200
Message-ID: <4C60F511.6060202@ladisch.de>
References: <19374822.165450.1281361435671.JavaMail.www@wwinf8214>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 9377724449
	for <alsa-devel@alsa-project.org>;
	Tue, 10 Aug 2010 08:43:54 +0200 (CEST)
In-Reply-To: <19374822.165450.1281361435671.JavaMail.www@wwinf8214>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "dominique.baudelin" <dominique.baudelin@laposte.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

dominique.baudelin wrote:
> In HD-Audio-Models.txt.gz file I don't find the VIA VT1708S codec and the assiociated Model name.
> Have you got this information? I would like write: options snd-hda-intel model=??????

The VIA HDA driver detects the codec configuration automatically.
If that doesn't work, try a newer kernel/driver version.


Regards,
Clemens
