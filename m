From: Brian L Scipioni <brian@gaugetheory.org>
Subject: Re: [Alsa-user] file.wav -> dsp issue
Date: Wed, 01 Dec 2004 09:56:52 -0500
Message-ID: <1101913012.13435.37.camel@radium.gaugetheory.org>
References: <20041130180410.D498B187F@teufel.hartford-hwp.com>
	 <1101839935.10162.1.camel@krustophenia.net>
	 <20041130200556.9A346188C@teufel.hartford-hwp.com>
	 <1101848569.10162.25.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary="=-sKgwrRfWUPLQ4O+rZpRE"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1101848569.10162.25.camel@krustophenia.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: "H.Haines Brown" <brownh@hartford-hwp.com>, alsa-user@lists.sourceforge.net, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--=-sKgwrRfWUPLQ4O+rZpRE
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

I have this problem too - but probably others causing it.

aplay -D spdif /usr/share/sounds/startup3.wav works fine.

aplay -D /usr/share/sounds/startup3.wav gives the following error:

ALSA lib pcm.c:1975:(snd_pcm_open_noupdate) Unknown PCM
/usr/share/sounds/startup3.wav
aplay: main:508: audio open error: No such file or directory

cat /usr/share/sounds/startup3.wav > /dev/dsp
makes no sound and hangs for 55 seconds on this 2.5 second sample.

They both worked before I installed 1.0.7.  However, I also installed
the OSS compatibility libs this time.

Also when I run alsaconf now it finds 2 cards even though I only have 1.
emu10k1    Creative ...
legacy       Probe legacy ISA chips

I suspect this second device is the tiny speaker on my motherboard, no? 
Is it getting all the attention?

Except for when I specify spdif on the command line "alsaplayer -d spdif
..." none of my audio apps work.

What gives here?  Anybody know?  Everything USED to work.

my .asoundrc is as suggested for my card (Audigy2 Platinum):

pcm.emu10k1 {
   type hw
   card 0
}
                                                                                                                       
ctl.emu10k1 {
   type hw
   card 0
}

thanks guys,
brian



On Tue, 2004-11-30 at 16:02, Lee Revell wrote:

> On Tue, 2004-11-30 at 15:05 -0500, Haines Brown wrote:
> > > On Tue, 2004-11-30 at 13:04 -0500, Haines Brown wrote:
> > > >      # cat file.wav > /dev/dsp
> > > > 
> > > > it seems to play at half speed (pitch is very low, playing speed very
> > > > slow).  
> > > > 
> > > > Is the command above the best way to do a simple test of sound? Why
> > > > should sending the file to dsp not play correctly?
> > > 
> > > No, that is the way to do it with the deprecated OSS API.  It seems like
> > > a convenient, Unixy way to play sounds but there are many problems with
> > > it.
> > > 
> > > The ALSA way is "aplay file.wav".  Does this work?
> > 
> > Yes, that worked fine. I find that it plays WAV and VOC, but not MID
> > and WMA files (just screeches). Thanks.
> 
> Hmm, my point about the OSS api notwithstanding, seems like cat foo.wav
> > /dev/dsp should work, if aplay groks the format.  It seems to be
> getting the sample rate wrong.  I am cc'ing alsa-devel.
> 
> What's the sample rate of your .wav file?  Do you get the same results
> with other sample rates?
> 
> This could be a bug in the OSS emulation layer.
> 
> Lee
> 
> 
> 
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now. 
> http://productguide.itmanagersjournal.com/
> _______________________________________________
> Alsa-user mailing list
> Alsa-user@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-user

