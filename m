From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: Bug in ALSA OSS mixer emulation. Volume++ does not
 work.
Date: Wed, 03 Dec 2003 21:36:57 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FCE5779.3010205@superbug.demon.co.uk>
References: <3FCD5830.2000702@superbug.demon.co.uk> <Pine.LNX.4.58.0312030924420.12963@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.58.0312030924420.12963@pnote.perex-int.cz>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Jaroslav Kysela wrote:
> On Wed, 3 Dec 2003, James Courtier-Dutton wrote:
> 
> 
>>Hi,
>>
>>  The alsa keeps state of all mixer levels in alsa's internal format 
>>which has min,max info. So, for example if alsa has 0-31 levels, 
>>converting that to the OSS 0-100 range is easy with a simple 
>>calculation, but if an OSS app just does Volume++, the change will be 
>>lost in the conversion from OSS to ALSA to actually set the state. So, 
>>to work the way it should, OSS will have to cache all mixer state in OSS 
>>format, thus requiring 2 state tables.
>>
>>E.g.
>>OSS Volume(0-100)   ALSA Volume(0-31)
>>OSS = ALSA * 100/31;
>>
>>0		    0
>>1                   0
>>2                   0
>>3                   1
>>4                   1
>>etc.
>>
>>So, if OSS Volume is 2, and the OSS application does Volume++, the OSS 
>>volume will be set to 3. but if OSS Volume is 3, and the OSS application 
>>does Volume++, the OSS volume will stay at 3!
> 
> 
> I don't undestand. Actually we have volumes in OSS format (in the kernel's 
> mixer emulation), because some applications simply does not work for 
> reason as you described (++ or -- applied). Note that these values are 
> valid per application (so the resolution is reverted to ALSA's when 
> another application changes volume too much). I don't see any other way to 
> do it.
> 
> 						Jaroslav
> 
> -----
> Jaroslav Kysela <perex@suse.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, SuSE Labs
> 
> 
Why is the OSS volume value kept for each application?
Surely, mixer volumes should be globally stored?
Or does the OSS volume for one application only control the volume of 
the sound from that particular application ?

What about the mixer open/close transition?
If a single application does: -
open
volume++
close
...
open
volume++
close

Will the OSS volume settings be reset from the alsa levels ?

Cheers
James





-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
