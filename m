From: Sedji Gaouaou <sedji.gaouaou@atmel.com>
Subject: Re: Recording problem with ALSA: trying to set up some
 constraints
Date: Fri, 23 May 2008 16:27:19 +0200
Message-ID: <4836D447.5030903@atmel.com>
References: <48353DEE.1020502@atmel.com> <48355305.1090808@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from atmel-es2.atmel.fr (mail.atmel.fr [81.80.104.162])
	by alsa0.perex.cz (Postfix) with ESMTP id D1CB42466C
	for <alsa-devel@alsa-project.org>;
	Fri, 23 May 2008 16:27:26 +0200 (CEST)
In-Reply-To: <48355305.1090808@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch a =E9crit :
> Sedji Gaouaou wrote:
>> I have a problem with my recording driver.
>> I have set up a pcm_hardware structure in which I define the format
>> supported by my hardware:
>> ...
>>     .formats        =3D (SNDRV_PCM_FMTBIT_S16_LE
>>                    | SNDRV_PCM_FMTBIT_S16_BE
>>                    | SNDRV_PCM_FMTBIT_S20_3LE
>>                    ...
>>
>> Then in my open function I pass it to the runtime struct.
>>
>> Nevertheless if  I try to run arecord with this option: arecord -d 1
>> test.wav, I will have a kernel oops.
>> The default format is U8, but it is not supported by my Hardware, abd it
>> is not defined in my structure, so I though that it should exit arecord
>> but not crash.
> =

> The default device will do automatic sample format conversion, i.e.,
> your driver will see a request for S16_LE.
> =

> This looks like a bug somewhere else in your driver.
> =

> =

> Regards,
> Clemens
> =

That means that if the format is no supported, it should not return an =

error, but just use another format which is supported?
