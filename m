From: Christian Guggenberger <Christian.Guggenberger@physik.uni-regensburg.de>
Subject: Re: oops while unloading snd-intel8x0
Date: Tue, 14 Jan 2003 13:28:26 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030114132826.E22124@pc9391.uni-regensburg.de>
References: <20030110123732.GE986@electra.intern.planb.de>
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030110123732.GE986@electra.intern.planb.de>; from Enrik.Berkhan@planb.de on Fri, Jan 10, 2003 at 13:37:32 +0100
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Enrik Berkhan <Enrik.Berkhan@planb.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 10.01.2003   13:37 Enrik Berkhan wrote:
> Hi,
> 
> At Tue, 10 Dec 2002 08:39:35 -0800, Takashi Iwai wrote:
> > At Tue, 10 Dec 2002 13:50:31 +0100, Christian Guggenberger wrote:
> > > I get following oops while unloading snd-intel8x0 on a Dell Optiplex 260
> > hmm, it's a new type of oops, which i've never seen.
> 
> I had the same problem using a Gericom Frontman (SiS 7012). It turned out
> that unregistering the joystick_driver while no joystick had been found
> on init caused the oops. Proposed patch:
> 
---snip---

ahh, this one also fixes the oops I got that Dell GX260!

thanx,

Christian


-------------------------------------------------------
This SF.NET email is sponsored by: FREE  SSL Guide from Thawte
are you planning your Web Server Security? Click here to get a FREE
Thawte SSL guide and find the answers to all your  SSL security issues.
http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0026en
