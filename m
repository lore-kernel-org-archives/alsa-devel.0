From: Mark Knecht <markknecht@attbi.com>
Subject: Re: hdsp driver status
Date: 14 Apr 2003 12:51:15 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1050349876.1457.8.camel@Wizard>
References: <1050314137.1382.23.camel@satellite.undata.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1050314137.1382.23.camel@satellite.undata.org>
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

Thomas,
   Thanks for the update. It's great to even know that you are actively
looking at it.

   Comments/questions embedded.

Thanks,
Mark

On Mon, 2003-04-14 at 02:55, Thomas Charbonnel wrote:
> Hi,
> 
> To summarize the current problems with the driver :
> 
> * there is a locking issue which has been found and solved (thanks again
> to Joshua N Pritikin). This was the cause of the freezes Mark and others
> have been experiencing. I need to clean the code up before submitting a
> patch (hopefully today).
> 
> * there is a problem with rev11 firmwares yet to be identified (the
> simplest reason could be that the firmware files are wrong)

I noticed that in my post to you yesterday that the Firmware in my card
was listed as 'Revision 1'.


Buffer Size (Latency): 1024 samples (2 periods of 4096 bytes)
Hardware pointer (frames): 0
Passthru: no
Line out: on
Firmware version: 1

Seems a bit strange, but could certainly be correct. Just pointing it
out.

> 
> * the way the matrix mixer is handled for hdsp9652 cards seems wrong.
> This could explain the absence of sound output Mark and others are
> reporting.
> 

I was hoping to hear whether ANY setup of the card was required by the
user to make mixer connections. I had understood (some months ago) that
maybe some 'amixer cset' commands were required to get an older
Hammerfall 9652 to actually output audio. Is this correct? If so, does
the HDSP 9652 require anything similar, as I am doing nothing like that.

Again, if there is anything I can do to help, please let me know.

Thanks,
Mark



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
