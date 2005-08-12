From: Raymond <rayau@netvigator.com>
Subject: Re: Volume per voices [Feature Request]
Date: Fri, 12 Aug 2005 22:57:40 +0800
Message-ID: <42FCB8E4.90702@netvigator.com>
References: <42E889DD.2070808@netvigator.com> <Pine.HPX.4.33n.0507280943050.9785-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.HPX.4.33n.0507280943050.9785-100000@studcom.urz.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: Manuel Jander <manuel.jander@gmail.com>
List-Id: alsa-devel@alsa-project.org

Clemens Ladisch wrote:
> Raymond wrote:
> 
>>In theory, and sound cards with hardware mixing can support this kind of
>>volume control.
>>
>>au88x0 driver may provide this kind of volume control on playing PCM
>>streams by using hardware mixers.
>>
>>However the hardware mixers are dynamically allocated in routine
>>snd_vortex_pcm_hw_params(), this means that the kcontrol can be put/get
>>only between snd_pcm_hw_params() (return no error) and
>>snd_pcm_hw_free()/snd_pcm_close().
> 
> 
> The driver could save the value and apply it when a stream is opened.
> 
>
>>Is there any flag in kcontrol which enable/disable the put/get from
>>mixer application ?
>
>
> Controls can be locked.
>
>

What is the meaning of SNDRV_CTL_ELEM_ACCESS_INACTIVE ?

Is it just a flag which the driver should check whether the value can be
written to the hardware registers ?

It seem to me that snd_vortex_pcm_adb_vol_put() are called even when
kcontrol is inactive (e.g alsactl restore after the driver is loaded)

What value (0 or 1) will be return by snd_vortex_pcm_adb_vol_put() when
kcontrol is inactive/locked ?









-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
