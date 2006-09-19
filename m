From: "Grace Baldonasa" <gbaldona@gmail.com>
Subject: Re: question about sampling rate
Date: Tue, 19 Sep 2006 17:36:23 +0800
Message-ID: <7034e7b50609190236o5852e98aqa544299cf8f9feb4@mail.gmail.com>
References: <54799.217.150.108.178.1152694606.squirrel@newgolddream.dyndns.info>
	<7034e7b50608091945r39ddaeeevda675f05251be9cb@mail.gmail.com>
	<1155315961.10237.268179763@webmail.messagingengine.com>
	<7034e7b50608302232w2b7279b3qf66acaeca54f1e2b@mail.gmail.com>
	<1157012237.11592.269833216@webmail.messagingengine.com>
	<7034e7b50608310122na613dcesf642709d586fbde5@mail.gmail.com>
	<1157014147.13855.269835275@webmail.messagingengine.com>
	<7034e7b50608310210h59217352tb99c8189b228a4e3@mail.gmail.com>
	<7034e7b50608310250w77fe2d21va4b0593b66f5d9d8@mail.gmail.com>
	<1157021412.24248.269842218@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1880438372=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.182])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8569724D
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Sep 2006 11:36:27 +0200 (MEST)
Received: by py-out-1112.google.com with SMTP id c59so5790358pyc
	for <alsa-devel@alsa-project.org>; Tue, 19 Sep 2006 02:36:24 -0700 (PDT)
In-Reply-To: <1157021412.24248.269842218@webmail.messagingengine.com>
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

--===============1880438372==
Content-Type: multipart/alternative;
	boundary="----=_Part_3924_13279367.1158658583782"

------=_Part_3924_13279367.1158658583782
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

Do you know of any means how to test the streaming IN raw data. I am
attaching a headset and could only test the speaker or streaming OUT. I need
to test as well the streaming IN.

I am writing every single byte I received into a buffer, and after some
period,  I am streaming it out again, but I can only hear noise and no
clarity in the quality of the audio captured.

My captured settings are as follows:
Sampling Freq = 48000
Channel = 1
Sampling Bit = 16

when i streamed it out, the playback settings are as follows:
 Sampling Freq = 48000
Channel = 2
Sampling Bit = 16

I forcefully change the channel number to 2, would this cause any problem?
Any advise can be deeply appreciated.
Thanks.

regards,

Grace



On 8/31/06, Clemens Ladisch <cladisch@fastmail.net> wrote:
>
> Grace Baldonasa wrote:
> > Got another question, following to my previos emails, do I have to
> adjust my
> > streaming size since the sampling freq used when audio data was
> converted is
> > not supported by the speaker?
>
> ALSA will allow only those sample rates/formats that the driver says it
> supports (in the snd_pcm_hardware structure, and with any constraints
> set in the open callback).
>
>
> HTH
> Clemens
>

------=_Part_3924_13279367.1158658583782
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi,</div>
<div>&nbsp;</div>
<div>Do you know of any means how to test the streaming IN raw data. I am attaching a headset and could only test the speaker or streaming OUT. I need to test as well the streaming IN.</div>
<div>&nbsp;</div>
<div>I am writing every single byte I received into a buffer, and after some period,&nbsp; I am streaming it out again, but I can only hear noise and no clarity in the quality of the audio captured. </div>
<div>&nbsp;</div>
<div>My captured settings are as follows:</div>
<div>Sampling Freq = 48000</div>
<div>Channel = 1</div>
<div>Sampling Bit = 16</div>
<div>&nbsp;</div>
<div>when i streamed it out, the playback settings are as follows:</div>
<div>
<div>Sampling Freq = 48000</div>
<div>Channel = 2</div>
<div>Sampling Bit = 16</div>
<div>&nbsp;</div>
<div>I forcefully change the channel number to 2, would this cause any problem?</div>
<div>Any advise can be deeply appreciated.</div>
<div>Thanks.</div>
<div>&nbsp;</div>
<div>regards,</div>
<div>&nbsp;</div>
<div>Grace</div></div>
<div><br><br>&nbsp;</div>
<div><span class="gmail_quote">On 8/31/06, <b class="gmail_sendername">Clemens Ladisch</b> &lt;<a href="mailto:cladisch@fastmail.net">cladisch@fastmail.net</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Grace Baldonasa wrote:<br>&gt; Got another question, following to my previos emails, do I have to adjust my
<br>&gt; streaming size since the sampling freq used when audio data was converted is<br>&gt; not supported by the speaker?<br><br>ALSA will allow only those sample rates/formats that the driver says it<br>supports (in the snd_pcm_hardware structure, and with any constraints
<br>set in the open callback).<br><br><br>HTH<br>Clemens<br></blockquote></div><br>

------=_Part_3924_13279367.1158658583782--


--===============1880438372==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1880438372==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1880438372==--
