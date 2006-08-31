From: "Grace Baldonasa" <gbaldona@gmail.com>
Subject: Re: question about sampling rate
Date: Thu, 31 Aug 2006 17:50:40 +0800
Message-ID: <7034e7b50608310250w77fe2d21va4b0593b66f5d9d8@mail.gmail.com>
References: <54799.217.150.108.178.1152694606.squirrel@newgolddream.dyndns.info>
	<7034e7b50607181827u6ddc9cb5s8585978e80a7af9b@mail.gmail.com>
	<20060719122905.GB24800@turing.informatik.uni-halle.de>
	<7034e7b50608091945r39ddaeeevda675f05251be9cb@mail.gmail.com>
	<1155315961.10237.268179763@webmail.messagingengine.com>
	<7034e7b50608302232w2b7279b3qf66acaeca54f1e2b@mail.gmail.com>
	<1157012237.11592.269833216@webmail.messagingengine.com>
	<7034e7b50608310122na613dcesf642709d586fbde5@mail.gmail.com>
	<1157014147.13855.269835275@webmail.messagingengine.com>
	<7034e7b50608310210h59217352tb99c8189b228a4e3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0658569635=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.182])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9CA882AF
	for <alsa-devel@alsa-project.org>;
	Thu, 31 Aug 2006 11:51:15 +0200 (MEST)
Received: by py-out-1112.google.com with SMTP id c59so729935pyc
	for <alsa-devel@alsa-project.org>; Thu, 31 Aug 2006 02:50:41 -0700 (PDT)
In-Reply-To: <7034e7b50608310210h59217352tb99c8189b228a4e3@mail.gmail.com>
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

--===============0658569635==
Content-Type: multipart/alternative;
	boundary="----=_Part_62680_1506687.1157017840918"

------=_Part_62680_1506687.1157017840918
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Clemens,

Got another question, following to my previos emails, do I have to adjust my
streaming size since the sampling freq used when audio data was converted is
not supported by the speaker? if I do adjust the streaming size, I am
compromising the bit resolution and the sampling rate already?

Thanks in advance.

regards,
grace


On 8/31/06, Grace Baldonasa <gbaldona@gmail.com> wrote:
>
>  OK!
> Now I understand. Thanks for all the info.
>
> grace
>
>
>  On 8/31/06, Clemens Ladisch <cladisch@fastmail.net> wrote:
>
> > Grace Baldonasa wrote:
> > > What do you mean when you said Windows had converted it to 48000 Hz,
> > you
> > > mean the audio data itself is converted or just the sampling rate
> > factor
> > > in the computation.
> >
> > Windows likes to convert the data to the highest sample rate supported
> > by the device so that the audio quality doesn't suffer when a stream
> > with a higher sample rater must be mixed in later.
> >
> > > When I took a CATC trace using ALSA version, it is also using a fixed
> > 176
> > > bytes / packet, I am missing something here?
> >
> > For a 44.1 kHz stream, snd-usb-audio uses packets with both 176 and 180
> > bytes.
> >
> >
> > Regards,
> > Clemens
> >
>
>
>

------=_Part_62680_1506687.1157017840918
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi Clemens,</div>
<div>&nbsp;</div>
<div>Got another question, following to my previos emails, do I have to adjust my streaming size since the sampling freq used when audio data was converted is not supported by the speaker? if I do adjust the streaming size, I am compromising the bit resolution and the sampling rate already?
</div>
<div>&nbsp;</div>
<div>Thanks in advance.</div>
<div>&nbsp;</div>
<div>regards,</div>
<div>grace<br><br>&nbsp;</div>
<div><span class="gmail_quote">On 8/31/06, <b class="gmail_sendername">Grace Baldonasa</b> &lt;<a href="mailto:gbaldona@gmail.com">gbaldona@gmail.com</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">
<div>
<div>OK!</div>
<div>Now I understand. Thanks for all the info.</div></div>
<div><span class="sg">
<div>&nbsp;</div>
<div>grace<br><br>&nbsp;</div></span></div>
<div>
<div></div>
<div><span class="q"><span class="gmail_quote">On 8/31/06, <b class="gmail_sendername">Clemens Ladisch</b> &lt;<a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:cladisch@fastmail.net" target="_blank">
cladisch@fastmail.net</a>&gt; wrote:</span> </span></div>
<div><span class="e" id="q_10d637ebb4c7a480_4">
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Grace Baldonasa wrote:<br>&gt; What do you mean when you said Windows had converted it to 48000 Hz, you<br>
&gt; mean the audio data itself is converted or just the sampling rate factor<br>&gt; in the computation.<br><br>Windows likes to convert the data to the highest sample rate supported<br>by the device so that the audio quality doesn't suffer when a stream 
<br>with a higher sample rater must be mixed in later.<br><br>&gt; When I took a CATC trace using ALSA version, it is also using a fixed 176<br>&gt; bytes / packet, I am missing something here?<br><br>For a 44.1 kHz stream, snd-usb-audio uses packets with both 176 and 180 
<br>bytes.<br><br><br>Regards,<br>Clemens<br></blockquote></span></div>
<div></div><br>&nbsp;</div></blockquote></div><br>

------=_Part_62680_1506687.1157017840918--


--===============0658569635==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0658569635==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0658569635==--
