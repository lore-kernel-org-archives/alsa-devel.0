From: "Stefano D'Angelo" <zanga.mail@gmail.com>
Subject: USB sound card driver - Line6 Toneport UX1
Date: Thu, 8 Jun 2006 18:43:19 +0200
Message-ID: <160c13350606080943v3171dc13je7160710b847de29@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1712086650=="
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
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

--===============1712086650==
Content-Type: multipart/alternative;
	boundary="----=_Part_5365_10558544.1149784999968"

------=_Part_5365_10558544.1149784999968
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello again,
I've done some work on the driver in my spare time, implementing DMA and
cleaning the code.
What I'd like to know now is this: where do I actually have to submit urbs?
In which callback? I tried to do this in the pointer callback, since it's
the only callback which is called constantly in time, but it was a bad idea
since the data changed everytime. (I mean that the dma_area pointed to
different data even in the same position at different calls).
So... how should this be done?
Thanks!

------=_Part_5365_10558544.1149784999968
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello again,<br>I've done some work on the driver in my spare time, implementing DMA and cleaning the code.<br>What I'd like to know now is this: where do I actually have to submit urbs? In which callback? I tried to do this in the pointer callback, since it's the only callback which is called constantly in time, but it was a bad idea since the data changed everytime. (I mean that the dma_area pointed to different data even in the same position at different calls).
<br>So... how should this be done?<br>Thanks!<br>

------=_Part_5365_10558544.1149784999968--


--===============1712086650==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1712086650==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--===============1712086650==--
