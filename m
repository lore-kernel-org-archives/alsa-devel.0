From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Problem with CME UF5 MIDI keyboard master volume
 slider
Date: Mon, 06 Aug 2007 12:41:08 +0200
Message-ID: <1186396868.28794.1203930879@webmail.messagingengine.com>
References: <1186223690.3246.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 5B982103883
	for <alsa-devel@alsa-project.org>;
	Mon,  6 Aug 2007 12:41:09 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1186223690.3246.11.camel@localhost.localdomain>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Damon Chaplin <damon@karuna.eclipse.co.uk>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Damon Chaplin wrote:
> I have a CME UF5 MIDI keyboard (USB), which mostly works fine with ALSA.
> 
> However if I move the Master Volume slider I stop getting MIDI events -
> I have to disconnect the snd_seq port and reconnect it to get MIDI
> events working again.

Is there any error message in the system log when this happens?

> Also, I wanted to try the rawmidi test app, but what would the device ID
> be?

Have a look at the output of "amidi -l".


Regards,
Clemens
