From: Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: [linux-audio-user] Re: [linux-audio-dev] Re: [Alsa-devel]
 Firewire Audio Card Support
Date: Fri, 19 Nov 2004 00:52:48 +0100
Message-ID: <20041119005248.6127aacf@mango.fruits.de>
References: <31148074.1100630541337.JavaMail.root@scooter.psp.pas.earthlink.net>
	<419C9D47.4090606@x-i.net>
	<200411181515.52218.olaf@solutionworks.de>
	<20041118143205.GA21282@login.ecs.soton.ac.uk>
	<419CB554.3080709@esitcom.org>
	<Pine.LNX.4.58.0411181601440.14962@denise.shiny.it>
	<1100809010.10150.5.camel@krustophenia.net>
	<1100818169.3464.6.camel@eviltwin>
	<5bdc1c8b04111814545ab84738@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <5bdc1c8b04111814545ab84738@mail.gmail.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
Cc: markknecht@gmail.com, A list for linux audio users <linux-audio-user@music.columbia.edu>, Amaury Jacquot <sxpert@esitcom.org>, alsa-devel <alsa-devel@lists.sourceforge.net>, Giuliano Pochini <pochini@denise.shiny.it>, The Linux Audio Developers' Mailing List <linux-audio-dev@music.columbia.edu>, Steve Harris <s.w.harris@ecs.soton.ac.uk>
List-Id: alsa-devel@alsa-project.org

On Thu, 18 Nov 2004 14:54:27 -0800
Mark Knecht <markknecht@gmail.com> wrote:

> I've had this sort of project on my mind for a year or two. (Since my
> first run in with the HDSP 9652 under Linux in early 2003.) I am,
> unlike I think many people here, a hardware designer by trade. Mostly
> chips, but my engineers had done boards for our chips.
> 
> Coincedentally I was laid off yesterday and am sitting at home
> thinking about what to do with myself during my current delimma...

Hi,

maybe you can tell us then how much the components for such a simple pcm
only soundcard would cost? What's nessecary? And i mean really simple. Just
a single full duplex stereo pcm device. No mixer (who needs a mixer? Real
men have their mixer sitting in a rack :))

- 2 AD's and 2 DA's 
- a dsp (is it really nessecary?)
- some memory for the buffers
- a pci board
- pci logic (raising irq's, doing the transfers)
- some "glue"

i may be naive though as i really have no idea about the hw side of things.
Especially it gets tricky when allowing all kinds of different sample
rates/buffer sizes, etc. And of course i suppose the price is heavily
dependent on the quality of the components. But what would be lower and
upper bounds for the components alone? And what kind of work is nessecary
(how many manhours)

- to design the thing

- to build the thing

?

Florian Schmidt


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
