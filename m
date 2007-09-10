From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: Pausing an audio stream during playback using
 mixer control interface
Date: Mon, 10 Sep 2007 17:04:19 +0200
Message-ID: <1189436659.17442.1209841383@webmail.messagingengine.com>
References: <61445c750709100519v83f6e92w76d023f0a4c34681@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id BE8E610386E
	for <alsa-devel@alsa-project.org>;
	Mon, 10 Sep 2007 17:04:19 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <61445c750709100519v83f6e92w76d023f0a4c34681@mail.gmail.com>
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
> I know that, SNDRV_PCM_TRIGGER_PAUSE_PUSH can be used in trigger callback to
> pause the stream, but I want to give a mixer interface to do the same.

Why?

> As per my understanding this is not possible keeping in mind the current
> framework,

Indeed.  Only one application controls the state of the stream.  When a
stream stops without being commanded to do it, it is considered an error
and the driver must go to the XRUN state.


Regards,
Clemens
