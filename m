From: Giuliano Pochini <pochini@shiny.it>
Subject: RE: Lynx AES16 driver
Date: Tue, 20 Jan 2004 09:40:36 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <XFMail.20040120094036.pochini@shiny.it>
References: <1074532503.3031.33.camel@gentoo>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1074532503.3031.33.camel@gentoo>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Michal Kostrzewa <m.kostrzewa@pentacomp.com.pl>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


On 19-Jan-2004 Michal Kostrzewa wrote:
> Hello,
>
> Please help me in that license related case:
> I want to write a Lynx AES16 (http://www.lynxstudio.com/aes16.html) ALSA
> driver (I'm from Warsaw University of Technology and we want to use this
> card in our investigations). I wrote to Lynxstudio, and I received an
> answer that driver related specs are accessible under terms of
> Non-Disclosure Agreement which doesn't allow distribution of source code
> or any derived materials thus preventing development of ALSA driver as
> ALSA drivers are open source.

Yes, I got the same answer when I asked about the LynxTwo.


> My question is: has an ALSA driver to be an open source?

Yes, otherwise you have to release binary drivers for each ALSA version,
kernel version, compiler, architecture.  It's impossible.

> On www.alsa-project.org there is a sentence: "ALSA is released under the
> GPL (GNU General Public license) and the LGPL (GNU Lesser General Public
> License)." (please note the LGPL). I understand, that there can be a
> driver distributed in binary form (e.g in fact firmware needed to run
> hdsp are distributed in binary form), GPL means that you cannot close
> the ALSA core framework.

If you split your driver in two parts: one (GPL) that interfaces with ALSA
and the real driver (non-GPL). There are many examples. eg. The ToucamPro
webcam driver, Nvidia drivers and my driver for Echoaudio soundcards.


> Is this whole situation hopeless? Have I any arguments to use in the
> discussion with Lynxstudio?

Yep :(  They don't like the "invasive" GPL. I can't understand those
people. We are speaking about a *driver*. The card is the product they
sell. Customers don't buy the card because they need to use the driver.


--
Giuliano.


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
