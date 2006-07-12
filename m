From: "Grace Baldonasa" <gbaldona@gmail.com>
Subject: Re: question about sampling rate
Date: Wed, 12 Jul 2006 18:00:52 +0800
Message-ID: <7034e7b50607120300k7cb93e2ak5cf635375d91942c@mail.gmail.com>
References: <7034e7b50607120105s67644513ned098c960d9ac22b@mail.gmail.com>
	<54799.217.150.108.178.1152694606.squirrel@newgolddream.dyndns.info>
	<7034e7b50607120217g2eaace56k5f31054c93839d9f@mail.gmail.com>
	<20060712093749.GA22449@turing.informatik.uni-halle.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0575732994=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.179])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 98CAA23B
	for <alsa-devel@alsa-project.org>;
	Wed, 12 Jul 2006 12:00:53 +0200 (MEST)
Received: by py-out-1112.google.com with SMTP id b29so163116pya
	for <alsa-devel@alsa-project.org>; Wed, 12 Jul 2006 03:00:52 -0700 (PDT)
In-Reply-To: <20060712093749.GA22449@turing.informatik.uni-halle.de>
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

--===============0575732994==
Content-Type: multipart/alternative;
	boundary="----=_Part_565_2912366.1152698452374"

------=_Part_565_2912366.1152698452374
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

Thank you so much. Really appreciate this. I have my last clarification to
be made.

After computing the rate, value could be of decimal format, is it rounded
off to either equal or greater than the whole number itself?

/>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
subs->freqmax = subs->freqn + (subs->freqn >> 2); /* max. allowed frequency
*/
Q: why is subs->freqn shifted by 2

 subs->phase = 0;
 /* calculate the max. size of packet */
 maxsize = ((subs->freqmax + 0xffff) * (frame_bits >> 3)) >> 16;

Q: why subs->freqmax is added with 0xffff, then frame_bits is shifted by 3
then the whole thing shifted by 16.

<<<<<<<<<<<<<<<<<<<<<<<<<<<</

I understand that this value is used to determine the maxpacketsize, and I
want to understand why is this so?
I really appreciate any help from you guys.

regards,
grace


On 7/12/06, Clemens Ladisch <clemens@ladisch.de> wrote:
>
> Grace Baldonasa wrote:
> > /*
> > * convert a sampling rate into our full speed format (fs/1000 in Q16.16)
> > * this will overflow at approx 524 kHz
> > */
> > inline static unsigned get_usb_full_speed_rate(unsigned int rate)
> > {
> > return ((rate << 13) + 62) / 125;
> > }
> >
> > I have no clue as to why rate was shifted by 13 then added by 62 then
> > divided by 125.
>
> The parameter is in Hz.  To convert to the number of samples per USB
> frame, we have to divide by 1000.  To convert to a 16.16-fixed-point
> number, we have to multiply by 2^16.  This would result in "rate *
> 0x10000 / 1000".  Factoring out 8 yields "rate * 0x2000 / 125".  The
> multiplication by a power of two can be replaced by a bitwise left
> shift.  The "+62" prevents the division from rounding down.
>
>
> HTH
> Clemens
>

------=_Part_565_2912366.1152698452374
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi,</div>
<div>&nbsp;</div>
<div>Thank you so much. Really appreciate this. I have my last clarification to be made. </div>
<div>
<div>&nbsp;</div>
<div>After computing the rate, value could be of decimal format, is it rounded off to either equal or greater than the whole number itself? </div></div>
<div>&nbsp;</div>
<div>/&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;&gt;</div>
<div>subs-&gt;freqmax = subs-&gt;freqn + (subs-&gt;freqn &gt;&gt; 2); /* max. allowed frequency */&nbsp;&nbsp;</div>
<div>Q: why&nbsp;is subs-&gt;freqn shifted by 2<br>&nbsp;</div>
<div>&nbsp;subs-&gt;phase = 0;</div>
<div>&nbsp;/* calculate the max. size of packet */<br>&nbsp;maxsize = ((subs-&gt;freqmax + 0xffff) * (frame_bits &gt;&gt; 3)) &gt;&gt; 16;</div>
<div>&nbsp;</div>
<div>Q: why subs-&gt;freqmax is added with 0xffff, then frame_bits is shifted by 3 then the whole thing shifted by 16.</div>
<div>&nbsp;</div>
<div>&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;&lt;/</div>
<div>&nbsp;</div>
<div>I understand that this value is used to determine the maxpacketsize, and I want to understand why is this so?</div>
<div>I really appreciate any help from you guys.</div>
<div>&nbsp;</div>
<div>regards,</div>
<div>grace</div>
<div><br>&nbsp;</div>
<div><span class="gmail_quote">On 7/12/06, <b class="gmail_sendername">Clemens Ladisch</b> &lt;<a href="mailto:clemens@ladisch.de">clemens@ladisch.de</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Grace Baldonasa wrote:<br>&gt; /*<br>&gt; * convert a sampling rate into our full speed format (fs/1000 in 
Q16.16)<br>&gt; * this will overflow at approx 524 kHz<br>&gt; */<br>&gt; inline static unsigned get_usb_full_speed_rate(unsigned int rate)<br>&gt; {<br>&gt; return ((rate &lt;&lt; 13) + 62) / 125;<br>&gt; }<br>&gt;<br>&gt; I have no clue as to why rate was shifted by 13 then added by 62 then
<br>&gt; divided by 125.<br><br>The parameter is in Hz.&nbsp;&nbsp;To convert to the number of samples per USB<br>frame, we have to divide by 1000.&nbsp;&nbsp;To convert to a 16.16-fixed-point<br>number, we have to multiply by 2^16.&nbsp;&nbsp;This would result in &quot;rate *
<br>0x10000 / 1000&quot;.&nbsp;&nbsp;Factoring out 8 yields &quot;rate * 0x2000 / 125&quot;.&nbsp;&nbsp;The<br>multiplication by a power of two can be replaced by a bitwise left<br>shift.&nbsp;&nbsp;The &quot;+62&quot; prevents the division from rounding down.
<br><br><br>HTH<br>Clemens<br></blockquote></div><br>

------=_Part_565_2912366.1152698452374--


--===============0575732994==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

--===============0575732994==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0575732994==--
