From: Simon Tremblay <bidou@videotron.qc.ca>
Subject: Re: alsa-lib, dmix, and snd_pcm_open_conf function
Date: Thu, 04 Sep 2008 20:27:14 -0400
Message-ID: <48C07CE2.2020903@videotron.qc.ca>
References: <loom.20080901T165414-425@post.gmane.org>
	<Pine.LNX.4.61.0809020749470.9153@tm8103.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from randymail-a11.g.dreamhost.com
	(balanced.mail.policyd.dreamhost.com [208.97.132.119])
	by alsa0.perex.cz (Postfix) with ESMTP id 3808024539
	for <alsa-devel@alsa-project.org>;
	Fri,  5 Sep 2008 02:27:41 +0200 (CEST)
Received: from [192.168.0.108] (unknown [64.235.203.225])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by randymail-a11.g.dreamhost.com (Postfix) with ESMTP id C3422109E89
	for <alsa-devel@alsa-project.org>; Thu,  4 Sep 2008 17:27:54 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.61.0809020749470.9153@tm8103.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela a =E9crit :
> On Mon, 1 Sep 2008, Simon Tremblay wrote:
>
>   =

>> Hi, =

>>
>> I have a problem using dmix on my embedded system (manual installation of
>> alsa-lib 1.0.15)
>>
>> When I play a sound with aplay, it works well.
>>
>> When I try -D dmix or -D plug:dmix parameter, it doesn't work. =

>>
>> The output is: =

>>
>> aplay: main:547: audio open error: Operation not permitted
>>     =

>
> strace will help you. I would look to ipc permissions (alsa.conf):
>
> defaults.pcm.ipc_gid audio
> defaults.pcm.ipc_perm 066
Thanks, but I just want to know where I manage that for IPC? I created =

an audio group and my /dev/snd/* files are in this group and have 0660 =

as permissions.

Simon
