From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: upmixing line in - emu10k1 sb live 5.1
Date: Mon, 14 Feb 2005 15:27:19 -0500
Message-ID: <1108412839.28815.2.camel@krustophenia.net>
References: <200502140720.j1E7JtHo012669@www4.pobox.sk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <200502140720.j1E7JtHo012669@www4.pobox.sk>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Peter Zubaj <pzad@pobox.sk>
Cc: dwhthompson@yahoo.co.uk, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 2005-02-14 at 08:20 +0100, Peter Zubaj wrote:
> Hi,
> 
> AFAIK there is no way to upmix line in to 5.1 in alsa default config
> for sb live.
> 
> Audigy is diffrent.
> 
> Maybe if you use ld10k1, this will do upmix (init_live script).
> 

I am working on improving the default DSP config for the SBLive.  There
are many problems with it, the lack of master volume being the worst.

In order to have enough GPRs to solve this and the master volume problem
then some features will have to go.  Like the redundant "switch"
controls (the same thing could be accomplished by setting volume to 0).

Lee



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
