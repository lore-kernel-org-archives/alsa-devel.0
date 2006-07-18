From: "Grace Baldonasa" <gbaldona@gmail.com>
Subject: Re: question about sampling rate
Date: Tue, 18 Jul 2006 15:21:19 +0800
Message-ID: <7034e7b50607180021u5605f818v9c5e55edb1023903@mail.gmail.com>
References: <7034e7b50607120105s67644513ned098c960d9ac22b@mail.gmail.com>
	<54799.217.150.108.178.1152694606.squirrel@newgolddream.dyndns.info>
	<7034e7b50607120217g2eaace56k5f31054c93839d9f@mail.gmail.com>
	<20060712093749.GA22449@turing.informatik.uni-halle.de>
	<7034e7b50607120300k7cb93e2ak5cf635375d91942c@mail.gmail.com>
	<20060714173102.GA13816@turing.informatik.uni-halle.de>
	<7034e7b50607172213mbde1845occ78b95b17914563@mail.gmail.com>
	<20060718071150.GA11917@turing.informatik.uni-halle.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0192322627=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.178])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id BBE7E17C
	for <alsa-devel@alsa-project.org>;
	Tue, 18 Jul 2006 09:21:20 +0200 (MEST)
Received: by py-out-1112.google.com with SMTP id c59so1837476pyc
	for <alsa-devel@alsa-project.org>; Tue, 18 Jul 2006 00:21:19 -0700 (PDT)
In-Reply-To: <20060718071150.GA11917@turing.informatik.uni-halle.de>
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

--===============0192322627==
Content-Type: multipart/alternative;
	boundary="----=_Part_27046_8179989.1153207279215"

------=_Part_27046_8179989.1153207279215
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Clemens,

I am not yet handling the fractional part of frame size, would it be cause
of the distorted sound? I was expecting to hear music with some noise
though, but nothing good is coming this time.

The endpoint says, adaptive synchrnonization, but no address is defined in
the syncaddress field of the endpoint descriptor.

Do i have to consider the synchronization before I could  hear some music in
my streamed data?
Thanks for all the help.

regards,

grace

On 7/18/06, Clemens Ladisch <clemens@ladisch.de> wrote:
>
> Grace Baldonasa wrote:
> > I am using Philips Speaker with MaxPackSize = 56, channel = 2,
> > sampling bits =16, so I decided to change my framesize:
> >
> > 11025 /1000 * 2 * 16/8 / ms -> 44,
>
> 44.1


yes you're right.

> this time, I cant understand the music out.
>
> How did you set the sample format?  Are there endpoint-specific
> controls?


no endpoint specific control is set. sample format is based on the max
sampling frequency from the format descriptor.

> The endpoint should still be able to handle it since data rate is
> > lesser than maxpacksize.
>
> How do you handle the fractional part of the frame size?
>
> Is this an adaptive endpoint, or what synchronization type does it have?
>
>
> Regards,
> Clemens
>

------=_Part_27046_8179989.1153207279215
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi Clemens,</div>
<div>&nbsp;</div>
<div>I am not yet handling the fractional part of frame size, would it be cause of the distorted sound? I was expecting to hear music with some noise though, but nothing good is coming this time.</div>
<div>&nbsp;</div>
<div>The endpoint says, adaptive synchrnonization, but no address is defined in the syncaddress field of the endpoint descriptor.<br>&nbsp;</div>
<div>Do i have to consider the synchronization before I could&nbsp; hear some music in my streamed data?</div>
<div>Thanks for all the help.</div>
<div>&nbsp;</div>
<div>regards,</div>
<div>&nbsp;</div>
<div>grace<br>&nbsp;</div>
<div><span class="gmail_quote">On 7/18/06, <b class="gmail_sendername">Clemens Ladisch</b> &lt;<a href="mailto:clemens@ladisch.de">clemens@ladisch.de</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Grace Baldonasa wrote:<br>&gt; I am using Philips Speaker with MaxPackSize = 56, channel = 2,<br>&gt; sampling bits =16, so I decided to change my framesize:
<br>&gt;<br>&gt; 11025 /1000 * 2 * 16/8 / ms -&gt; 44,<br><br>44.1</blockquote>
<div>&nbsp;</div>
<div>yes you're right.</div><br>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">&gt; this time, I cant understand the music out.<br><br>How did you set the sample format?&nbsp;&nbsp;Are there endpoint-specific
<br>controls?</blockquote>
<div>&nbsp;</div>
<div>no endpoint specific control is set. sample format is based on the max sampling frequency from the format descriptor.</div><br>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">&gt; The endpoint should still be able to handle it since data rate is<br>&gt; lesser than maxpacksize.<br>
<br>How do you handle the fractional part of the frame size?<br><br>Is this an adaptive endpoint, or what synchronization type does it have?<br><br><br>Regards,<br>Clemens<br></blockquote></div><br>

------=_Part_27046_8179989.1153207279215--


--===============0192322627==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0192322627==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0192322627==--
