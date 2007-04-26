From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: How to play a pcm file
Date: Thu, 26 Apr 2007 08:36:34 +0200
Message-ID: <1177569394.26330.1186645873@webmail.messagingengine.com>
References: <778314.78890.qm@web32215.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out4.smtp.messagingengine.com (out4.smtp.messagingengine.com
	[66.111.4.28]) by alsa0.perex.cz (Postfix) with ESMTP id C8CB924A46
	for <alsa-devel@alsa-project.org>;
	Thu, 26 Apr 2007 08:36:34 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <778314.78890.qm@web32215.mail.mud.yahoo.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: =?ISO-8859-1?Q?Fl=E1vio=20Yuiti?= <f_yuiti@yahoo.com.br>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Fl=E1vio Yuiti wrote:
> I did a test with pcm file and the sound is playing very fast,
> =

>   snd_pcm_open(&handleSound,"hw:0,0",SND_PCM_STREAM_PLAYBACK,0)

Use "default" as device name.  Using "hw" will prevent any automatic
sample format/rate conversions.

>   //snd_pcm_hw_params_set_rate(handleSound,hardwareParam,8000,0);

This shouldn't be commented out, and you should check the return
values of all these functions.


HTH
Clemens
