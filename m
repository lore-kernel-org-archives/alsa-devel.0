From: "Grace Baldonasa" <gbaldona@gmail.com>
Subject: Re: question about sampling rate
Date: Tue, 18 Jul 2006 13:13:23 +0800
Message-ID: <7034e7b50607172213mbde1845occ78b95b17914563@mail.gmail.com>
References: <7034e7b50607120105s67644513ned098c960d9ac22b@mail.gmail.com>
	<54799.217.150.108.178.1152694606.squirrel@newgolddream.dyndns.info>
	<7034e7b50607120217g2eaace56k5f31054c93839d9f@mail.gmail.com>
	<20060712093749.GA22449@turing.informatik.uni-halle.de>
	<7034e7b50607120300k7cb93e2ak5cf635375d91942c@mail.gmail.com>
	<20060714173102.GA13816@turing.informatik.uni-halle.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1364981380=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.178])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id C7DB522F
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Jul 2006 07:13:24 +0200 (MEST)
Received: by py-out-1112.google.com with SMTP id c59so1801076pyc
	for <alsa-devel@alsa-project.org>; Mon, 17 Jul 2006 22:13:23 -0700 (PDT)
In-Reply-To: <20060714173102.GA13816@turing.informatik.uni-halle.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Clemens Ladisch <clemens@ladisch.de>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--===============1364981380==
Content-Type: multipart/alternative;
	boundary="----=_Part_25422_25312525.1153199603285"

------=_Part_25422_25312525.1153199603285
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Clemens,

Really appreciate your time answering my question. I have already started my
streaming and is facing another problem now.

Fs = 11025 Hz
Channel  = 2
Bit resolution = 8

so I tried sending my data at (11025/1000) * 2 / ms, I could hear some music
played but with some noise.

I am using Philips Speaker with MaxPackSize = 56, channel = 2, sampling bits
=16, so I decided to change my framesize:

11025 /1000 * 2 * 16/8 / ms -> 44, this time, I cant understand the music
out. The endpoint should still be able to handle it since data rate is
lesser than maxpacksize.

Do you know what went wrong here? hope to receive your advise.
thank...

grace




On 7/15/06, Clemens Ladisch <clemens@ladisch.de> wrote:
>
> Grace Baldonasa wrote:
> > After computing the rate, value could be of decimal format,
>
> In the computer, all values are binary.
>
> > is it rounded off to either equal or greater than the whole number
> > itself?
>
> There is no whole number, it is interpreted as a number with 16 binary
> fractional digits.
>
> > subs->freqmax = subs->freqn + (subs->freqn >> 2);
> > Q: why is subs->freqn shifted by 2
>
> It's just subs->freqn plus 25 percent, and that is just some random
> value that should be safe enough for any real sample clock.
>
> > subs->phase = 0;
> > /* calculate the max. size of packet */
> > maxsize = ((subs->freqmax + 0xffff) * (frame_bits >> 3)) >> 16;
> >
> > Q: why subs->freqmax is added with 0xffff, then frame_bits is shifted by
> 3
> > then the whole thing shifted by 16.
>
> It's shifted by 16 to throw away the fractional digits; we calculate
> whole bytes.
> "frame_bits/8" is the number of bytes per frame.
> Adding 0xffff ensures that despite the truncation by the final shift,
> the value is rounded up.
>
>
> HTH
> Clemens
>

------=_Part_25422_25312525.1153199603285
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi Clemens,</div>
<div>&nbsp;</div>
<div>Really appreciate your time answering my question. I have already started my streaming and is facing another problem now. </div>
<div>&nbsp;</div>
<div>Fs = 11025 Hz</div>
<div>Channel&nbsp; = 2</div>
<div>Bit resolution = 8</div>
<div>&nbsp;</div>
<div>so I tried&nbsp;sending my data at (11025/1000) * 2 / ms, I could hear some music played but with some noise. </div>
<div>&nbsp;</div>
<div>I am using Philips Speaker&nbsp;with MaxPackSize = 56, channel = 2, sampling bits =16, so I decided to change my framesize:</div>
<div>&nbsp;</div>
<div>11025 /1000 * 2 * 16/8 / ms -&gt; 44, this time, I cant understand the music out. The endpoint should still be able to handle it since data rate is lesser than maxpacksize.</div>
<div>&nbsp;</div>
<div>Do you know what went wrong here? hope to receive your advise.</div>
<div>thank...</div>
<div>&nbsp;</div>
<div>grace</div>
<div>&nbsp;</div>
<div><br><br>&nbsp;</div>
<div><span class="gmail_quote">On 7/15/06, <b class="gmail_sendername">Clemens Ladisch</b> &lt;<a href="mailto:clemens@ladisch.de">clemens@ladisch.de</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Grace Baldonasa wrote:<br>&gt; After computing the rate, value could be of decimal format,<br><br>In the computer, all values are binary.
<br><br>&gt; is it rounded off to either equal or greater than the whole number<br>&gt; itself?<br><br>There is no whole number, it is interpreted as a number with 16 binary<br>fractional digits.<br><br>&gt; subs-&gt;freqmax = subs-&gt;freqn + (subs-&gt;freqn &gt;&gt; 2);
<br>&gt; Q: why is subs-&gt;freqn shifted by 2<br><br>It's just subs-&gt;freqn plus 25 percent, and that is just some random<br>value that should be safe enough for any real sample clock.<br><br>&gt; subs-&gt;phase = 0;<br>
&gt; /* calculate the max. size of packet */<br>&gt; maxsize = ((subs-&gt;freqmax + 0xffff) * (frame_bits &gt;&gt; 3)) &gt;&gt; 16;<br>&gt;<br>&gt; Q: why subs-&gt;freqmax is added with 0xffff, then frame_bits is shifted by 3
<br>&gt; then the whole thing shifted by 16.<br><br>It's shifted by 16 to throw away the fractional digits; we calculate<br>whole bytes.<br>&quot;frame_bits/8&quot; is the number of bytes per frame.<br>Adding 0xffff ensures that despite the truncation by the final shift,
<br>the value is rounded up.<br><br><br>HTH<br>Clemens<br></blockquote></div><br>

------=_Part_25422_25312525.1153199603285--


--===============1364981380==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1364981380==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1364981380==--
