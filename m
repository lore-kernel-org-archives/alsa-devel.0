From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: A7N8X Deluxe - Alsa Support???
Date: Mon, 20 Oct 2003 09:36:29 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F939E8D.1040101@superbug.demon.co.uk>
References: <200310200709.JAA27464@www4.pobox.sk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200310200709.JAA27464@www4.pobox.sk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: p z oooo <pzad@pobox.sk>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

p z oooo wrote:
>>Good luck.
> 
> 
>>When I told them my nForce board supported hardware mixing, based 
> 
> upon
> 
>>nVidia's documentation, I was told, flat out, I was wrong...
> 
> 
>>I hate to sound like a conspiracy theorist, but I think it was easy 
> 
> for
> 
>>them to patch up the i810 module to support the nForce, and that
>>driver's current architecture doesn't allow for advanced features 
> 
> like
> 
>>hardware mixing.
> 
> 
>>The A7N8X, IIRC, uses the nForce2 chip, which uses the same driver, 
> 
> so
> 
>>you're likely as SOL as I was.
> 
> 
>>Sorry.
> 
> 
>>I hope you have better luck with the devs than I did, though.
> 
> 
>>Rob
> 
> 
> This is not fault of ALSA developers, this is fault of NVIDIA which 
> not release datasheets for their chips. This is becase many firms 
> lying customers and instead selling chips there are selling software 
> drivers (which are mostly free in linux) maybe this is case of 
> NVIDIA. I personally don't trust NVIDIA.
> 
> Peter Zubaj
> 
> 

The nforce motherboards actually have 2 audio PCI devices. One is the 
codec controller, which uses the alsa snd-intel8x0. It works ok in linux 
apparently, but I am not sure about whether it has multiopen/hardware 
mixing features or not as I don't own one to test.
The second audio PCI device on nforce motherboards is an Audio DSP, and 
we have no datasheets for this Audio chip, so cannot support the fancy 
realtime hardware based audio effects it may or may not be able to do.

Cheers
James



-------------------------------------------------------
This SF.net email sponsored by: Enterprise Linux Forum Conference & Expo
The Event For Linux Datacenter Solutions & Strategies in The Enterprise 
Linux in the Boardroom; in the Front Office; & in the Server Room 
http://www.enterpriselinuxforum.com
