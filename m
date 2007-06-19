From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: pcm->private_data is NULL in alsa core!!
Date: Tue, 19 Jun 2007 13:10:30 +0200
Message-ID: <1182251430.29389.1195911445@webmail.messagingengine.com>
References: <61445c750706160550i592b416as6c766532de830147@mail.gmail.com>
	<1182152265.9399.1195673497@webmail.messagingengine.com>
	<61445c750706180456i5228c8dbqbd168e5a3bbbe435@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 32EE824380
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Jun 2007 13:10:31 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <61445c750706180456i5228c8dbqbd168e5a3bbbe435@mail.gmail.com>
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
> > > I have set the pcm->private_data = my_chip after registering the pcm ops,
> > > ... but after I do snd_card_register(card) the pcm->private_data is
> > > corrupted !!

snd_card_omap_alsa_pcm() should be __devinit, and full duplex is implied
when no other XXX_DUPLEX flag is set, but I couldn't find any obvious
errors related to private_data.

Does the changing of private_data really occur in snd_card_register(),
i.e., the output you get is:

| in register codec 4 pvt data is (something)
| in register codec 5 pvt data is 0

And the new value is NULL?

snd_card_register() calls callbacks for all registered devices.  It
could be possible that some callback registered by eac_register_mixer()
does something, but I don't know what this function does.


Regards,
Clemens
