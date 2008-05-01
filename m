From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: Pulseaudio alsa configure hook
Date: Thu, 01 May 2008 14:58:22 +0100
Message-ID: <fvci9u$2l7$1@ger.gmane.org>
References: <20080427203709.GA13496@spring.luon.net>
Reply-To: General PulseAudio Discussion <pulseaudio-discuss@mail.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <pulseaudio-discuss-bounces@mail.0pointer.de>
In-Reply-To: <20080427203709.GA13496@spring.luon.net>
List-Unsubscribe: <https://tango.0pointer.de/mailman/listinfo/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@mail.0pointer.de?subject=unsubscribe>
List-Archive: <https://tango.0pointer.de/pipermail/pulseaudio-discuss>
List-Post: <mailto:pulseaudio-discuss@mail.0pointer.de>
List-Help: <mailto:pulseaudio-discuss-request@mail.0pointer.de?subject=help>
List-Subscribe: <https://tango.0pointer.de/mailman/listinfo/pulseaudio-discuss>,
	<mailto:pulseaudio-discuss-request@mail.0pointer.de?subject=subscribe>
Sender: pulseaudio-discuss-bounces@mail.0pointer.de
Errors-To: pulseaudio-discuss-bounces@mail.0pointer.de
To: pulseaudio-discuss@mail.0pointer.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Sjoerd Simons wrote:
> Hi,
> 
>   The attached patch extends the alsa pulse plugin set with a alsa
>   configuration hook. Allowing one to specify some configuration parameters
>   that only come into effect when pulseaudio is running.
> 
>   For example a configution file like:
> 
>     @hooks [ {
>        func on_pulse_is_running
>          pcm.!default { type pulse }
>          ctl.!default { type pulse }
>        }
>    ]

Just a quick question as I've not had a chance to try this out yet!

Does your code consider pulse as unavailable if it's suspended?

e.g. by running:

$ pasuspender <annoying application that uses alsa in a weird way>

Would the hook still try and push alsa sound via pulse?


It would rock if it didn't but I suspect it will :)

Col
