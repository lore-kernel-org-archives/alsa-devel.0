From: Mikael Magnusson <mikaelmagnusson@glocalnet.net>
Subject: Re: upmixing line in - emu10k1 sb live 5.1
Date: Wed, 16 Feb 2005 13:02:13 +0100
Message-ID: <42133645.6060304@glocalnet.net>
References: <200502140720.j1E7JtHo012669@www4.pobox.sk> <1108412839.28815.2.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
In-Reply-To: <1108412839.28815.2.camel@krustophenia.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Lee Revell wrote:
> On Mon, 2005-02-14 at 08:20 +0100, Peter Zubaj wrote:
> 
>>Hi,
>>
>>AFAIK there is no way to upmix line in to 5.1 in alsa default config
>>for sb live.
>>
>>Audigy is diffrent.
>>
>>Maybe if you use ld10k1, this will do upmix (init_live script).
>>
> 
> 
> I am working on improving the default DSP config for the SBLive.  There
> are many problems with it, the lack of master volume being the worst.
> 

Nice, do you intend to separate the default and front pcm devices? 
Currently it isn't possible to play one sound on the front speakers and 
one sound on both front and rear speakers at the same time. My 
proposition is to use FX 8 and 9 for the front device, as on Audigy.

> In order to have enough GPRs to solve this and the master volume problem
> then some features will have to go.  Like the redundant "switch"
> controls (the same thing could be accomplished by setting volume to 0).
> 
> Lee
> 
> 

Most users probably don't have a live drive and can't use several of the 
inputs that are activated in the default configuration. What if some of 
the new features are made optional and can be used only if some of the 
inputs or outputs are disabled in the extin and extout module parameters?

/Mikael Magnusson


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
