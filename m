From: Arve Knudsen <aknuds-1@broadpark.no>
Subject: Re: Which API to use for simple clients?
Date: Sun, 04 Jan 2004 16:54:38 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <opr09c5cvcq1sf88@mail.broadpark.no>
References: <20040102181512.9272.3@llama.ing-simmons.net>   <opr07br2w0q1sf88@mail.broadpark.no> <20040104120057.9272.13@llama.ing-simmons.net>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040104120057.9272.13@llama.ing-simmons.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Nick Ing-Simmons <nick@ing-simmons.net>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sun, 04 Jan 2004 12:00:57 +0000, Nick Ing-Simmons=20
<nick@ing-simmons.net> wrote:

>> The ALSA implementation of v19 (development
>> branch) is well developed, and fairly stable from what I can see (bein=
g
>> one of the developers). There hasn't been a lot of feedback, but my ow=
n
>> testing hasn't turned up any bugs in a while.
>
> I few clicks but nothing too horrible.
Clicks as in audio glitches? I experience no glitches in daily use=20
(blocking API), unless I set the buffer size too low.

>> PortAudio also offers two
>> different interfaces to the programmer, both blocking and callback
>> interfaces are completed for the ALSA implementation. So you can choos=
e
>> whichever suits your application the best.
>
> patest_write_sine produces a noise but it isn't a sine wave (by ear
> there are some "sharp edges" in the waveform).
>
> patest_sine_formats hangs apparently forever.
Sounds weird. Works perfectly with my setup. Can you tell me which one of=
=20
the underlying host APIs (JACK/OSS/ALSA) is being used? I just tested the=
=20
OSS implementation for the first time, and it behaves as you describe. I=20
cannot help you with OSS or JACK I'm afraid, as I concentrate on the ALSA=
=20
bit. I don't know what the current state of OSS and JACK support is, but =
I=20
don't think they've been as regularly updated as the ALSA one. My=20
recommendation, for now, would be to configure PortAudio to compile with=20
only ALSA support. Then the ALSA host API should be used by default, and=20
things should work better I think.

>> At the same time, should you
>> wish to write cross-platform programs, PortAudio supports different
>> platforms. I don't know the current state of all the implementations,=20
>> but
>> Windows MME and ASIO should be well functional and SGI IRIX seems to b=
e
>> coming along.
>>
>> Hope this helps
>
> If nothing else it serves as example code for oss/alsa/jack setup.
> Will not rule it out.
>

Appreciate the feedback

Arve Knudsen




-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
