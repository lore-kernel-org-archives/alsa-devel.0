From: Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: Can I mix more sources when oss device is taken ?
Date: Sun, 4 Jul 2004 14:37:34 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040704143734.32eb3c85@mango.fruits.de>
References: <047701c461bb$cf03d510$ef4902c1@Lapitopi>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <047701c461bb$cf03d510$ef4902c1@Lapitopi>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Robert Rozman <rozman@fri.uni-lj.si>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sun, 4 Jul 2004 13:41:12 +0200
"Robert Rozman" <rozman@fri.uni-lj.si> wrote:

> Hi,
> 
> I'm using mythtv (great PVR gui app) and currently it seems like it's native
> alsa support is broken (oss works ok). So I have to give up dmix access and
> get exclusive access to sound device to mythtv only (through oss emulation
> on dev/dsp).
> 
> But since I'd love to be able to access sound device also from other apps
> (for speech synthesis, messages):
> - I wonder if there is possibility to somehow mix other sounds coming from
> dmix or native alsa interfaces to oss one
> - how to easily check if oss device is taken (possibly with some CLI tool) ?
> - are there any other possibilities for workaround ?
> 
> Thanks in advance,
> 
> Robert.

Have a look at the alsa-oss package [includeing the aoss script].. More info here:

http://alsa.opensrc.org/index.php?page=aoss


-- 
Palimm Palimm!
http://affenbande.org/~tapas/wiki



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
