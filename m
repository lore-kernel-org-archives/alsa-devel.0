From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: snd_pcm_wait strangeness when resampling
Date: Fri, 12 Mar 2004 15:26:00 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <yw1xekry3zwn.fsf@kth.se>
References: <yw1xd67jnhbl.fsf@kth.se>
	<Pine.LNX.4.58.0403121003450.2696@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0403121003450.2696@pnote.perex-int.cz> (Jaroslav
 Kysela's message of "Fri, 12 Mar 2004 10:04:46 +0100 (CET)")
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela <perex@suse.cz> writes:

> On Thu, 11 Mar 2004, M?ns Rullg?rd wrote:
>
>> I've noticed some strange things with snd_pcm_wait.  My application
>> opens the sound device in non-blocking mode and uses snd_pcm_wait
>> whenever snd_pcm_writei return EAGAIN.  This works fine as long as
>> ALSA isn't doing any resampling.  However, when resampling (e.g. from
>> 44.1 kHz to 48 kHz) snd_pcm_wait returns immediately, insisting that
>> there is room in the buffer, after which snd_pcm_writei obviously
>> returns EAGAIN once more.  The same thing happens if I use OSS
>> emulation and select() or poll().  Replacing the snd_pcm_wait call
>> with usleep(10000) makes the CPU load look normal again, while the
>> application still works.
>>=20
>> I am using Linux 2.6.4, ALSA driver 1.0.3 and library 1.0.3a with a
>> SIS7012 chip.  It behaves the same way with kernel 2.6.3 and driver
>> 1.0.2c.  I'm not quite sure when it started.
>>=20
>> This application used to work properly.  Has something changed so I
>> need to modify my application?
>
> Could you give me your code to analyze the problem?

I've noticed that it works properly using alsa-lib 1.0.0rc2.  That's
what I happened to have compiled, it might work with later versions
too.

Did you manage to build the thing yet?

--=20
M=E5ns Rullg=E5rd
mru@kth.se


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
