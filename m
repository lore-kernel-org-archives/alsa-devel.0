From: "Thomas Charbonnel" <thomas@undata.org>
Subject: Re: The best-supported Pro Audio device?
Date: Thu, 28 Aug 2003 04:31:00 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <35721.193.253.35.6.1062037860.squirrel@www.undata.org>
References: Your
        message
        of
        "Wed,
        27
        Aug
        2003
        12:36:03
        EDT."
        <200308280008.h7S08OmC025251@oud>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200308280008.h7S08OmC025251@oud>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: paul@linuxaudiosystems.com
Cc: ametts2@mindspring.com, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>>--*-- What is the best-supported *Pro Audio* device in terms of solid
>> ALSA dri ver support?  Not interested in Sound Blasters and chips on
>> the motherboard --
>> something along the lines of the Echo, M-Audio, or RME products.  But
>> the ALS
>>A drivers need to be stable -- and need to fully support the
>> capabilities of h e respective device (i.e., on-board DSP, MIDI, or
>> whatever).
>
> the echo drivers are extremely new, and largely untested at this
> point. they may even be incomplete.
>
> the m-audio drivers are probably the oldest, and have been widely
> tested. i don't know how well they support the latest incarnations of
> the ice17XX chipsets. there is also a good control application for these
> interfaces.
>
> the rme drivers (i was the initial primary author) are stable and
> complete for the original hammerfall series. they have been evolving for
> the hdsp series. slightly older hdsp cards will work well, as do newer
> kernels when used with the pcmcia interfaces (since this tends to
> require up-to-date support for CardBus devices in the kernel as much as
> anything specifically related to the hdsp). as with many
> companies, rme unfortunately does not keep us 100% up to date on what
> they are doing with their interfaces, and so as they change the
> firmware it turns out that we lag behind, typically by a few
> weeks. thomas charbonnel has done some fantastic work implementing
> totalmix for linux, and so the only "hole" at the moment for these cards
> appears to involve some issues with MIDI performance (and
> firmware lags)
>

What makes you think we have midi performance issues ? One long lasting
midi bug was found and corrected by Marcus Andersson and Jaroslav while
you were away in July. As far as I know, there is no other midi problem at
the moment, please correct me if I'm wrong.

Thomas





-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
