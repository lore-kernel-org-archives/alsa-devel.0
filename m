From: Sandulescu Bogdan <bogdan.sandulescu@yahoo.com>
Subject: Re: Underrun on Jade controller...
Date: Fri, 23 Nov 2012 02:35:46 -0800 (PST)
Message-ID: <1353666946.95213.YahooMailNeo@web120406.mail.ne1.yahoo.com>
References: <1353665116.15462.YahooMailNeo@web120405.mail.ne1.yahoo.com>
 <50AF4B3E.9050003@gmail.com>
Reply-To: Sandulescu Bogdan <bogdan.sandulescu@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nm2-vm2.bullet.mail.ne1.yahoo.com
 (nm2-vm2.bullet.mail.ne1.yahoo.com [98.138.91.18])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D131261741
 for <alsa-devel@alsa-project.org>; Fri, 23 Nov 2012 11:35:48 +0100 (CET)
In-Reply-To: <50AF4B3E.9050003@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <zonque@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org


Daniel Mack <zonque <at> gmail.com> writes:
> =

> Without providing any code, I guess nobody on this list will be able to
> help you.
> =

> Daniel
> =



OK. Here is the essential part of my code - settings and write to ALSA:

PlayThread()
{
...

=A0=A0 =A0/********************************* SET PARAMS ******************/=
=A0=A0 =A0
=A0=A0 =A0/* Set HW Parameters, based on .wav header settings */
=A0=A0 =A0=A0=A0=A0 ...
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* APLAY settings */
=A0=A0=A0=A0=A0=A0=A0=A0 if (buffer_time =3D=3D 0 && buffer_frames =3D=3D 0)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 iCheckErrorState =3D
snd_pcm_hw_params_get_buffer_time_max(pcmHwParameterCfg, &buffer_time, 0);
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (iCheckErrorState < 0)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 iStatus =3D -1; /* set erroneous=
 state */
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (buffer_time > 500000)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 buffer_time =3D 500000;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
=A0=A0=A0=A0=A0=A0=A0=A0 if (period_time =3D=3D 0 && period_frames =3D=3D 0)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (buffer_time > 0)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 period_time =3D buffer_time / 4;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 else
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 period_frames =3D buffer_frames =
/ 4;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
=A0=A0=A0=A0=A0=A0=A0=A0 if (period_time > 0)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 {
=A0=A0=A0=A0=A0 =A0=A0=A0 =A0=A0=A0=A0 period_time =3D 500000;=A0=A0 =A0/* =
restrict /smaller period time */
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 iCheckErrorState =3D
snd_pcm_hw_params_set_period_time_near(pPcmPlayHandle, pcmHwParameterCfg,
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 &period_time, 0);
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
=A0=A0=A0=A0=A0=A0=A0=A0 else
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 iCheckErrorState =3D
snd_pcm_hw_params_set_period_size_near(pPcmPlayHandle, pcmHwParameterCfg,
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 &period_frames, 0);
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
=A0=A0=A0=A0=A0=A0=A0=A0 if (iCheckErrorState < 0)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 iStatus =3D -1; /* set erroneous state */
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
=A0=A0=A0=A0=A0=A0=A0=A0 if (buffer_time > 0)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 iCheckErrorState =3D
snd_pcm_hw_params_set_buffer_time_near(pPcmPlayHandle, pcmHwParameterCfg,
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 &buffer_time, 0);
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
=A0=A0=A0=A0=A0=A0=A0=A0 else
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 iCheckErrorState =3D
snd_pcm_hw_params_set_buffer_size_near(pPcmPlayHandle, pcmHwParameterCfg,
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0 &buffer_frames);
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
=A0=A0=A0=A0=A0=A0=A0=A0 if (iCheckErrorState < 0)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 iStatus =3D -1; /* set erroneous state */
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }

=A0=A0=A0=A0=A0=A0=A0=A0 iCheckErrorState =3D snd_pcm_hw_params(pPcmPlayHan=
dle, pcmHwParameterCfg);
=A0=A0=A0=A0=A0=A0=A0=A0 if (iCheckErrorState !=3D 0)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 iStatus =3D -1;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
=A0=A0=A0=A0=A0=A0=A0=A0 snd_pcm_hw_params_get_period_size(pcmHwParameterCf=
g, &pcmPeriodSize, 0);
=A0=A0=A0=A0=A0=A0=A0=A0 snd_pcm_hw_params_get_buffer_size(pcmHwParameterCf=
g, &pcmBufferSize);

=A0=A0=A0=A0=A0=A0=A0=A0 fprintf(stderr,"Period size =3D %lu ; Buffer size =
=3D %lu \n",
pcmPeriodSize, pcmBufferSize);

=A0=A0=A0=A0=A0=A0=A0=A0 if (pcmPeriodSize =3D=3D pcmBufferSize)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fprintf(stderr,"Can't use period equal to=
 buffer size (%lu =3D=3D %lu)",
pcmPeriodSize, pcmBufferSize);
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }

