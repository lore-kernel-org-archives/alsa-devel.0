From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: alsa-lib: pcm_softvol.c: attenuation curve - it
 seems to be too quiet at full volume
Date: Mon, 25 Jun 2007 09:13:10 +0200
Message-ID: <1182755590.11876.1196861307@webmail.messagingengine.com>
References: <20070622165006.412ed10a@jutz-fc6.na.corp.dmxmusic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4.smtp.messagingengine.com (out4.smtp.messagingengine.com
	[66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id A9A4A24367
	for <alsa-devel@alsa-project.org>;
	Mon, 25 Jun 2007 09:13:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070622165006.412ed10a@jutz-fc6.na.corp.dmxmusic.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "John L. Utz III" <john.utz@dmx.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

John L. Utz III wrote:
> Softvol works quite well *except* that the max volume for the rear
> channel is now much quieter than it is without softvol. :-(

You should be able to get the original volume by setting the mixer to
0 dB.


Regards,
Clemens
