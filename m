From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: ALSA Support for Roland Gaia SH-01
Date: Mon, 21 Nov 2011 13:50:27 +0100
Message-ID: <4ECA4913.7050307@ladisch.de>
References: <1321835088.14960.22.camel@darkside>
	<CACckToWK3kr4tfWjAOXnpVxH792tOZekeCVT8=g7zPCD31gm5Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 948652469D
	for <alsa-devel@alsa-project.org>; Mon, 21 Nov 2011 13:50:32 +0100 (CET)
Received: from compute5.internal (compute5.nyi.mail.srv.osa [10.202.2.45])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id E4D252070C
	for <alsa-devel@alsa-project.org>; Mon, 21 Nov 2011 07:50:29 -0500 (EST)
In-Reply-To: <CACckToWK3kr4tfWjAOXnpVxH792tOZekeCVT8=g7zPCD31gm5Q@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: John F Leach <jfleach@jfleach.com>, Grant Diffey <gdiffey@gmail.com>
Cc: alsa-devel@alsa-project.org, zonque@gmail.com
List-Id: alsa-devel@alsa-project.org

Grant Diffey wrote:
> On Mon, Nov 21, 2011 at 11:24 AM, John F Leach <jfleach@jfleach.com> wrote:
> >                         .type = QUIRK_STANDARD_MIDI_INTERFACE,
> 
> From the looks of interface 2 which I'm guessing is the midi subinterface
> it doesn't seem to conform to the UAC spec

Yes; Roland's MIDI interfaces use different descriptors.

> This might need to be QUIRK_FIXED_MIDI_ENDPOINT maybe?

		...
		{
			.ifnum = 2,
			.type = QUIRK_MIDI_FIXED_ENDPOINT,
			.data = & (const struct snd_usb_midi_endpoint_info) {
				.out_cables = 0x0003,
				.in_cables  = 0x0003
			}
		},
		...


Regards,
Clemens
