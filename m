From: "Stefano D'Angelo" <zanga.mail@gmail.com>
Subject: Re: Line6 TonePort
Date: Fri, 11 Aug 2006 22:07:52 +0200
Message-ID: <160c13350608111307w5a0778ffm4aa01046c95f1132@mail.gmail.com>
References: <160c13350608100919yee3fc8p14096f59aa0071f7@mail.gmail.com>
	<1155316913.11766.268179999@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0543481057=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1155316913.11766.268179999@webmail.messagingengine.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

--===============0543481057==
Content-Type: multipart/alternative;
	boundary="----=_Part_53905_24490795.1155326872609"

------=_Part_53905_24490795.1155326872609
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Markus: I use USB Snoopy Pro and I'm sure that packet sizes are ok, I'm just
trying to do as the Windows' driver does.

Clemens:
> No USB device supports DMA transfers.  USB devices support USB transfers.
> The host controller supports DMA transfers.  Yours does, too.
Well, I thought so. But I even modified snd-usb-audio driver (quirks + other
code) to support this card and what I get out of it is the same thing I got
when I tried with DMA on my own: a kind of buzz sound that sometimes
continues after stopping the playback.
As you can see from the code I posted I'm not going this way, I'm copying
the data from runtime->dma_area into the URB transfer_buffer I allocate.

> You should copy the data just before you submit the URB.  In other words,
> yes.
I copy and send in the same function, is it right?

> How do you determine how much data to send in each USB frame?
I use fixed sizes (as the windows' driver do). In snd_toneport.h each size
is specified according to the different altsettings. Each URB has 2 isoch.
packets of the same size.

Stefano

------=_Part_53905_24490795.1155326872609
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Markus: I use USB Snoopy Pro and I'm sure that packet sizes are ok, I'm just trying to do as the Windows' driver does.<br><br>Clemens:<br>&gt; No USB device supports DMA transfers. &nbsp;USB devices support USB transfers.<br>&gt; The host controller supports DMA transfers. &nbsp;Yours does, too.
<br>Well, I thought so. But I even modified snd-usb-audio driver (quirks + other code) to support this card and what I get out of it is the same thing I got when I tried with DMA on my own: a kind of buzz sound that sometimes continues after stopping the playback.
<br>As you can see from the code I posted I'm not going this way, I'm copying the data from runtime-&gt;dma_area into the URB transfer_buffer I allocate.<br><br>&gt; You should copy the data just before you submit the URB. &nbsp;In other words,
<br>&gt; yes.<br>I copy and send in the same function, is it right?<br><br>&gt; How do you determine how much data to send in each USB frame?<br>I use fixed sizes (as the windows' driver do). In snd_toneport.h each size is specified according to the different altsettings. Each URB has 2 isoch. packets of the same size.
<br><br>Stefano<br><br>

------=_Part_53905_24490795.1155326872609--


--===============0543481057==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0543481057==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============0543481057==--
