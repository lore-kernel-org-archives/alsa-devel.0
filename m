From: Mark Knecht <markknecht@comcast.net>
Subject: Re: hdsp driver and tools update
Date: Sat, 01 Nov 2003 06:01:58 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1067695317.1762.7.camel@Wizard.knechthome.com>
References: <1073.217.184.8.109.1067685592.squirrel@www.undata.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1073.217.184.8.109.1067685592.squirrel@www.undata.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Thomas Charbonnel <thomas@undata.org>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Sat, 2003-11-01 at 03:19, Thomas Charbonnel wrote:
> Hi,
> 
> I apologize for having been so silent the last few weeks, I was in the
> process of moving from Lyon, France to Berlin, Germany. This is now done,
> and I resumed my work on the hdsp driver and tools.
> Latest patches and tools can be found here :
> http://www.undata.org/~thomas/
> Mojor changes include support for hdsp 9632 cards and bugfixes for hdsp
> 9652 cards.
> Hdspconf and hdspmixer now support 96xx cards, though this needs testing
> as I do not have the hardware.
> 
> People testing this should remove their asound.state file from the way
> because the number or numid of ctls may have change.
> 
> Takashi, I noticed that though it's been in cvs for some time now,
> hdspconf is still not included in alsa-tools releases, is there a reason
> for this ?
> 
> Thomas
> 

Hi Thomas,
   Welcome back, and thanks for all the efforts. Your work has been so
helpful in getting my system running. It wouldn't be running without
you. 

   I really look forward to getting all of this into CVS and no longer
having to do patches!

   Thanks again.

Cheers,
Mark



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
