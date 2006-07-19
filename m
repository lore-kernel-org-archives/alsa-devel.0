From: "Grace Baldonasa" <gbaldona@gmail.com>
Subject: Re: question about sampling rate
Date: Wed, 19 Jul 2006 09:27:34 +0800
Message-ID: <7034e7b50607181827u6ddc9cb5s8585978e80a7af9b@mail.gmail.com>
References: <7034e7b50607120105s67644513ned098c960d9ac22b@mail.gmail.com>
	<54799.217.150.108.178.1152694606.squirrel@newgolddream.dyndns.info>
	<7034e7b50607120217g2eaace56k5f31054c93839d9f@mail.gmail.com>
	<20060712093749.GA22449@turing.informatik.uni-halle.de>
	<7034e7b50607120300k7cb93e2ak5cf635375d91942c@mail.gmail.com>
	<20060714173102.GA13816@turing.informatik.uni-halle.de>
	<7034e7b50607172213mbde1845occ78b95b17914563@mail.gmail.com>
	<20060718071150.GA11917@turing.informatik.uni-halle.de>
	<7034e7b50607180021u5605f818v9c5e55edb1023903@mail.gmail.com>
	<20060718143423.GB15467@turing.informatik.uni-halle.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1093940113=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.177])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 26FD4242
	for <alsa-devel@alsa-project.org>;
	Wed, 19 Jul 2006 03:27:35 +0200 (MEST)
Received: by py-out-1112.google.com with SMTP id c63so73071pyc
	for <alsa-devel@alsa-project.org>; Tue, 18 Jul 2006 18:27:34 -0700 (PDT)
In-Reply-To: <20060718143423.GB15467@turing.informatik.uni-halle.de>
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

--===============1093940113==
Content-Type: multipart/alternative;
	boundary="----=_Part_48983_21341185.1153272454070"

------=_Part_48983_21341185.1153272454070
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Clemens,

yes, i did set the alternate setting. The currrent endpoint should be able
to handle the stream data since the maxpacketsize is 56, the max sampling
rate it support is 55kHz, but as I mentioned in my previous email, it's only
noise that I can hear from the speaker.

I used a converted raw data in hex format, I am not really sure what is the
sampling bit, sampling rate or number of channels used when conversion was
made to the raw data, I am in doubt the sampling bit / channels does  not
fit with my experimentations.

Can you recommend some application that will allow me to convert small wav
to hex as array of characters that I could use to stream.

Thank you very much once again,

grace


On 7/18/06, Clemens Ladisch <clemens@ladisch.de> wrote:
>
> Grace Baldonasa wrote:
> > I am not yet handling the fractional part of frame size, would it be
> cause
> > of the distorted sound?
>
> There shouldn't be too much noise in this case.
>
> > The endpoint says, adaptive synchrnonization,
>
> Then it should be able to handle a frequency that is 0.25% off.
>
> > >How did you set the sample format?  Are there endpoint-specific
> > >controls?
> >
> > no endpoint specific control is set. sample format is based on the max
> > sampling frequency from the format descriptor.
>
> Did you set the altsetting, or how does the device know about the
> current sample format?
>
>
> Regards,
> Clemens
>

------=_Part_48983_21341185.1153272454070
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi Clemens,</div>
<div>&nbsp;</div>
<div>yes, i did set the alternate setting. The currrent endpoint should be able to handle the stream data since the maxpacketsize is 56, the max sampling rate it support is 55kHz, but as I mentioned in my previous email, it's only noise that I can hear from the speaker.
</div>
<div>&nbsp;</div>
<div>I used a converted raw data in hex format, I am not really sure what is the sampling bit, sampling rate or number of channels used when conversion was made to the raw data, I am in doubt the sampling bit / channels does&nbsp; not fit with my experimentations. 
</div>
<div>&nbsp;</div>
<div>Can you recommend some application that will allow me to convert&nbsp;small wav to hex as array of characters that I could use to stream.</div>
<div>&nbsp;</div>
<div>Thank you very much once again,</div>
<div>&nbsp;</div>
<div>grace<br><br>&nbsp;</div>
<div><span class="gmail_quote">On 7/18/06, <b class="gmail_sendername">Clemens Ladisch</b> &lt;<a href="mailto:clemens@ladisch.de">clemens@ladisch.de</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Grace Baldonasa wrote:<br>&gt; I am not yet handling the fractional part of frame size, would it be cause<br>
&gt; of the distorted sound?<br><br>There shouldn't be too much noise in this case.<br><br>&gt; The endpoint says, adaptive synchrnonization,<br><br>Then it should be able to handle a frequency that is 0.25% off.<br><br>&gt; &gt;How did you set the sample format?&nbsp;&nbsp;Are there endpoint-specific
<br>&gt; &gt;controls?<br>&gt;<br>&gt; no endpoint specific control is set. sample format is based on the max<br>&gt; sampling frequency from the format descriptor.<br><br>Did you set the altsetting, or how does the device know about the
<br>current sample format?<br><br><br>Regards,<br>Clemens<br></blockquote></div><br>

------=_Part_48983_21341185.1153272454070--


--===============1093940113==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1093940113==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1093940113==--
