From: Brian L Scipioni <brian@gaugetheory.org>
Subject: Re: [Alsa-devel] Re: file.wav -> dsp issue
Date: Wed, 01 Dec 2004 12:58:11 -0500
Message-ID: <1101923891.14957.55.camel@radium.gaugetheory.org>
References: <20041130180410.D498B187F@teufel.hartford-hwp.com>
	 <1101839935.10162.1.camel@krustophenia.net>
	 <20041130200556.9A346188C@teufel.hartford-hwp.com>
	 <1101848569.10162.25.camel@krustophenia.net>
	 <1101913012.13435.37.camel@radium.gaugetheory.org>
	 <s5h653mnjpn.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: multipart/alternative; boundary="=-OPvf3cntLtWyit0xlAv9"
Return-path: <alsa-user-admin@lists.sourceforge.net>
In-Reply-To: <s5h653mnjpn.wl@alsa2.suse.de>
Sender: alsa-user-admin@lists.sourceforge.net
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: Takashi Iwai <tiwai@suse.de>
Cc: Lee Revell <rlrevell@joe-job.com>, "H.Haines Brown" <brownh@hartford-hwp.com>, alsa-user@lists.sourceforge.net, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--=-OPvf3cntLtWyit0xlAv9
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

oops!  I meant to run
aplay  /usr/share/sounds/startup3.wav (without the -D of course, duh!)
this gives no output although
 aplay -D spdif /usr/share/sounds/startup3.wav does
In previous versions of ALSA this (without specifying spdif) worked.
Have default devices changed?

you write:
.... blocked by others
This behavior was changed recently to be non-blocking mode

What was changed to non-blocking mode? /dev/dsp or other devices.

could the legacy card that alsaconf found be my tiny 
motherboard speaker?  If so why does it get in the way now - it did not
before.

I have 
alias sound-slot-1 off
in my modules.conf
because my system log periodically complains that sound-slot-1 is not
found even though i have only one card

thanks,
sorry for the bevy of questions,
brian

On Wed, 2004-12-01 at 10:


> At Wed, 01 Dec 2004 09:56:52 -0500,
> Brian L Scipioni wrote:
> > 
> > I have this problem too - but probably others causing it.
> > 
> > aplay -D spdif /usr/share/sounds/startup3.wav works fine.
> > 
> > aplay -D /usr/share/sounds/startup3.wav gives the following error:
> > 
> > ALSA lib pcm.c:1975:(snd_pcm_open_noupdate) Unknown PCM /usr/share/sounds/startup3.wav
> > aplay: main:508: audio open error: No such file or directory
> 
> -D option requires an argument.  In the second case, you didn't pass
> it so the wav file name is parsed as the device name.
> 
> > cat /usr/share/sounds/startup3.wav > /dev/dsp
> > makes no sound and hangs for 55 seconds on this 2.5 second sample.
> 
> Most likely the device is simply blocked by others.
> This behavior was changed recently to be non-blocking mode, BTW.
> 
> 
> Takashi

-- 
Brian L Scipioni
909 Austin Ave
Atlanta, GA 30307
home:	404.525.8911
cell:	404.771.3740
brian@gaugetheory.org


--=-OPvf3cntLtWyit0xlAv9
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.0.10">
</HEAD>
<BODY>
<TT>oops!&nbsp; I meant to run<BR>
aplay&nbsp; /usr/share/sounds/startup3.wav (without the -D of course, duh!)<BR>
this gives no output although<BR>
 aplay -D spdif /usr/share/sounds/startup3.wav does<BR>
In previous versions of ALSA this (without specifying spdif) worked.<BR>
Have default devices changed?<BR>
<BR>
you write:<BR>
.... blocked by others<BR>
This behavior was changed recently to be non-blocking mode<BR>
<BR>
What was changed to non-blocking mode? /dev/dsp or other devices.<BR>
<BR>
could the legacy card that alsaconf found be my tiny <BR>
motherboard speaker?&nbsp; If so why does it get in the way now - it did not before.<BR>
<BR>
I have <BR>
alias sound-slot-1 off<BR>
in my modules.conf<BR>
because my system log periodically complains that sound-slot-1 is not found even though i have only one card<BR>
<BR>
thanks,<BR>
sorry for the bevy of questions,<BR>
brian</TT><BR>
<BR>
On Wed, 2004-12-01 at 10:<BR>
<BR>
<BLOCKQUOTE TYPE=CITE>
<PRE><FONT COLOR="#ff33d1"><I>At Wed, 01 Dec 2004 09:56:52 -0500,
Brian L Scipioni wrote:
&gt; 
&gt; I have this problem too - but probably others causing it.
&gt; 
&gt; aplay -D spdif /usr/share/sounds/startup3.wav works fine.
&gt; 
&gt; aplay -D /usr/share/sounds/startup3.wav gives the following error:
&gt; 
&gt; ALSA lib pcm.c:1975:(snd_pcm_open_noupdate) Unknown PCM /usr/share/sounds/startup3.wav
&gt; aplay: main:508: audio open error: No such file or directory

-D option requires an argument.  In the second case, you didn't pass
it so the wav file name is parsed as the device name.

&gt; cat /usr/share/sounds/startup3.wav &gt; /dev/dsp
&gt; makes no sound and hangs for 55 seconds on this 2.5 second sample.

Most likely the device is simply blocked by others.
This behavior was changed recently to be non-blocking mode, BTW.


Takashi</I></FONT></PRE>
</BLOCKQUOTE>
<PRE><TABLE CELLSPACING="0" CELLPADDING="0" WIDTH="100%">
<TR>
<TD>
<PRE>-- 
Brian L Scipioni
909 Austin Ave
Atlanta, GA 30307
home:	404.525.8911
cell:	404.771.3740
brian@gaugetheory.org
</PRE>
</TD>
</TR>
</TABLE>
</PRE>
</BODY>
</HTML>

--=-OPvf3cntLtWyit0xlAv9--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