=A0=A0=A0=A0=A0=A0=A0=A0 snd_pcm_sw_params_current(pPcmPlayHandle, pcmSWPar=
ameterCfg);
=A0=A0=A0=A0=A0=A0=A0=A0 if (avail_min < 0)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 n =3D pcmPeriodSize;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
=A0=A0=A0=A0=A0=A0=A0=A0 else
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 n =3D (double) rate * avail_min / 1000000;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
=A0=A0=A0=A0=A0=A0=A0=A0 iCheckErrorState =3D snd_pcm_sw_params_set_avail_m=
in(pPcmPlayHandle,
pcmSWParameterCfg, n);
=A0=A0=A0=A0=A0=A0=A0 =A0
=A0=A0=A0=A0=A0=A0=A0=A0 /* round up to closest transfer boundary */
=A0=A0=A0=A0=A0=A0=A0=A0 n =3D pcmBufferSize;
=A0=A0=A0=A0=A0=A0=A0=A0 if (start_delay <=3D 0)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 start_threshold =3D n + (double) rate * s=
tart_delay / 1000000;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
=A0=A0=A0=A0=A0=A0=A0=A0 else
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 start_threshold =3D (double) rate * start=
_delay / 1000000;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
=A0=A0=A0=A0=A0=A0=A0=A0 if (start_threshold < 1)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 start_threshold =3D 1;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
=A0=A0=A0=A0=A0=A0=A0=A0 if (start_threshold > n)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 start_threshold =3D n;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }

=A0=A0=A0=A0=A0=A0=A0=A0 iCheckErrorState =3D
snd_pcm_sw_params_set_start_threshold(pPcmPlayHandle, pcmSWParameterCfg,
start_threshold);
=A0=A0=A0=A0=A0=A0=A0=A0 if (iCheckErrorState < 0)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 iStatus =3D -1; /* set erroneous state */
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }

=A0=A0=A0=A0=A0=A0=A0=A0 fprintf(stderr,"Start threshold =3D %lu \n",start_=
threshold);

=A0=A0=A0=A0=A0=A0=A0=A0 if (stop_delay <=3D 0)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 stop_threshold =3D pcmBufferSize + (doubl=
e) rate * stop_delay / 1000000;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
=A0=A0=A0=A0=A0=A0=A0=A0 else
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 stop_threshold =3D (double) rate * stop_d=
elay / 1000000;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }

=A0=A0=A0=A0=A0=A0=A0=A0 iCheckErrorState =3D snd_pcm_sw_params_set_stop_th=
reshold(pPcmPlayHandle,
pcmSWParameterCfg, stop_threshold);
=A0=A0=A0=A0=A0=A0=A0=A0 if (iCheckErrorState < 0)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 iStatus =3D -1; /* set erroneous state */
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }

=A0=A0=A0=A0=A0=A0=A0=A0 if (snd_pcm_sw_params(pPcmPlayHandle, pcmSWParamet=
erCfg) < 0)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fprintf(stderr,"Unable to install sw para=
meters, exit thread \n");
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 iStatus =3D -1; /* set erroneous state */
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }

