From: thomas schorpp <thomas.schorpp@googlemail.com>
Subject: Re: Pls don't require exclusive Alsa audio device
 access, use snd_pcm_dmix_open ()
Date: Wed, 28 Nov 2007 10:06:18 +0100
Message-ID: <474D2F8A.9090001@googlemail.com>
References: <471FE2A7.9080309@googlemail.com> <47201223.5050304@googlemail.com>
Reply-To: thomas.schorpp@googlemail.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.186])
	by alsa0.perex.cz (Postfix) with ESMTP id 2B78524791
	for <alsa-devel@alsa-project.org>; Wed, 28 Nov 2007 10:06:22 +0100 (CET)
Received: by nf-out-0910.google.com with SMTP id b21so1157698nfd
	for <alsa-devel@alsa-project.org>; Wed, 28 Nov 2007 01:06:21 -0800 (PST)
In-Reply-To: <47201223.5050304@googlemail.com>
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
Cc: Ekiga-devel-list@gnome.org
List-Id: alsa-devel@alsa-project.org

thomas schorpp wrote:
> thomas schorpp wrote:
>> since dmix is enabled by libasound2 by default for cards not 
>> supporting h/w mixing.
>>
>> skype can access the audio device using snd_pcm_dmix_open () if other 
>> app has already opened it, ekiga throws error msgboxes.

skype      5089   skype  mem    CHR 116,24       7792 /dev/snd/pcmC0D0c
skype      5089   skype  mem    CHR 116,16       7784 /dev/snd/pcmC0D0p
kio_file   5422 schorpp    0r   CHR    1,3        956 /dev/null
kio_uiser  6025 schorpp    0r   CHR    1,3        956 /dev/null
iceape-bi 30161 schorpp  mem    CHR 116,16       7784 /dev/snd/pcmC0D0p
iceape-bi 30161 schorpp    0r   CHR    1,3        956 /dev/null
iceape-bi 30161 schorpp   66r   CHR 116,33       7473 /dev/snd/timer
iceape-bi 30161 schorpp   67u   CHR 116,16       7784 /dev/snd/pcmC0D0p

>>
>> y
>> tom
>>
> 
> hmm. takeback. future removal warning in alsa lib doc. well for 
> experiments (in ptlib plugin):
> 
> Index: sound_alsa.cxx
> ===================================================================
> --- sound_alsa.cxx      (Revision 18763)
> +++ sound_alsa.cxx      (Arbeitskopie)
> @@ -344,13 +344,15 @@
>     }
>   }
> 
> -  if (snd_pcm_open (&os_handle, real_device_name, stream, 
> SND_PCM_NONBLOCK) < 0) {
> +  if (snd_pcm_open (&os_handle, real_device_name, stream, 
> SND_PCM_NONBLOCK) < 0)
> 
> -    PTRACE (1, "ALSA\tOpen Failed");
> -    return FALSE;
> -  }
> -  else
> -    snd_pcm_nonblock (os_handle, 0);
> +    if (_snd_pcm_dmix_open (&os_handle, real_device_name, snd_config_t* 
> root, snd_config_t* sconf, stream, SND_PCM_NONBLOCK) < 0) {
> +
> +      PTRACE (1, "ALSA\tOpen Failed");
> +      return FALSE;
> +    }
> +    else
> +      snd_pcm_nonblock (os_handle, 0);
> 
>   /* save internal parameters */
>   device = real_device_name;
> 
> i cant find any sample code for the missing params, google is full of 
> alsa user issues ;)
> 
> y
> tom
> 

@alsa devs
any hints?
