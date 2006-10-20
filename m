From: "Markus Rechberger" <mrechberger@gmail.com>
Subject: Re: Snd-usb-audio and usb-phones.
Date: Fri, 20 Oct 2006 12:52:16 +0200
Message-ID: <d9def9db0610200352o2d5c8de7v1d9db9ef7c3a0a72@mail.gmail.com>
References: <20061020083657.GA8792@localhost>
	<1161338029.17815.273804883@webmail.messagingengine.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1161338029.17815.273804883@webmail.messagingengine.com>
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
To: Clemens Ladisch <cladisch@fastmail.net>
Cc: "K. A." <deb.lists@gmail.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

On 10/20/06, Clemens Ladisch <cladisch@fastmail.net> wrote:
> K.A. wrote:
> >  I bought a noname usb ip-phone. So when plugging it in, your driver
> >  snd-usb-audio is used. So I decided to ask whether you know if drivers
> >  for such devices exist.
>
> Yes, a driver for USB audio devices does exist.
> Its name is snd-usb-audio.
>

I think it's better to split of usb phones, since they usually have
input keys, CSID, ring detection (if it's a usb phone gateway),
support ringing, hang up/off detection etc.

Asterisk dev guys have lot of experience in the telco area and how
they could implement such devices so it would be nice to get in
contact with some of them.
I also saw userspace libs out there that interface such devices using
usbfs, seems like it works fine for them too.
USB Phones usually only support around 8000 - 9600hz

snd-usb-audio is just fine for standard usbaudio stuff (which isn't
done 100% at the moment either) also hotplugging a device when it's in
use doesn't seem to work with it correctly yet.

cheers,
Markus

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
