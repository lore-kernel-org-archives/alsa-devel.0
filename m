From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: buffer producer/consumer sync
Date: Wed, 31 Mar 2004 12:31:41 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <406AAC1D.1090406@superbug.demon.co.uk>
References: <20040331083114.C27804@flint.arm.linux.org.uk> <Pine.LNX.4.58.0403310936170.1950@pnote.perex-int.cz> <20040331085330.A30701@flint.arm.linux.org.uk> <Pine.LNX.4.58.0403311004040.1950@pnote.perex-int.cz> <20040331091124.B30701@flint.arm.linux.org.uk> <Pine.LNX.4.58.0403311027290.1950@pnote.perex-int.cz> <20040331095306.A32258@flint.arm.linux.org.uk> <Pine.LNX.4.58.0403311100510.1950@pnote.perex-int.cz> <20040331101018.B32258@flint.arm.linux.org.uk> <Pine.LNX.4.58.0403311118140.1950@pnote.perex-int.cz> <20040331102710.C32258@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20040331102710.C32258@flint.arm.linux.org.uk>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Russell King <rmk+alsa@arm.linux.org.uk>
Cc: Jaroslav Kysela <perex@suse.cz>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Russell King wrote:
> On Wed, Mar 31, 2004 at 11:22:56AM +0200, Jaroslav Kysela wrote:
> 
>>On Wed, 31 Mar 2004, Russell King wrote:
>>
>>
>>>I suggest we add a load of preprocessor junk into the ALSA core and
>>>comment exactly _why_ its needed, thereby laying the reason completely
>>>at the door of these ill-defined APIs where questions have been asked
>>>and responses not been received.
>>
>>I'm thinking to prepare more or less complete patch for all 
>>architectures and send it to LKML for a discussion.
> 
> 
> The problem is that not all architecture maintainers are on lkml.
> 
> Besides, I've tried talking to the architecture maintainers - their
> complete silence since two weeks ago indicates that they just don't
> want to know about this issue.
> 
> As I said on the architecture alias - I've put enough non-rewarding
> time into this issue.  I also have various commercial deadlines
> coming up, so I couldn't work on it even if I wanted to.
> 

If something is broken in the linux kernel (in this case for arm), and 
you submit a patch, and no-one else rejects it without suggesting a 
better way to do it, I can't see why your patch could justifiably being 
rejected.
Of course if no-one else even cares about the problem and you don't have 
write access to the kernel tree, the problem will continue.
I think this might be one of the cases of don't bother discussing it, 
create a patch to do the fix how you think best, and then post it.

One can always use the approach of providing a patch for the linux 
kernel separately, so that any users wishing to use alsa have to first 
apply the patch. At least users can use alsa with arm!

As arm is used on a majority of embedded systems, and as more and more 
embedded systems are using linux, the demand for your patches will 
certainly rise.

As you obviously have support from Jaroslav Kysela, one could probably 
make it so that alsa-driver fails to compile on arm, unless your patch 
is applied to the kernel first. That would certainly provide a BIG 
incentive for your patch to get including into the kernel.

I don't have an ARM platform running linux, but I definetly support your 
efforts to bring alsa to more different platforms.

My 2 cents....

James


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
