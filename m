From: Markus Korber <korbse@gmx.at>
Subject: Re: ALSA lib troubles with xine
Date: Mon, 03 Sep 2007 10:12:52 +0200
Message-ID: <6zd4x0f9q3.fsf@odpc25.int.ondemand.co.at>
References: <6zk5r8fdev.fsf@odpc25.int.ondemand.co.at>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 16CC22433C
	for <alsa-devel@alsa-project.org>;
	Mon,  3 Sep 2007 10:12:54 +0200 (CEST)
In-Reply-To: <6zk5r8fdev.fsf@odpc25.int.ondemand.co.at> (Markus Korber's
	message of "Mon, 03 Sep 2007 08:53:12 +0200")
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Thus spake Markus Korber:

> I've got problems using ALSA (hg) and xine-lib (1.1.7).  I'm trying to
> use fbxine for playback but ALSA debug logging gives me:
> [...]
> So buffer and period sizes seem to be wrong and therefore I get no
> sound.  (audio_alsa_out logging from [1].)  Next I've tried to run
> speaker-test and the ouptut look good:

Sorry for the wrong information (Must have taken an older version of
libasound).  I've recompiled alsa-lib 1.0.15rc1 and alsa-utils 1.0.15rc1
and now speaker-test also fails:

,----
| [root@(none) ~]# speaker-test 
| 
| speaker-test 1.0.15rc1
| 
| Playback device is default
| Stream parameters are 48000Hz, S16_LE, 1 channels
| Using 16 octaves of pink noise
| Rate set to 48000Hz (requested 48000Hz)
| Buffer size range from 4096 to 1073748296
| Period size range from 0 to 0
| Using max buffer size 1073748296
| Periods = 4
| was set period_size = 0
| was set buffer_size = 4096
| Unable to set sw params for playback: Invalid argument
| Setting of swparams failed: Invalid argument
`----

Next I'll try to compile alsa-lib with '-O1' instead of '-Os' and then
I'll revert back to 1.0.14a and give that version a try.

lg,
Markus Korber
