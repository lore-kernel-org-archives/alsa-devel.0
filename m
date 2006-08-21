From: "Marc Brooker" <marcbrooker@gmail.com>
Subject: Re: Sample Rate Conversion Quality in ALSA
Date: Mon, 21 Aug 2006 22:16:53 +0200
Message-ID: <b5ee41f40608211316i7d181861xcd0f7def0e0a4fe9@mail.gmail.com>
References: <b5ee41f40608210316t562c803eye73701c75904627@mail.gmail.com>
	<44E9AAFA.2060400@superbug.co.uk>
	<b5ee41f40608210602q4c4ae45eo5be8392be7e96099@mail.gmail.com>
	<20060821150338.GA3360@localhost.localdomain>
	<b5ee41f40608211207o165b7e20qb40625ad17065d18@mail.gmail.com>
	<1156187703.10565.117.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1156187703.10565.117.camel@mindpipe>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Lee Revell <rlrevell@joe-job.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 8/21/06, Lee Revell <rlrevell@joe-job.com> wrote:
> On Mon, 2006-08-21 at 21:07 +0200, Marc Brooker wrote:
> > On a related note, on an Athlon64 3200+ running Ubuntu Dapper for i386
> > with backported alsa-libs 1.0.11 and alsa-plugins 1.0.11 (with
> > samplerate plugin) cpu usage figures (while playing a VBR mp3 using
> > gstreamer):
> > standard ALSA linear: 2%
> > samplerate: 6%
> > samplerate_medium: 9%
> > samplerate_best: 20%
> >
> > >From this it seems that samplerate_best is too costly, but samplerate
> > and samplerate_medium would be usable on most modern hardware.
> >
>
> It would be useful to have the same numbers for the low end of "modern
> hardware", like a 1Ghz fanless Via C3 board, or a Geode - the type of
> thing people use for MythTV boxes and what not.
>
> Lee
>
>

That's fair enough. I know that many people use Linux and ALSA on
lower end hardware which is doing other stuff (like MythTV) where
cycles are short. It's a really difficult problem - one default offers
poor sound quality and one chews CPU cycles.

I have spent some time this evening measuring the performance of the
standard resampler in ALSA versus the libsamplerate plugin.

First, I tested in the built in resampling code. On a 500Hz sine wave,
THD is fairly good (at -71dB) but SINAD (signal to noise and
distortion) is terrible at about 32dB. The picture is worse with 5kHz
sine wave - SNR is 30dB. Finally, on a 16kHz sine wave, SNR is 9dB
with an alias at 20kHz at -20dB and another at 8kHz at -30dB.

With samplerate_best and a 16kHz square wave, SNR is 70dB and the
strongest image is at 8kHz at -90dB. samplerate (fast) and
samplerate_medium performed nearly as well, with a slightly lower
cutoff frequency. The low SNR is probably caused by the recording
hardware. samplerate_order and samplerate_linear do no better than the
built in code.

Tests were performed by playing 44100 material through dmix, through
the Wolfson DAC on my AV710 card, and captured at 48000Hz using
AV710's rather poor line in. Analysis was done with baudline
(www.baudline.com).

I hope developers are not taking my arriving on this list and shouting
my mouth off the wrong way. I really appreciate the work you guys do
(and have done) and would like to contribute.

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
