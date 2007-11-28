From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: [usb-audio] M-Audio FastTrack Pro giving invalid
 sample rates
Date: Wed, 28 Nov 2007 10:27:51 +0100
Message-ID: <1196242071.6837.1223642425@webmail.messagingengine.com>
References: <474CBC60.9090408@trn.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id B793E24B0F
	for <alsa-devel@alsa-project.org>; Wed, 28 Nov 2007 10:27:53 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <474CBC60.9090408@trn.iki.fi>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?iso-8859-1?Q?Lasse=20K=E4rkk=E4inen?= <tronic+8nhy@trn.iki.fi>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Lasse K=E4rkk=E4inen wrote:
> ALSA seems to think that the card supports a wide range of sampling
> rates, but it does not manage to set them in practice. I do not know
> which is faulty, ALSA rate setting or the USB info sent by the device,
> but the problem needs to be fixed.

This device, and some others from M-Audio, do not really conform to the
USB Audio specification; there are interdependencies between the
playback, capture and digital interfaces that are not described in the
USB descriptors.

These devices will not be supported completely unless a separate driver
is written for them.


Regards,
Clemens
