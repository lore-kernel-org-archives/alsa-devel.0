From: torben hohn <torbenh@gmx.de>
Subject: Re: EMU10K1 DSP programs
Date: 18 Sep 2002 04:48:11 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E17rUrC-0005qY-00@usw-sf-list1.sourceforge.net>
References: <1032184672.416.5.camel@diesel>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1032184672.416.5.camel@diesel>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: Martin Soto <soto@informatik.uni-kl.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On 16 Sep 2002 15:57:52 +0200, Martin Soto wrote:
> Hi all!
> 
> Is it possible to load DSP programs to the EMU10K1 chip?  The alsa-tools
> package contains a modified as10k1 that allows you to assemble such
> programs, but there's no information about how to upload them to the
> processor.

i have not tried it out but there are some ioctl which allow you to poke
and peek
the dsp instruction memory.

ALSA uses a fair amount of dsp code for its own. I am not quite sure
what has to be done to remove the alsa dsp code (remove the mixers
controling
the gprs etc)

have a look at
alsa-kernel/pci/emu10k1/emufx.c

And if you have any success tell me.
I would like to load up patches into the DSP too.





-------------------------------------------------------
This SF.NET email is sponsored by: AMD - Your access to the experts
on Hammer Technology! Open Source & Linux Developers, register now
for the AMD Developer Symposium. Code: EX8664
http://www.developwithamd.com/developerlab
