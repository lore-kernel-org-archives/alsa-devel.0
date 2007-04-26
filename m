From: =?iso-8859-1?q?Fl=E1vio=20Yuiti?= <f_yuiti@yahoo.com.br>
Subject: How to play a pcm file
Date: Wed, 25 Apr 2007 21:51:14 -0300 (ART)
Message-ID: <778314.78890.qm@web32215.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from web32215.mail.mud.yahoo.com (web32215.mail.mud.yahoo.com
	[68.142.207.146]) by alsa0.perex.cz (Postfix) with SMTP id 98B9324A19
	for <alsa-devel@alsa-project.org>;
	Thu, 26 Apr 2007 02:51:15 +0200 (CEST)
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

Greetings,
   =

  I'm a new user of alsa api and I need to play pcm, adpcm and wav files us=
ing Alsa api. My code is below. I did a test with pcm file and the sound is=
 playing very fast, the properties of the pcm file are 128kbps, 16 bits lit=
tle endian, 1 channel, 8 khz, but I don't know how to set correctly the par=
ameters in api. Please help me with this problem. Point me my errors.
   =

  Thanks,
   =

  Flavio
   =

  int Sound::PlayFile(char *pszFileName, ULONG initialPoint, UINT qtdTimesT=
oPlay, BOOL mix)
  {
  int dir;
  int result;
  int size;
  unsigned int val;
  snd_pcm_hw_params_t *params;
  snd_pcm_uframes_t frames;
  char* buffer;
  long tamanhoBuffer;
  FILE* file;
  int bytesLidos;
   =

  // Open PCM device for playback.
  if((result =3D snd_pcm_open(&handleSound,"hw:0,0",SND_PCM_STREAM_PLAYBACK=
,0)) < 0)
  {
  fprintf(stderr,"\nUnable to open pcm device: %s",snd_strerror(result));
  exit(1);
  }
  =

  // Allocate a hardware parameters object.
  snd_pcm_hw_params_alloca(&hardwareParam);
  // Fill it in with default values.
  snd_pcm_hw_params_any(handleSound,hardwareParam);
  // Set the desired hardware parameters.
  // Interleaved mode.
  snd_pcm_hw_params_set_access(handleSound,hardwareParam,SND_PCM_ACCESS_RW_=
INTERLEAVED);
  // Signed 16-bit little-endian format.
  snd_pcm_hw_params_set_format(handleSound,hardwareParam,SND_PCM_FORMAT_S16=
_LE);
  // Two channels (stereo), one channel mono.
  snd_pcm_hw_params_set_channels(handleSound,hardwareParam,1);
  // Set rate.
  //snd_pcm_hw_params_set_rate(handleSound,hardwareParam,8000,0);
  // Set period size to 16384 frames.
  //snd_pcm_hw_params_set_period_size(handleSound,hardwareParam,16384,0);
  // Write the parameters to the driver.
  if((result =3D snd_pcm_hw_params(handleSound,hardwareParam)) < 0)
  {
  fprintf(stderr,"\nUnable to set hw parameters: %s",snd_strerror(result));
  exit(1);
  }
  =

  tamanhoBuffer =3D 16384;
  if((result =3D snd_pcm_prepare(handleSound)) < 0)
  {
  fprintf(stderr,"Cannot prepare audio interface for use: %s\n",snd_strerro=
r(result));
  exit(1);
  }
  file =3D fopen(pszFileName,"rb");
  buffer =3D (char *)malloc(tamanhoBuffer);
  while((bytesLidos =3D fread(buffer,1,tamanhoBuffer,file)) > 0)
  {
  if((result =3D snd_pcm_writei(handleSound,buffer,tamanhoBuffer)) !=3D tam=
anhoBuffer)
  {
  fprintf(stderr,"Write to audio interface failed: %s\n",snd_strerror(resul=
t));
  exit(1);
  }
  }
  =

  snd_pcm_drain(handleSound);
  snd_pcm_close(handleSound);
  free(buffer);
  fclose(file);
  =

  =

  return OK;
  }

 __________________________________________________
Fale com seus amigos  de gra=E7a com o novo Yahoo! Messenger =

http://br.messenger.yahoo.com/ =
