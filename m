From: Metyl Methylius <the.metyl@gmail.com>
Subject: Re: alsa virtual sound card (with networked output)
Date: Tue, 11 Jan 2011 22:11:56 +0100
Message-ID: <AANLkTikxca8CVECtweO6P7KN7zt0Gc2WOS-huyf5G+9K@mail.gmail.com>
References: <AANLkTinXD8u9riu9uwhJPsdKthUHDmK5K1o_+7vv4mcU@mail.gmail.com>
	<alpine.LNX.2.00.1101111726040.28150@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 39C78103826
	for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2011 22:11:58 +0100 (CET)
Received: by ewy19 with SMTP id 19so8856018ewy.38
	for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2011 13:11:56 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1101111726040.28150@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Jan 11, 2011 at 5:33 PM, Jaroslav Kysela <perex@perex.cz> wrote:
> On Tue, 11 Jan 2011, Metyl Methylius wrote:
>
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
> I plan to add network support to the alsaloop utility (in the current
> repository of the alsa-utils package) using the snd-aloop loopback kernel
> module on the playback (producer) side. This solution would be 100%
> transparent for all current ALSA apps. But I don't have any estimate when I
> start the work on this. Any volunteer? I think that it would be best to use
> the RTP UDP streaming.
>

That sounds very interesting. Still there is minor problem with RTP as
I've found in rfc3551 that at least there defined RAW audio encodings - L8
and L16 - supports only 8 and 16-bit wide samples (how to support 24
or 32-bit audio ?).
Which RTP library do you plan to use unless you wanted to integrate
RTP code directly into alsaloop ?

metyl
