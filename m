From: Paul Davis <pbd@Op.Net>
Subject: Re: snd_pcm_hw_params_t definition
Date: Wed, 20 Mar 2002 09:52:57 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200203201453.JAA14178@renoir.op.net>
References: <02032009390400.02305@mdube.usine.8D.com>
In-Reply-To: Your message of "Wed, 20 Mar 2002 09:39:04 EST."
             <02032009390400.02305@mdube.usine.8D.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: mdube@8d.com
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>Hi,
>	Im trying to compile a program that uses alsa lib 0.9 and since by just
> 
>including alsa/asoundlib.h it doesnt give the compiler a valid definition of 
>the snd_pcm_hw_params_t Im wondering what else I have to include for my 
>program to compile.

its an opaque type. you can only declare a pointer to it, then call
the functions to allocate one and release it:
    

snd_pcm_hw_params_t *hw_params;
snd_pcm_sw_params_t *sw_params;

snd_pcm_hw_params_malloc (&hw_params);
snd_pcm_sw_params_malloc (&sw_params);

snd_pcm_hw_params_free (&hw_params);
snd_pcm_sw_params_free (&sw_params);

there are also stack-based alloca functions too, for params objects
that only need exist for a single function scope.

snd_pcm_hw_params_alloca (&hw_params);
snd_pcm_sw_params_alloca (&sw_params);

this design is there to ensure binary compatibility in future versions
of ALSA should the nature of the structs change.

--p

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
