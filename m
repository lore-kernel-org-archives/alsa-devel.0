From: Colin Guthrie <gmane@colin.guthr.ie>
Subject: Re: Pulseaudio alsa configure hook
Date: Mon, 28 Apr 2008 09:53:05 +0100
Message-ID: <fv439i$3uh$1@ger.gmane.org>
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
>   The attached patch extends the alsa pulse plugin set with a alsa
>   configuration hook. Allowing one to specify some configuration parameters
>   that only come into effect when pulseaudio is running.

I was waiting with baited breath after your chat on IRC as to what your
solution would actually be!

I like it!

I think the overhead at initialisation is probably OK, although I guess
it depends on how an application works - e.g. if it constant opens and
closes alsa connections then does this overhead mount up? If not then
this looks like a good solution.

That said Lennart has said in the past that he didn't like the idea of
Alsa  automatically falling back to h/w access if pulse isn't
responding. (this was in reference to tweaking the alsa plugin itself,
rather than this approach which is slightly different conceptually,
albeit with the same end goal). I think his comment at the time was "it
masks configuration problems".

Do you have any thoughts on this Lennart?

Col
