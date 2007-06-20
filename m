From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: pcm->private_data is NULL in alsa core!!
Date: Wed, 20 Jun 2007 18:13:15 +0200
Message-ID: <1182355995.14744.1196173731@webmail.messagingengine.com>
References: <61445c750706160550i592b416as6c766532de830147@mail.gmail.com>
	<1182152265.9399.1195673497@webmail.messagingengine.com>
	<61445c750706180456i5228c8dbqbd168e5a3bbbe435@mail.gmail.com>
	<1182251430.29389.1195911445@webmail.messagingengine.com>
	<61445c750706190430i7d8f37b3g95326d7aee6c5056@mail.gmail.com>
	<1182263378.1273.1195944481@webmail.messagingengine.com>
	<61445c750706200318h6758cf78o64dfd3e6a88ea8bb@mail.gmail.com>
	<61445c750706200412i52e6666fjc7a5552972b18f7b@mail.gmail.com>
	<61445c750706200416y4654fcfcq8a064c645956f5e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id CD22A24340
	for <alsa-devel@alsa-project.org>;
	Wed, 20 Jun 2007 18:13:16 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <61445c750706200416y4654fcfcq8a064c645956f5e@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Pharaoh ." <pharaoh137@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Pharaoh . wrote:
> Registering the sound card
> pcm->private in snd_device_register_all is c1d7d310 //correct
> Inside snd_pcm_dev_register, pcm is c1f05d44(correct), pcm->pvt_data
> is 00000000(This shouldn't be NULL)

Does the value of pcm itself change?
Do other fields in pcm change?


Regards,
Clemens
