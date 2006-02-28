From: "Adrian McMenamin" <adrian@mcmen.demon.co.uk>
Subject: Re: PCM driver only plays tiny portion of clip
Date: Tue, 28 Feb 2006 09:10:53 -0000 (GMT)
Message-ID: <35384.217.150.108.178.1141117853.squirrel@newgolddream.dyndns.info>
References: <44054.217.150.108.178.1141056426.squirrel@newgolddream.dyndns.info>
    <20060227172601.GA446@turing.informatik.uni-halle.de>
    <40613.217.150.108.178.1141061722.squirrel@newgolddream.dyndns.info>
    <20060228073049.GA4158@turing.informatik.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sc-outsmtp1.homechoice.co.uk (sc-outsmtp1.homechoice.co.uk [81.1.65.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id AB6091A8
	for <alsa-devel@alsa-project.org>; Tue, 28 Feb 2006 10:10:55 +0100 (MET)
In-Reply-To: <20060228073049.GA4158@turing.informatik.uni-halle.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 28 February, 2006 7:30 am, Clemens Ladisch wrote:
> Adrian McMenamin wrote:
>> On Mon, 27 February, 2006 5:26 pm, Clemens Ladisch wrote:
>> > ALSA will notice that something has been played when the return valu=
e
>> of
>> > the pointer callback changes.
>>
>> And what happens then? ie what will the alsa subsystem do when that
>> changes (as it certainly will be duting the playback as it cycles
>> through
>> the buffer)
>
> When an interrupt occurs (that is, when it calls
> snd_pcm_period_elapsed()), ALSA calls the pointer callback.  A differen=
t
> return value indicates that there is some free space in the buffer, so
> ALSA wakes up the application so that it can write more data.
>
>

This (application writing more data) doesn't seem to be happening in my c=
ase.

I am using oss emulation and a simple car command ie cat somefile.wav >
/dev/dsp - should I expect this to work, or do I really need to compile
something like sox (does sox use the native alsa if)?



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
