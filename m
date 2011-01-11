From: Metyl Methylius <the.metyl@gmail.com>
Subject: Re: alsa virtual sound card (with networked output)
Date: Tue, 11 Jan 2011 17:50:01 +0100
Message-ID: <AANLkTikgf_0oky3LRr=uNeqJKUMbgjv=pbcmbKrhBqyF@mail.gmail.com>
References: <AANLkTinXD8u9riu9uwhJPsdKthUHDmK5K1o_+7vv4mcU@mail.gmail.com>
	<ightce$qr6$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 3B0F3103827
	for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2011 17:50:02 +0100 (CET)
Received: by ewy19 with SMTP id 19so8689071ewy.38
	for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2011 08:50:02 -0800 (PST)
In-Reply-To: <ightce$qr6$1@dough.gmane.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Colin Guthrie <gmane@colin.guthr.ie>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The main reason I can't use pulseaudio it's because it won't even
compile on the embedded platform i'm running (openwrt). Also
pulseaudio it's overcomplicated for such a straightforward task. I was
hoping that a simpler solution would exist.

Metyl

On Tue, Jan 11, 2011 at 4:35 PM, Colin Guthrie <gmane@colin.guthr.ie> wrote:
> 'Twas brillig, and Metyl Methylius at 11/01/11 14:51 did gyre and gimble:
>> Hello everyone,
>>
>> I was wondering if its possible to just create a "virtual" sound card
>> using alsa which will just sent its audio stream to other computer
>> (using TCP/IP or UDP for example). On the other end there would be
>> some kind of server (or just nc -u -l -p 31337 | aplay ). I want to do
>> it on alsa layer because other aps using alsa will get immediate
>> support.
>>
>> It should be something like described in
>>
>> http://alsa.opensrc.org/index.php/Network
>>
>> but with transparent support for all alsa based applications. I dont
>> care about syncronization or transmission delay. Any pointers as how
>> this could be done in alsa ?
>
> Any particular reason you cannot use PulseAudio? It support usage from
> existing ALSA apps and also works automatically with SSH by
> piggy-backing connection settings on X11 root windows which are
> accessable when the remote connection has X11 forwarding enabled.
>
>> This mess was sent using 100% recycled electrons. If you want to get
>> rid of this mess just turn off your computer,
>
> :)
>
> --
>
> Colin Guthrie
> gmane(at)colin.guthr.ie
> http://colin.guthr.ie/
>
> Day Job:
> =A0Tribalogic Limited [http://www.tribalogic.net/]
> Open Source:
> =A0Mageia Contributor [http://www.mageia.org/]
> =A0PulseAudio Hacker [http://www.pulseaudio.org/]
> =A0Trac Hacker [http://trac.edgewall.org/]
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>



-- =

This mess was sent using 100% recycled electrons. If you want to get
rid of this mess just turn off your computer,
