From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: a bug? (was: hw/plughw strange behaviour)
Date: Mon, 14 Jun 2004 16:26:33 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0406141617570.14592-100000@studcom.urz.uni-halle.de>
References: <200406132333.23830.cpitaar@yahoo.com.ar>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <200406132333.23830.cpitaar@yahoo.com.ar>
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
> Playing a little with the code that produced the strange behaviour I
> reported in my previous posts in this thread I discovered this potential bug
> (in my code or in alsalib?, that's the question):
>
> 1) In alsa/pcm.h, snd_pcm_hw_params_set_rate_near is declared as:
>
> int snd_pcm_hw_params_set_rate_near(snd_pcm_t *pcm,
>     				    snd_pcm_hw_params_t *params,
> 				    unsigned int *val,
> 				    int *dir);
>
> (Here I'm not sure if dir is an output, an input or an inout param.

Both.

>   c) dir is an int = 1:
>      snd_pcm_hw_params_set_rate_near(handle, hwparams, &rate, &dir);
>
> 3) But when handle corresponds to the "plughw:0,0" device the third
> invocation fails (well, to be precise, it doesn't fail until
> snd_pcm_hw_params is called -see my previous posts in this thread-).

Please add a call to snd_pcm_hw_params_dump() before
snd_pcm_hw_params().  What is the difference between the configuration
that fails and the others?

> 4) I've attached an example test to this post

It seems the call to set_buffer_size is missing.

And it reuses the dir value returned by set_rate_near for the
set_period_time_near call.


Regards,
Clemens




-------------------------------------------------------
This SF.Net email is sponsored by the new InstallShield X.
>From Windows to Linux, servers to mobile, InstallShield X is the
one installation-authoring solution that does it all. Learn more and
evaluate today! http://www.installshield.com/Dev2Dev/0504
