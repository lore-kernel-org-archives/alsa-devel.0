From: "Jon Masters" <jonathan@jonmasters.org>
Subject: Re: re.Fix hang in mpu401_uart.c patch
Date: Tue, 16 May 2006 18:50:15 +0100
Message-ID: <35fb2e590605161050r63959b08h4f85e1d6cff54f6d@mail.gmail.com>
References: <200605101556.50928.gineera@aspect135.co.uk>
	 <s5hejz03baa.wl%tiwai@suse.de>
	 <200605131304.49711.gineera@aspect135.co.uk>
	 <200605152245.45507.gineera@aspect135.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200605152245.45507.gineera@aspect135.co.uk>
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alan Horstmann <gineera@aspect135.co.uk>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@lists.sourceforge.net, jcm@jonmasters.org
List-Id: alsa-devel@alsa-project.org

Ok. I signed up to alsa-devel and read the thread...

On 5/15/06, Alan Horstmann <gineera@aspect135.co.uk> wrote:

> > > > However, as the 3rd augument is '0' ie don't check ACK, OK is alway=
s
> > > > true in snd_mpu401_uart_cmd and there is surely no point to the ext=
ra
> > > > check lines?

IIRC I added the extra checks you refer to for completeness (it's bad
form not to check return), but the error path in snd_mpu401_uart_cmd
is getting called on my system when it's called during init -
printk()ing a warning is useless, the function should return an error.

What's the problem anyway that you're experiencing?

Jon.


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
