From: Rui Sousa <rui.sousa@laposte.net>
Subject: Re: Fix for mmap_test, better tests needed
Date: Tue, 13 Aug 2002 01:01:26 +0100 (WEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.33.0208130052140.2065-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0208121541210.14146-100000@marabou.research.att.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0208121541210.14146-100000@marabou.research.att.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Pavel Roskin <proski@gnu.org>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 12 Aug 2002, Pavel Roskin wrote:

I wrote some utils to test OSS drivers (or in your case the OSS 
interface of an ALSA driver). These can be found in the emu10k1 CVS tree
(at http://sourceforge.net/projects/emu10k1/) in the utils/oss-test 
directory.

Tests include:
play (blocking mode)
play using idle wait loop (non-blocking mode)
play using select (non-blocking mode)
play using mmap
rec (blocking mode)
rec using select (non-bloking mode)
query (asks for device capabilities)
stop-go write to the device, waits (untill the output is just silence), 
	writes again,...

Hope they can help you,

Rui Sousa

> Hello!
> 
> I was looking for some tests for the sound driver, and the only thing I
> found in ALSA CVS is some stuff in alsa-driver/test.  Before I continue my
> search for real tests (any pointers will be appreciated!) let me post a
> patch that makes mmap_test.c compile and work.
> 
> First of all, mmap_test.c should be converted from DOS to UNIX-style line
> ends before my patch is applied.
> 
> There is no "smpl" file in the alsa-driver/test directory, but we can 
> easily generate a sample.  sin() requires libm, hence the makefile change.
> 
> The necessary includes have been added to avoid warnings.  Unused 
> variables have been removed for the same reason.  If the "smpl" file 
> cannot be loaded, a sound of variable frequency is generated.
> 
> SNDCTL_DSP_SETPERIOD is undefined (google search gives 0 hits, I wonder 
> if this code ever compiled), but SNDCTL_DSP_SETFRAGMENT seems to do 
> exactly what we need.  info.periods has been replaced with info.fragsize 
> for the same reason.
> 
> Now mmap_test compiles without warnings and produces funky sounds.  
> Enjoy!
> 
> 



-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
