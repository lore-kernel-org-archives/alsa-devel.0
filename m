From: Jaroslav Kysela <perex@suse.cz>
Subject: Re: [Alsa-devel] copy pcm plugin
Date: Wed, 28 Jan 2004 19:46:34 +0100 (CET)
Sender: alsa-user-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0401281945200.2015@pnote.perex-int.cz>
References: <20040128180546.4cc88584.mista.tapas@gmx.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-user-admin@lists.sourceforge.net>
In-Reply-To: <20040128180546.4cc88584.mista.tapas@gmx.net>
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: Florian Schmidt <mista.tapas@gmx.net>
Cc: alsa-user@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Wed, 28 Jan 2004, Florian Schmidt wrote:

> 
> Hi, as far as i understand it, the copy plugin does nothing but copy its
> input to its output. I wonder if it would be easily possible to extend
> this plugin to copy to multiple slave pcms. This way it would be
> (easily?) possible to "distribute" a stereo signal to 4 or even 6
> channels.
> 
> Any thoughts? Maybe i just misunderstood the pcm copy docs though..

Yes, copy is a simple optimized variation of the route plugin, but you 
need to merge stereo devices with "multi" plugin to the multichannel 
device at first.

						Jaroslav

-----
Jaroslav Kysela <perex@suse.cz>
Linux Kernel Sound Maintainer
ALSA Project, SuSE Labs


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