--=-sKgwrRfWUPLQ4O+rZpRE
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.0.10">
</HEAD>
<BODY>
I have this problem too - but probably others causing it.<BR>
<BR>
aplay -D spdif /usr/share/sounds/startup3.wav works fine.<BR>
<BR>
aplay -D /usr/share/sounds/startup3.wav gives the following error:<BR>
<BR>
ALSA lib pcm.c:1975:(snd_pcm_open_noupdate) Unknown PCM /usr/share/sounds/startup3.wav<BR>
aplay: main:508: audio open error: No such file or directory<BR>
<BR>
cat /usr/share/sounds/startup3.wav &gt; /dev/dsp<BR>
makes no sound and hangs for 55 seconds on this 2.5 second sample.<BR>
<BR>
They both worked before I installed 1.0.7.&nbsp; However, I also installed the OSS compatibility libs this time.<BR>
<BR>
Also when I run alsaconf now it finds 2 cards even though I only have 1.<BR>
emu10k1&nbsp;&nbsp;&nbsp; Creative ...<BR>
legacy&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Probe legacy ISA chips<BR>
<BR>
I suspect this second device is the tiny speaker on my motherboard, no?&nbsp; Is it getting all the attention?<BR>
<BR>
Except for when I specify spdif on the command line &quot;alsaplayer -d spdif ...&quot; none of my audio apps work.<BR>
<BR>
What gives here?&nbsp; Anybody know?&nbsp; Everything USED to work.<BR>
<BR>
my .asoundrc is as suggested for my card (Audigy2 Platinum):<BR>
<BR>
pcm.emu10k1 {<BR>
&nbsp;&nbsp; type hw<BR>
&nbsp;&nbsp; card 0<BR>
}<BR>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <BR>
ctl.emu10k1 {<BR>
&nbsp;&nbsp; type hw<BR>
&nbsp;&nbsp; card 0<BR>
}<BR>
<BR>
thanks guys,<BR>
brian<BR>
<BR>
<BR>
<BR>
On Tue, 2004-11-30 at 16:02, Lee Revell wrote:
<BLOCKQUOTE TYPE=CITE>
<PRE><FONT COLOR="#ff33d1"><I>On Tue, 2004-11-30 at 15:05 -0500, Haines Brown wrote:
&gt; &gt; On Tue, 2004-11-30 at 13:04 -0500, Haines Brown wrote:
&gt; &gt; &gt;      # cat file.wav &gt; /dev/dsp
&gt; &gt; &gt; 
&gt; &gt; &gt; it seems to play at half speed (pitch is very low, playing speed very
&gt; &gt; &gt; slow).  
&gt; &gt; &gt; 
&gt; &gt; &gt; Is the command above the best way to do a simple test of sound? Why
&gt; &gt; &gt; should sending the file to dsp not play correctly?
&gt; &gt; 
&gt; &gt; No, that is the way to do it with the deprecated OSS API.  It seems like
&gt; &gt; a convenient, Unixy way to play sounds but there are many problems with
&gt; &gt; it.
&gt; &gt; 
&gt; &gt; The ALSA way is &quot;aplay file.wav&quot;.  Does this work?
&gt; 
&gt; Yes, that worked fine. I find that it plays WAV and VOC, but not MID
&gt; and WMA files (just screeches). Thanks.

Hmm, my point about the OSS api notwithstanding, seems like cat foo.wav
&gt; /dev/dsp should work, if aplay groks the format.  It seems to be
getting the sample rate wrong.  I am cc'ing alsa-devel.

What's the sample rate of your .wav file?  Do you get the same results
with other sample rates?

This could be a bug in the OSS emulation layer.

Lee



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest &amp; candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. </FONT>
<A HREF="http://productguide.itmanagersjournal.com/"><U>http://productguide.itmanagersjournal.com/</U></A>
<FONT COLOR="#ff33d1">_______________________________________________
Alsa-user mailing list
Alsa-user@lists.sourceforge.net</FONT>
<A HREF="https://lists.sourceforge.net/lists/listinfo/alsa-user"><U>https://lists.sourceforge.net/lists/listinfo/alsa-user</U></I></A></PRE>
</BLOCKQUOTE>
</BODY>
</HTML>

--=-sKgwrRfWUPLQ4O+rZpRE--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
