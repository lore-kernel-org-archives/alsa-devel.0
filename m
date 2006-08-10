From: "Grace Baldonasa" <gbaldona@gmail.com>
Subject: Re: question about sampling rate
Date: Thu, 10 Aug 2006 10:45:53 +0800
Message-ID: <7034e7b50608091945r39ddaeeevda675f05251be9cb@mail.gmail.com>
References: <54799.217.150.108.178.1152694606.squirrel@newgolddream.dyndns.info>
	<20060712093749.GA22449@turing.informatik.uni-halle.de>
	<7034e7b50607120300k7cb93e2ak5cf635375d91942c@mail.gmail.com>
	<20060714173102.GA13816@turing.informatik.uni-halle.de>
	<7034e7b50607172213mbde1845occ78b95b17914563@mail.gmail.com>
	<20060718071150.GA11917@turing.informatik.uni-halle.de>
	<7034e7b50607180021u5605f818v9c5e55edb1023903@mail.gmail.com>
	<20060718143423.GB15467@turing.informatik.uni-halle.de>
	<7034e7b50607181827u6ddc9cb5s8585978e80a7af9b@mail.gmail.com>
	<20060719122905.GB24800@turing.informatik.uni-halle.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1211838670=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.176])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8E02622A
	for <alsa-devel@alsa-project.org>;
	Thu, 10 Aug 2006 04:45:55 +0200 (MEST)
Received: by py-out-1112.google.com with SMTP id b29so299464pya
	for <alsa-devel@alsa-project.org>; Wed, 09 Aug 2006 19:45:54 -0700 (PDT)
In-Reply-To: <20060719122905.GB24800@turing.informatik.uni-halle.de>
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

--===============1211838670==
Content-Type: multipart/alternative;
	boundary="----=_Part_106867_19499930.1155177953806"

------=_Part_106867_19499930.1155177953806
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Clemens,

I am half way my development. I can stream music using dynamic settings (any
speaker plugged in to my host be heard of some music when my application is
streaming some audio data). However, there are still background noise I am
hearing. Here is how I computed my streaming size:

sampling rate = 44100
channel = 2
bit resolution = 16
period length = 20 ms
period size = 3528

This period size is used as my buffer size, and this is sliced as it is
streamed to my device.
I have not considered any sychronization yet. Here is the speaker
configuration:
Synchronization type = adaptive sync
polling interval = 1 ms
refresh = 00
syncaddress = 0

My understanding is no sync pipe is defined  by the device, therefore I dont
need to schedule any sync data, am I correct?
I hope I can  be given some enlightenment in this issue. Any help will be
greatly appreciated.
Thank you very much.

regards,

Grace



On 7/19/06, Clemens Ladisch <clemens@ladisch.de> wrote:
>
> Grace Baldonasa wrote:
> > yes, i did set the alternate setting. The currrent endpoint should be
> able
> > to handle the stream data since the maxpacketsize is 56, the max
> sampling
> > rate it support is 55kHz, but as I mentioned in my previous email, it's
> only
> > noise that I can hear from the speaker.
>
> What is the output of "lsusb -v" for this device?
>
> > I used a converted raw data in hex format, I am not really sure what is
> the
> > sampling bit, sampling rate or number of channels used when conversion
> was
> > made to the raw data, I am in doubt the sampling bit / channels
> does  not
> > fit with my experimentations.
> >
> > Can you recommend some application that will allow me to convert small
> wav
> > to hex as array of characters that I could use to stream.
>
> Some Python script like this:
>
> f = open("something.wav", "rb")
> while 1:
>        c = f.read(1)
>        if not c:
>                break
>        print "0x%02x," % ord(c)
> f.close()
>
>
> HTH
> Clemens
>

------=_Part_106867_19499930.1155177953806
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi Clemens,</div>
<div>&nbsp;</div>
<div>I am half way my development. I can stream music using dynamic settings (any speaker plugged in to my host be heard of some music when my application is streaming some audio data). However, there are still background noise I am hearing. Here is how I computed my streaming size:
</div>
<div>&nbsp;</div>
<div>sampling rate = 44100</div>
<div>channel = 2</div>
<div>bit resolution = 16</div>
<div>period length = 20 ms</div>
<div>period size = 3528</div>
<div>&nbsp;</div>
<div>This period size is used as my buffer size, and this is sliced as it is streamed to my device.<br>I have not considered any sychronization yet. Here is the speaker configuration:</div>
<div>Synchronization type = adaptive sync</div>
<div>polling interval = 1 ms</div>
<div>refresh = 00</div>
<div>syncaddress = 0</div>
<div>&nbsp;</div>
<div>My understanding is no sync pipe is defined&nbsp; by the device, therefore I dont need to schedule any sync data, am I correct?</div>
<div>I hope I can&nbsp; be given some enlightenment in this issue. Any help will be greatly appreciated.</div>
<div>Thank you very much.</div>
<div>&nbsp;</div>
<div>regards,</div>
<div>&nbsp;</div>
<div>Grace</div>
<div><br><br>&nbsp;</div>
<div><span class="gmail_quote">On 7/19/06, <b class="gmail_sendername">Clemens Ladisch</b> &lt;<a href="mailto:clemens@ladisch.de">clemens@ladisch.de</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Grace Baldonasa wrote:<br>&gt; yes, i did set the alternate setting. The currrent endpoint should be able<br>
&gt; to handle the stream data since the maxpacketsize is 56, the max sampling<br>&gt; rate it support is 55kHz, but as I mentioned in my previous email, it's only<br>&gt; noise that I can hear from the speaker.<br><br>What is the output of &quot;lsusb -v&quot; for this device?
<br><br>&gt; I used a converted raw data in hex format, I am not really sure what is the<br>&gt; sampling bit, sampling rate or number of channels used when conversion was<br>&gt; made to the raw data, I am in doubt the sampling bit / channels does&nbsp;&nbsp;not
<br>&gt; fit with my experimentations.<br>&gt;<br>&gt; Can you recommend some application that will allow me to convert small wav<br>&gt; to hex as array of characters that I could use to stream.<br><br>Some Python script like this:
<br><br>f = open(&quot;something.wav&quot;, &quot;rb&quot;)<br>while 1:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; c = f.read(1)<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; if not c:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; break<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; print &quot;0x%02x,&quot; % ord(c)<br>f.close()<br><br><br>HTH<br>Clemens
<br></blockquote></div><br>

------=_Part_106867_19499930.1155177953806--


--===============1211838670==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1211838670==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1211838670==--
