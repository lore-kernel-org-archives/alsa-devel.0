From: "Grace Baldonasa" <gbaldona@gmail.com>
Subject: Re: question about sampling rate
Date: Thu, 31 Aug 2006 16:22:06 +0800
Message-ID: <7034e7b50608310122na613dcesf642709d586fbde5@mail.gmail.com>
References: <54799.217.150.108.178.1152694606.squirrel@newgolddream.dyndns.info>
	<20060718071150.GA11917@turing.informatik.uni-halle.de>
	<7034e7b50607180021u5605f818v9c5e55edb1023903@mail.gmail.com>
	<20060718143423.GB15467@turing.informatik.uni-halle.de>
	<7034e7b50607181827u6ddc9cb5s8585978e80a7af9b@mail.gmail.com>
	<20060719122905.GB24800@turing.informatik.uni-halle.de>
	<7034e7b50608091945r39ddaeeevda675f05251be9cb@mail.gmail.com>
	<1155315961.10237.268179763@webmail.messagingengine.com>
	<7034e7b50608302232w2b7279b3qf66acaeca54f1e2b@mail.gmail.com>
	<1157012237.11592.269833216@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0567323417=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.183])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 2DC7C188
	for <alsa-devel@alsa-project.org>;
	Thu, 31 Aug 2006 10:22:08 +0200 (MEST)
Received: by py-out-1112.google.com with SMTP id c59so698109pyc
	for <alsa-devel@alsa-project.org>; Thu, 31 Aug 2006 01:22:07 -0700 (PDT)
In-Reply-To: <1157012237.11592.269833216@webmail.messagingengine.com>
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

--===============0567323417==
Content-Type: multipart/alternative;
	boundary="----=_Part_61711_17201136.1157012526717"

------=_Part_61711_17201136.1157012526717
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Clemens,

What do you mean when you said Windows had converted it to 48000 Hz, you
mean the audio data itself is converted or just the sampling rate factor in
the computation.

When I took a CATC trace using ALSA version, it is also using a fixed 176
bytes / packet, I am missing something here?  I hope you can help me sort
out my confusion.

Thanks & Best regards,

Grace


On 8/31/06, Clemens Ladisch <cladisch@fastmail.net> wrote:
>
> Grace Baldonasa wrote:
> > I am dividing the buffer size into 20 ms, in the given example, I am
> > sending 176 bytes / packet.
>
> This would correspond to a sample rate of 44000 Hz.
>
> You cannot use a constant number of bytes per packet at 44100 Hz.
>
> > I have here another scenario and I hope you can give me some idea again.
> > I have converted a song using this configuration:
> > sampling rate = 32000
> > bit resolution = 16
> > channel = stereo
> > after this computation (32000*16*2) * 2 -> 128/packet
> >
> > I used a speaker which is supporting a minimum frequency of 44100  and
> > maximum of 48000. How can I adjust my streaming size now that the
> streaming
> > configuration far below than the minimum supported by the speaker.
>
> See section 5.12 of the USB 2.0 specification.
>
> > I attached this speaker in windows and then played the converted file,
> it
> > is sending 192bytes/packet, and the total bytes transffered had almost
> > trippled the original size of the converted file.
>
> Apparently, Windows has converted the data to 48 kHz.
>
>
> Regards,
> Clemens
>

------=_Part_61711_17201136.1157012526717
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi Clemens,</div>
<div><br>What do you mean when you said Windows had converted it to 48000 Hz, you mean the audio data itself is converted or just the sampling rate factor in the computation.</div>
<div>&nbsp;</div>
<div>When I took a CATC trace using ALSA version, it is also using a fixed 176 bytes / packet, I am missing something here?&nbsp; I hope you can help me sort out my confusion.</div>
<div>&nbsp;</div>
<div>Thanks &amp; Best regards,</div>
<div>&nbsp;</div>
<div>Grace</div>
<div><br>&nbsp;</div>
<div><span class="gmail_quote">On 8/31/06, <b class="gmail_sendername">Clemens Ladisch</b> &lt;<a href="mailto:cladisch@fastmail.net">cladisch@fastmail.net</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Grace Baldonasa wrote:<br>&gt; I am dividing the buffer size into 20 ms, in the given example, I am<br>&gt; sending 176 bytes / packet.
<br><br>This would correspond to a sample rate of 44000 Hz.<br><br>You cannot use a constant number of bytes per packet at 44100 Hz.<br><br>&gt; I have here another scenario and I hope you can give me some idea again.<br>
&gt; I have converted a song using this configuration:<br>&gt; sampling rate = 32000<br>&gt; bit resolution = 16<br>&gt; channel = stereo<br>&gt; after this computation (32000*16*2) * 2 -&gt; 128/packet<br>&gt;<br>&gt; I used a speaker which is supporting a minimum frequency of 44100&nbsp;&nbsp;and
<br>&gt; maximum of 48000. How can I adjust my streaming size now that the streaming<br>&gt; configuration far below than the minimum supported by the speaker.<br><br>See section 5.12 of the USB 2.0 specification.<br><br>
&gt; I attached this speaker in windows and then played the converted file, it<br>&gt; is sending 192bytes/packet, and the total bytes transffered had almost<br>&gt; trippled the original size of the converted file.<br><br>
Apparently, Windows has converted the data to 48 kHz.<br><br><br>Regards,<br>Clemens<br></blockquote></div><br>

------=_Part_61711_17201136.1157012526717--


--===============0567323417==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0567323417==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0567323417==--
