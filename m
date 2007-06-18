From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: pcm->private_data is NULL in alsa core!!
Date: Mon, 18 Jun 2007 09:37:45 +0200
Message-ID: <1182152265.9399.1195673497@webmail.messagingengine.com>
References: <61445c750706160550i592b416as6c766532de830147@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id C347D24131
	for <alsa-devel@alsa-project.org>;
	Mon, 18 Jun 2007 09:37:46 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <61445c750706160550i592b416as6c766532de830147@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "Pharaoh ." <pharaoh137@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Pharaoh . wrote:
> I have set the pcm->private_data = my_chip after registering the pcm ops,

Should work.

> ... but after I do snd_card_register(card) the pcm->private_data is
> corrupted !!
> 
> I have checked my source atleast 5 times and couldn't find anything in it.

I couldn't find anything either.  Not even your source code.


Regards,
Clemens
