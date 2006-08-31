From: "Grace Baldonasa" <gbaldona@gmail.com>
Subject: Re: question about sampling rate
Date: Thu, 31 Aug 2006 13:32:26 +0800
Message-ID: <7034e7b50608302232w2b7279b3qf66acaeca54f1e2b@mail.gmail.com>
References: <54799.217.150.108.178.1152694606.squirrel@newgolddream.dyndns.info>
	<20060714173102.GA13816@turing.informatik.uni-halle.de>
	<7034e7b50607172213mbde1845occ78b95b17914563@mail.gmail.com>
	<20060718071150.GA11917@turing.informatik.uni-halle.de>
	<7034e7b50607180021u5605f818v9c5e55edb1023903@mail.gmail.com>
	<20060718143423.GB15467@turing.informatik.uni-halle.de>
	<7034e7b50607181827u6ddc9cb5s8585978e80a7af9b@mail.gmail.com>
	<20060719122905.GB24800@turing.informatik.uni-halle.de>
	<7034e7b50608091945r39ddaeeevda675f05251be9cb@mail.gmail.com>
	<1155315961.10237.268179763@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0379315432=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.181])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 64DB1247
	for <alsa-devel@alsa-project.org>;
	Thu, 31 Aug 2006 07:32:28 +0200 (MEST)
Received: by py-out-1112.google.com with SMTP id c59so635331pyc
	for <alsa-devel@alsa-project.org>; Wed, 30 Aug 2006 22:32:26 -0700 (PDT)
In-Reply-To: <1155315961.10237.268179763@webmail.messagingengine.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--===============0379315432==
Content-Type: multipart/alternative;
	boundary="----=_Part_59748_32903475.1157002346552"

------=_Part_59748_32903475.1157002346552
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Clemens,

I am dividing the buffer size into 20 ms, in the given example, I am sending
176 bytes / packet.

I have here another scenario and I hope you can give me some idea again.
I have converted a song using this configuration:
sampling rate = 32000
bit resolution = 16
channel = stereo
after this computation (32000*16*2) * 2 -> 128/packet

I used a speaker which is supporting a minimum frequency of 44100  and
maximum of 48000. How can I adjust my streaming size now that the streaming
configuration far below than the minimum supported by the speaker.

I attached this speaker in windows and then played the converted file, it is
sending 192bytes/packet, and the total bytes transffered had almost trippled
the original size of the converted file. Looks like the windows class driver
had padded the data, but I dont know how to arrived to the exact number of
bytes to be padded to the computed one. I hope I was able to explain my
problem well.

Thanks for all the help.

regards,

grace



On 8/12/06, Clemens Ladisch <cladisch@fastmail.net> wrote:
>
> Grace Baldonasa wrote:
> > I am half way my development. I can stream music using dynamic settings
> (any
> > speaker plugged in to my host be heard of some music when my application
> is
> > streaming some audio data). However, there are still background noise I
> am
> > hearing. Here is how I computed my streaming size:
> >
> > sampling rate = 44100
> > channel = 2
> > bit resolution = 16
> > period length = 20 ms
> > period size = 3528
>
> bytes
>
> > This period size is used as my buffer size, and this is sliced as it is
> > streamed to my device.
> > I have not considered any sychronization yet. Here is the speaker
> > configuration:
> > Synchronization type = adaptive sync
> >
> > My understanding is no sync pipe is defined  by the device, therefore I
> dont
> > need to schedule any sync data, am I correct?
>
> Yes.  An adaptive endpoint should be able to work with any sample rate,
> as long as it's near 44100.
>
> How do you slice your buffer?
>
>
> Regards,
> Clemens
>

------=_Part_59748_32903475.1157002346552
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi Clemens,</div>
<div>&nbsp;</div>
<div>I am dividing the buffer size into 20 ms, in the given example, I am sending 176 bytes / packet.</div>
<div>&nbsp;</div>
<div>I have here another scenario and I hope you can give me some idea again.</div>
<div>I have converted a song using this configuration:</div>
<div>sampling rate = 32000</div>
<div>bit resolution = 16</div>
<div>channel = stereo</div>
<div>after this computation (32000*16*2) * 2 -&gt; 128/packet</div>
<div>&nbsp;</div>
<div>I used a speaker which is supporting a minimum frequency of 44100&nbsp; and maximum of 48000. How can I adjust my streaming size now that the streaming configuration far below than the minimum supported by the speaker. </div>

<div>&nbsp;</div>
<div>I attached this speaker in windows and then played the converted file, it is sending 192bytes/packet, and the total bytes transffered had almost trippled the original size of the converted file. Looks like the windows class driver had padded the data, but I dont know how to arrived to the exact number of bytes to be padded to the computed one. I hope I was able to explain my problem well.
</div>
<div>&nbsp;</div>
<div>Thanks for all the help.</div>
<div>&nbsp;</div>
<div>regards,</div>
<div>&nbsp;</div>
<div>grace</div>
<div><br><br>&nbsp;</div>
<div><span class="gmail_quote">On 8/12/06, <b class="gmail_sendername">Clemens Ladisch</b> &lt;<a href="mailto:cladisch@fastmail.net">cladisch@fastmail.net</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Grace Baldonasa wrote:<br>&gt; I am half way my development. I can stream music using dynamic settings (any
<br>&gt; speaker plugged in to my host be heard of some music when my application is<br>&gt; streaming some audio data). However, there are still background noise I am<br>&gt; hearing. Here is how I computed my streaming size:
<br>&gt;<br>&gt; sampling rate = 44100<br>&gt; channel = 2<br>&gt; bit resolution = 16<br>&gt; period length = 20 ms<br>&gt; period size = 3528<br><br>bytes<br><br>&gt; This period size is used as my buffer size, and this is sliced as it is
<br>&gt; streamed to my device.<br>&gt; I have not considered any sychronization yet. Here is the speaker<br>&gt; configuration:<br>&gt; Synchronization type = adaptive sync<br>&gt;<br>&gt; My understanding is no sync pipe is defined&nbsp;&nbsp;by the device, therefore I dont
<br>&gt; need to schedule any sync data, am I correct?<br><br>Yes.&nbsp;&nbsp;An adaptive endpoint should be able to work with any sample rate,<br>as long as it's near 44100.<br><br>How do you slice your buffer?<br><br><br>Regards,
<br>Clemens<br></blockquote></div><br>

------=_Part_59748_32903475.1157002346552--


--===============0379315432==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0379315432==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0379315432==--