=A0=A0=A0=A0=A0=A0=A0=A0 fprintf(stderr,"Play ThreadID [%lu]: after parmas =
ended\n",
pthread_self());
=A0=A0 =A0 /* END APLAY settings */
=A0=A0=A0=A0=A0=A0=A0=A0 /*********************************END SET PARAMS *=
*****************/
=A0=A0=A0=A0=A0=A0=A0=A0 /* Check if the Settings were correctly done or no=
t */
=A0=A0=A0=A0=A0=A0=A0=A0 if (iStatus < 0)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fprintf(stderr,"Could not SET correctly t=
he wav settings! \n");
=A0=A0 =A0=A0=A0 =A0/* ... do something */
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
=A0=A0=A0=A0=A0=A0=A0=A0 else
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* Finished operation with Settings, cont=
inue processing */
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /*Now we've set up our dev=
ice, but we still can't write to it.
There's one last step we have to take: prepare the device */
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 snd_pcm_prepare (pPcmPlayH=
andle);
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* NOTE: cannot use to mal=
loc the entire wav file size, as this
leads to: frequent overrun (more data in output buffer),
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 * and the User-Space ap=
p runtime memory is increased with wav
file size; Hence, is better to use the ALSA pcm buffer sizes. */

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 iBufferSize =3D pcmBufferSize;

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 TimeStamp("Play ThreadID [%lu]: before ma=
lloc\n", pthread_self());
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fprintf(stderr,"About to allocate %u buff=
er...\n", iBufferSize);

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pu8WavDataBuf =3D (uint8*) malloc( (size_=
t) iBufferSize);
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (pu8WavDataBuf !=3D NULL)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* Data allocation succ=
essful continue with play... */
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fprintf(stderr,"Done allocating =
the buffer, start execute ALSA
play sequence...\n");

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 size_t offset =3D 0;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 int remaining =3D WavSoundSize;

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Wavfp =3D fopen(WavPathAndName, =
"r");
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (Wavfp !=3D NULL)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* Wav FILE opened OK, =
continue reading the data and send it
to ALSA driver */
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 TimeStamp("Play ThreadI=
D [%lu]: before reading/writing\n",
pthread_self());
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 while (remaining > 0)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* RE=
AD DATA into local buffer */
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* Firstly, re=
ad a block of data into buffer */
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /********* REA=
D DATA ********/
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* Normal read=
 from wav file, with a complete a buffer size */
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 iStat=
us =3D fread(pu8WavDataBuf, sizeof(uint8),
iBufferSize , Wavfp);
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /********** EN=
D READ DATA ****************/

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* Secondly, o=
utput that buffer to ALSA driver */
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 iStatus =3D sn=
d_pcm_writei(pPcmPlayHandle, pu8WavDataBuf,
iBufferSize / (stHWSettings.format * stHWSettings.channels) );
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (iStatus =
=3D=3D -EAGAIN || (iStatus >=3D 0 && (
(size_t)iStatus < iBufferSize / (stHWSettings.format * stHWSettings.channel=
s)=A0 ) ))
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* Th=
e ALSA ring buffer is full, wait some small time to
flush parts of data, so we can fill it with rest of .wav data */
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fprin=
tf(stderr,"The ALSA ring buffer is full, wait some
small time to flush parts of data \n");
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 snd_p=
cm_wait(pPcmPlayHandle, 10);
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 else
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (i=
Status =3D=3D -EPIPE)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 /* In some cases, it might happen that this thread
does not feed new samples in time to alsa-lib (due to high CPU usage - thre=
ad
interrupted often -
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 * or large delay between consecutive writei()
calls). Therefore, we must prepare/recover the PCM handle for next usage.
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 */

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0=A0=
=A0 =A0/* Print delay time */
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0=A0=
=A0 =A0snd_pcm_status_t *status;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0=A0=
=A0 =A0snd_pcm_status_alloca(&status);
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0=A0=
=A0 =A0if ((snd_pcm_status(pPcmPlayHandle, status))<0) {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0=A0=
=A0 =A0=A0=A0 =A0fprintf(stderr, "some error \n");
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0=A0=
=A0 =A0}
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =
=A0struct timespec now, diff, tstamp;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =
=A0clock_gettime(CLOCK_MONOTONIC, &now);
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =
=A0snd_pcm_status_get_trigger_htstamp(status, &tstamp);
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =
=A0timermsub(&now, &tstamp, &diff);
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =
=A0fprintf(stderr,"underrun!!! (at least %.3f ms long)\n",
diff.tv_sec * 1000 + diff.tv_nsec / 10000000.0);

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 fprintf(stderr,"Underrun encountered: application
didn't sent enough data to the ALSA buffer, status =3D %d \n", iStatus);
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 iStatus =3D snd_pcm_recover(pPcmPlayHandle,iStatus,0 );
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 }
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 else
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 if (iStatus =3D=3D -ESTRPIPE)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 {
=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0/* ignore it */
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 }
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 else
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 if (iStatus < 0)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 {
=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0=A0=A0 =A0/* ignore it */
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 }
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 else
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 {
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 /* Write performed OK */
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 }
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0 }
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0 }
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* Use the pcm=
_avail_update() only for checking buffer
playback fill level - not for SYNCHRONISATION */
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 snd_pcm_sframe=
s_t pcmAvailBytes;
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 pcmAvailBytes =
=3D snd_pcm_avail_update(pPcmPlayHandle);
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 offset =3D off=
set +=A0 ( iStatus * (stHWSettings.format *
stHWSettings.channels));
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 remaining =3D =
remaining -=A0 ( iStatus * (stHWSettings.format *
stHWSettings.channels));
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 =A0
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fprintf(std=
err,"Writei() ended, bytes written =3D %d,
available bytes to be written =3D %lu\n", iStatus, pcmAvailBytes);
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }

=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 TimeStamp("Play ThreadI=
D [%lu]: after reading/writing fully
ended\n", pthread_self());
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* Finished reading the=
 wav file, now it's time to close it */
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 fclose(Wavfp);
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /* Done the co=
mplete output, now drain/reset the ALSA device */
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 snd_pcm_nonblo=
ck(pPcmPlayHandle, 0);
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 snd_pcm_drain(=
pPcmPlayHandle);
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 snd_pcm_nonblo=
ck(pPcmPlayHandle, 0);
...
}
