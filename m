From: =?iso-8859-1?q?Fl=E1vio=20Yuiti?= <f_yuiti@yahoo.com.br>
Subject: Re: How to play a pcm file
Date: Thu, 26 Apr 2007 13:26:34 -0300 (ART)
Message-ID: <970914.35013.qm@web32205.mail.mud.yahoo.com>
References: <1177569394.26330.1186645873@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web32205.mail.mud.yahoo.com (web32205.mail.mud.yahoo.com
	[68.142.207.136]) by alsa0.perex.cz (Postfix) with SMTP id A5EE724A89
	for <alsa-devel@alsa-project.org>;
	Thu, 26 Apr 2007 18:26:41 +0200 (CEST)
In-Reply-To: <1177569394.26330.1186645873@webmail.messagingengine.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Clemens,
   =

  thanks for your help. Can you explain what function of alsa api I insert =
128kbps value of pcm file? In my example, I'm reading the content of pcm fi=
le and writing directly on sound device, however I don't know the length of=
 buffer that I send to sound device. Can be any length of buffer?
   =

  Thanks,
   =

  Flavio
   =

  =

Clemens Ladisch <cladisch@fastmail.net> escreveu:
  Fl=E1vio Yuiti wrote:
> I did a test with pcm file and the sound is playing very fast,
> =

> snd_pcm_open(&handleSound,"hw:0,0",SND_PCM_STREAM_PLAYBACK,0)

Use "default" as device name. Using "hw" will prevent any automatic
sample format/rate conversions.

> //snd_pcm_hw_params_set_rate(handleSound,hardwareParam,8000,0);

This shouldn't be commented out, and you should check the return
values of all these functions.


HTH
Clemens


 __________________________________________________
Fale com seus amigos  de gra=E7a com o novo Yahoo! Messenger =

http://br.messenger.yahoo.com/ =
