From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: Asterisk 1.4.17 and alsa 1.0.19 dmix plugin
 problem.
Date: Tue, 21 Apr 2009 12:39:54 +0200 (CEST)
Message-ID: <alpine.LNX.2.00.0904211238470.4553@eeebox2.perex-int.cz>
References: <359c5480904201122m7a45dbe8hd1f6b597dea57283@mail.gmail.com>
	<alpine.LNX.2.00.0904202039160.4553@eeebox2.perex-int.cz>
	<359c5480904210335o25d636a4i14b7fe5f7391c839@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-2026226475-1240310394=:4553"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id BEC952463B
	for <alsa-devel@alsa-project.org>;
	Tue, 21 Apr 2009 12:39:54 +0200 (CEST)
In-Reply-To: <359c5480904210335o25d636a4i14b7fe5f7391c839@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Nicola Mfb <nicola.mfb@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-2026226475-1240310394=:4553
Content-Type: TEXT/PLAIN; charset=UTF-8; format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Tue, 21 Apr 2009, Nicola Mfb wrote:

> 2009/4/20 Jaroslav Kysela <perex@perex.cz>:
>> On Mon, 20 Apr 2009, Nicola Mfb wrote:
> [...]
>> Asterisk does not use snd_pcm_poll_descriptors_revents to translate even=
ts
>> returned from poll to correct poll event. Also, only file descriptor num=
ber
>> from snd_pcm_poll_descriptors() - asterisk should handle correctly retur=
ned
>> poll events as well.
>>
>> See chan_alsa.c - readdev / writedev variables and sound_thread().
>>
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Jarosl=
av
>
> Hi Jaroslav!
> thanks for quick reply and hints!
> I finally understand the inverted POLLIN/POLLOUT in dmix. As a quick
> check I added writedev to fds set and it worked, now I'll able to
> write a patch using poll and demangling revents...
> First level documentation on www.alsa-project.org says that you may
> use select or poll as you need, should be this corrected?

Could you point me where is documentation unclear exactly?

 =09=09=09=09=09Thanks,
 =09=09=09=09=09=09Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.

--8323584-2026226475-1240310394=:4553
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--8323584-2026226475-1240310394=:4553--
