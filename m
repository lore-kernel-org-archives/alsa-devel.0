From: Fedor Karpelevitch <fedor@apache.org>
Subject: Re: [2.4]ALi M5451 sound hangs on init; workaround
Date: Wed, 11 Dec 2002 11:42:31 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200212111142.31709.fedor@apache.org>
References: <200212110715.20617.fedor@apache.org> <200212111036.21771.fedor@apache.org> <1039635588.18587.8.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1039635588.18587.8.camel@irongate.swansea.linux.org.uk>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: lkml <linux-kernel@vger.kernel.org>, Vicente Aguilar <bisente@bisente.com>, alsa-devel@lists.sourceforge.net, Debian-Laptops <debian-laptop@lists.debian.org>
List-Id: alsa-devel@alsa-project.org

> On Wed, 2002-12-11 at 18:36, Fedor Karpelevitch wrote:
> > almost as I posted before, just passing pointers to the read
> > method. It works, but the question as to what is this supposed to
> > affect remains...
>
> If I am reading the docs right then its just a thinko in the code
> and it is meant to be toggling that bit not whacking the entire
> register.

So I wonder what toggling those bits is supposed to change. I would 
test that somehow then


-------------------------------------------------------
This sf.net email is sponsored by:
With Great Power, Comes Great Responsibility 
Learn to use your power at OSDN's High Performance Computing Channel
http://hpc.devchannel.org/
