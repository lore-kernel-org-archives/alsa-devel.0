From: "Grace Baldonasa" <gbaldona@gmail.com>
Subject: Re: question about sampling rate
Date: Wed, 12 Jul 2006 17:17:13 +0800
Message-ID: <7034e7b50607120217g2eaace56k5f31054c93839d9f@mail.gmail.com>
References: <7034e7b50607120105s67644513ned098c960d9ac22b@mail.gmail.com>
	<54799.217.150.108.178.1152694606.squirrel@newgolddream.dyndns.info>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1356507679=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.183])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7759E158
	for <alsa-devel@alsa-project.org>;
	Wed, 12 Jul 2006 11:17:14 +0200 (MEST)
Received: by py-out-1112.google.com with SMTP id b29so153092pya
	for <alsa-devel@alsa-project.org>; Wed, 12 Jul 2006 02:17:13 -0700 (PDT)
In-Reply-To: <54799.217.150.108.178.1152694606.squirrel@newgolddream.dyndns.info>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Adrian McMenamin <adrian@newgolddream.dyndns.info>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--===============1356507679==
Content-Type: multipart/alternative;
	boundary="----=_Part_7603_4116954.1152695833108"

------=_Part_7603_4116954.1152695833108
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

Yes I am referring to the audio class driver. I actually would want to
understand about this:

/*
 * convert a sampling rate into USB high speed format (fs/8000 in Q16.16)
 * this will overflow at approx 4 MHz
 */
inline static unsigned get_usb_high_speed_rate(unsigned int rate)
{
 return ((rate << 10) + 62) / 125;
}

and

/*
 * convert a sampling rate into our full speed format (fs/1000 in Q16.16)
 * this will overflow at approx 524 kHz
 */
inline static unsigned get_usb_full_speed_rate(unsigned int rate)
{
 return ((rate << 13) + 62) / 125;
}

I have no clue as to why rate was shifted by 13 then added by 62 then
divided by 125.
I will be writing an embedded linux audio class driver and would like to
simplify the alsa since it is a bit complex and many features may not be
applicable for our use.

Thank you for any help extended.




On 7/12/06, Adrian McMenamin <adrian@newgolddream.dyndns.info> wrote:
>
> On Wed, July 12, 2006 9:05 am, Grace Baldonasa wrote:
> > Hi all,
> >
> > I have a very simple question regarding the convertion of sampling rate
> to
> > usb full/high speed rate, is this the right mailing list to throw the
> > question?
> >
> > any reply will be greatly appreciate.
> > Thanks.
> >
> You need to be a bit clearer about what it is you want to do. I assume you
> are referring to a sound device.
>
> ALSA will automatically handle the sample rate - converting between the
> sample rate of the sound you want to play and the capabilities of your
> device as specified by the driver.
>
>

------=_Part_7603_4116954.1152695833108
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi, </div>
<div>&nbsp;</div>
<div>Yes I am referring to the audio class driver. I actually would want to understand about this:</div>
<div>&nbsp;</div>
<div>/*<br>&nbsp;* convert a sampling rate into USB high speed format (fs/8000 in Q16.16)<br>&nbsp;* this will overflow at approx 4 MHz<br>&nbsp;*/<br>inline static unsigned get_usb_high_speed_rate(unsigned int rate)<br>{<br>&nbsp;return ((rate &lt;&lt; 10) + 62) / 125;
<br>}</div>
<div>&nbsp;</div>
<div>and </div>
<div>&nbsp;</div>
<div>/*<br>&nbsp;* convert a sampling rate into our full speed format (fs/1000 in Q16.16)<br>&nbsp;* this will overflow at approx 524 kHz<br>&nbsp;*/<br>inline static unsigned get_usb_full_speed_rate(unsigned int rate)<br>{<br>&nbsp;return ((rate &lt;&lt; 13) + 62) / 125;
<br>}<br>&nbsp;</div>
<div>I have no clue as to why rate was shifted by 13 then added by 62 then divided by 125.</div>
<div>I will&nbsp;be writing an embedded linux audio class driver and would like to simplify the alsa since it is a bit complex and many features may not be applicable for our use.</div>
<div>&nbsp;</div>
<div>Thank you for any help extended.</div>
<div>&nbsp;</div>
<div><br><br>&nbsp;</div>
<div><span class="gmail_quote">On 7/12/06, <b class="gmail_sendername">Adrian McMenamin</b> &lt;<a href="mailto:adrian@newgolddream.dyndns.info">adrian@newgolddream.dyndns.info</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">On Wed, July 12, 2006 9:05 am, Grace Baldonasa wrote:<br>&gt; Hi all,<br>&gt;<br>&gt; I have a very simple question regarding the convertion of sampling rate to
<br>&gt; usb full/high speed rate, is this the right mailing list to throw the<br>&gt; question?<br>&gt;<br>&gt; any reply will be greatly appreciate.<br>&gt; Thanks.<br>&gt;<br>You need to be a bit clearer about what it is you want to do. I assume you
<br>are referring to a sound device.<br><br>ALSA will automatically handle the sample rate - converting between the<br>sample rate of the sound you want to play and the capabilities of your<br>device as specified by the driver.
<br><br></blockquote></div><br>

------=_Part_7603_4116954.1152695833108--


--===============1356507679==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642

--===============1356507679==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1356507679==--
