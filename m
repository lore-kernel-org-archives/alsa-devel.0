From: "Markus Rechberger" <mrechberger@gmail.com>
Subject: Re: Line6 TonePort
Date: Thu, 10 Aug 2006 18:32:58 +0200
Message-ID: <d9def9db0608100932l20d659b7p416057585eab686b@mail.gmail.com>
References: <160c13350608100919yee3fc8p14096f59aa0071f7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <160c13350608100919yee3fc8p14096f59aa0071f7@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Stefano D'Angelo <zanga.mail@gmail.com>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

do you reverse engineer that driver, or do you have any specs?

Markus

On 8/10/06, Stefano D'Angelo <zanga.mail@gmail.com> wrote:
> I hope this is the last time I write but I don't think so.
> The problem is quite simple: this USB card does not support DMA transfers
> (yes, seems impossible but that's what it is), so a support for this sound
> card is difficult to obtain working on the snd-usb-audio module, Takashi
> told me to use an intermediate buffer, but I really don't know how to do it.
> Should I copy data from the buffer (playback) on usb transfer completition
> callbacks? But in such case isn't it the same to just copy data into the
> urb's transfer buffer?
> I tried to avoid using this buffer and what I obtain is something that
> resembles what the card should be playing but with huge noise.
> Please help!
>
> Stefano
>
>


-- 
Markus Rechberger

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
