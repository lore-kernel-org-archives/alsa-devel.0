From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: hw/plughw strange behaviour
Date: Thu, 10 Jun 2004 18:57:58 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0406101857110.3148-100000@studcom.urz.uni-halle.de>
References: <200406100219.58760.cpitaar@yahoo.com.ar>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <200406100219.58760.cpitaar@yahoo.com.ar>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Carlos Pita <cpitaar@yahoo.com.ar>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Carlos Pita wrote:
> I have a problem using the plughw device with slave the hw:0,0 device: a pcm
> in an AWE 64 Gold. When invoking snd_pcm_hw_params on plughw:0,0 I get an
> 'Invalid argument' error (-22). However, running the same program directly on
> hw:0,0 works fine.
>
>    snd_pcm_hw_params_set_access(handle, hwparams, SND_PCM_ACCESS_RW_INTERLEAVED);
>    snd_pcm_hw_params_set_format(handle, hwparams, SND_PCM_FORMAT_S16_LE);
>    snd_pcm_hw_params_set_rate_near(handle, hwparams, &rate, &dir);
>    snd_pcm_hw_params_set_channels(handle, hwparams, numchannels);
>    snd_pcm_hw_params_set_periods(handle, hwparams, numperiods, 0);
>    snd_pcm_hw_params_set_buffer_size_near(handle, hwparams, &buffersize);

Does any of these calls return an error?


Regards,
Clemens




-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the
one installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
